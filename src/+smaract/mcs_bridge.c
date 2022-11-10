


#include "mex.h"
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <inttypes.h>
#include "SmarActControl.h"
#include "mcs_bridge_constants.h"


#if defined(_WIN32)
#define  strtok_s
#endif

SA_CTL_Result_t result;
SA_CTL_DeviceHandle_t dHandle;


void revord(char *input_buf, size_t buflen, char *output_buf)
{
  mwSize i;

  if (buflen == 0) return;

  /* reverse the order of the input string */
  for(i=0;i<buflen-1;i++) 
    *(output_buf+i) = *(input_buf+buflen-i-2);
}



void exitOnError(SA_CTL_Result_t result) {
    if (result != SA_CTL_ERROR_NONE) {
        SA_CTL_Close(dHandle);
        // Passing an error code to "SA_CTL_GetResultInfo" returns a human readable string
        // specifying the error.
        printf("MCS2 %s (error: 0x%04x).\nPress return to exit.\n", SA_CTL_GetResultInfo(result), result);
    }
}

SA_CTL_Result_t MXB_LIST_DEVICES(){

    const char *version = SA_CTL_GetFullVersionString();
    printf("SmarActCTL library version: %s.\n", version);

    char deviceList[1024];
    size_t ioDeviceListLen = sizeof(deviceList);
    result = SA_CTL_FindDevices("", deviceList, &ioDeviceListLen);
    if (result != SA_CTL_ERROR_NONE) {
        printf("MCS2 failed to find devices.\n");
    }
    exitOnError(result);
    if (strlen(deviceList) == 0) {
        printf("MCS2 no devices found. Exit.\n");
        getchar();
        exit(1);
    } else {
        printf("MCS2 available devices:\n%s\n", deviceList);
    }

    return result;
}



SA_CTL_Result_t MXB_SA_CTL_Open(uint32_t* dhandle, const char* locator)
{
    mexPrintf("ROUTE: OPEN");

    // Open the first MCS2 device from the list
    result = SA_CTL_Open(&dHandle, locator, "");
    if (result != SA_CTL_ERROR_NONE) {
        printf("MCS2 failed to open \"%s\".\n",locator);
    }
    exitOnError(result);
    printf("MCS2 opened \"%s\".\n", locator);

     return result;
}

SA_CTL_Result_t MXB_SA_CTL_OpenFirstDevice(uint32_t* dhandle)
{

    char deviceList[1024];
    size_t ioDeviceListLen = sizeof(deviceList);
    result = SA_CTL_FindDevices("", deviceList, &ioDeviceListLen);
    if (result != SA_CTL_ERROR_NONE) {
        printf("MCS2 failed to find devices.\n");
    }
    exitOnError(result);
    if (strlen(deviceList) == 0) {
        printf("MCS2 no devices found. Exit.\n");
        getchar();
        exit(1);
    } else {
        printf("MCS2 available devices:\n%s\n", deviceList);
    }
    // Open the first MCS2 device from the list
    char *ptr;
    strtok(deviceList, "\n",&ptr);
    char *locator = deviceList;
    result = SA_CTL_Open(&dHandle, locator, "");
    if (result != SA_CTL_ERROR_NONE) {
        printf("MCS2 failed to open \"%s\".\n",locator);
    }
    exitOnError(result);
    printf("MCS2 opened \"%s\".\n", locator);

    return result;

}




void returnIfInsufficientArgs(int nrhs, int expected)
{
    if (nrhs < expected) {
        mexErrMsgIdAndTxt("mcs_bridge:invalidNumInputs",
            "Invalid number of inputs. Expected %d, got %d.", expected, nrhs);
    }
}

/* The gateway function */
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
    int8_t channel;
    int32_t val32;
    int64_t val64;
    SA_CTL_PropertyKey_t propertyKey;
    char *locator;

    if (nrhs == 0){
        mexPrintf("MCS2: No input arguments. ROUTE required\n");
        return;
    }

    // First argument is route, second argument is device handle
    if (nrhs > 1){
        dHandle = (SA_CTL_DeviceHandle_t) mxGetScalar(prhs[1]);
    }

    // Third argument is channel
    if (nrhs > 2){
        channel = (uint32_t) mxGetScalar(prhs[2]);
    }


    uint32_t route = (uint32_t) mxGetScalar(prhs[0]);

    switch(route){
        case BF_LIST_DEVICES:
            mexPrintf("ROUTE: BF_LIST_DEVICES\n");
            result = MXB_LIST_DEVICES();
            break;  
        case BF_SA_CTL_Open:
            mexPrintf("ROUTE: SA_CTL_Open\n");

            // require 2 arguments
            returnIfInsufficientArgs(nrhs, 2);

            locator = mxArrayToString(prhs[2]);
            result = MXB_SA_CTL_Open(dHandle, locator);

            plhs[0] = mxCreateDoubleScalar((double)dHandle);


            break;  

        case BA_SA_CTL_OpenFirstDevice:
            mexPrintf("ROUTE: BA_SA_CTL_OpenFirstDevice\n");
            result = MXB_SA_CTL_OpenFirstDevice(dHandle);
            plhs[0] = mxCreateDoubleScalar((double)dHandle);
            break;  
        break;
        case BF_SA_CTL_Close:
            mexPrintf("ROUTE: SA_CTL_Close\n");

            // require 2 arguments
            returnIfInsufficientArgs(nrhs, 1);

            result = SA_CTL_Close(dHandle);
            break;
        case BF_SA_CTL_Reference:
            mexPrintf("ROUTE: SA_CTL_Reference channel: %d.\n", channel);

            result = SA_CTL_SetProperty_i32(dHandle, channel, SA_CTL_PKEY_REFERENCING_OPTIONS, 0);
            exitOnError(result);
            // Set velocity to 1mm/s
            result = SA_CTL_SetProperty_i64(dHandle, channel, SA_CTL_PKEY_MOVE_VELOCITY, 1000000000);
            exitOnError(result);
            // Set acceleration to 10mm/s2.
            result = SA_CTL_SetProperty_i64(dHandle, channel, SA_CTL_PKEY_MOVE_ACCELERATION, 10000000000);
            exitOnError(result);

            result = SA_CTL_Reference(dHandle, channel, 0);

            break;
        case BF_SA_CTL_GetProperty_i64:
            mexPrintf("ROUTE: SA_CTL_GetProperty_i64\n");

            // require 4 arguments
            returnIfInsufficientArgs(nrhs, 4);

            // 4th argument is property name:
            propertyKey =(SA_CTL_PropertyKey_t) mxGetScalar(prhs[3]);

            result = SA_CTL_GetProperty_i64(dHandle, channel, propertyKey, &val64, 0);
            exitOnError(result);
            plhs[0]         = mxCreateDoubleScalar((double)val64);
            break;
        case BF_SA_CTL_GetProperty_i32:
            mexPrintf("ROUTE: SA_CTL_GetProperty_i32\n");

            // require 4 arguments
            returnIfInsufficientArgs(nrhs, 4);

            // 4th argument is property name:
            propertyKey = (SA_CTL_PropertyKey_t) mxGetScalar(prhs[3]);


            result = SA_CTL_GetProperty_i32(dHandle, channel, propertyKey, &val32, 0);
            exitOnError(result);
            plhs[0]         = mxCreateDoubleScalar((double)val32);
            break;
        case BF_SA_CTL_SetProperty_i64:
            mexPrintf("ROUTE: SA_CTL_SetProperty_i64\n");

            // require 5 arguments
            returnIfInsufficientArgs(nrhs, 5);

            // 4th argument is property name:
            propertyKey =(SA_CTL_PropertyKey_t) mxGetScalar(prhs[3]);
            // 5th argument is property value:
            val64 = (int64_t) mxGetScalar(prhs[4]);

            result = SA_CTL_SetProperty_i64(dHandle, channel, propertyKey, val64);
            exitOnError(result);

        break;
        case BF_SA_CTL_SetProperty_i32:
            mexPrintf("ROUTE: SA_CTL_SetProperty_i32\n");
           
            // require 5 arguments
            returnIfInsufficientArgs(nrhs, 5);

            // 4th argument is property name:
            propertyKey =(SA_CTL_PropertyKey_t) mxGetScalar(prhs[3]);
            // 5th argument is property value:
            val32 = (int32_t) mxGetScalar(prhs[4]);

            result = SA_CTL_SetProperty_i64(dHandle, channel, propertyKey, val32);
            exitOnError(result);

        break;



        default:
            mexPrintf("ROUTE: NO-ROUTE\n");
            break;
    }




    return;



    
}