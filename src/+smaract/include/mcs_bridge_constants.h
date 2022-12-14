/**********************************************************************
Define bridge constants for routing bridge functions
**********************************************************************/

#ifndef MCS_BRIDGE_CONSTANTS_H
#define MCS_BRIDGE_CONSTANTS_H

/**********************************************************/
/* GLOBAL DEFINITIONS                                     */
/**********************************************************/

// @constants Global

#define BF_LIST_DEVICES                 0                                     
#define BF_SA_CTL_Open                  1     
#define BF_SA_CTL_Close                 2      
#define BF_SA_CTL_GetProperty_i32       3                             
#define BF_SA_CTL_GetProperty_i64       4                             
#define BF_SA_CTL_SetProperty_i32       5  
#define BF_SA_CTL_SetProperty_i64       6  
#define BF_SA_CTL_Reference             7
#define BA_SA_CTL_OpenFirstDevice       8
#define BF_IS_REFERENCED                9
#define BF_IS_CHANNEL_ACTIVE            10
#define BF_SA_SA_CTL_Stop               11
#define BF_SA_CTL_Calibrate             12
#define BF_SA_CTL_Move                  13

#endif // MCS_BRIDGE_CONSTANTS_H
