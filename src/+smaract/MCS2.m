

%{
    MCS2 appears to have several changes over MCS1.  First, a device handle
    must be retrieved form SA_CTL_Open


%}


classdef MCS < smaract.MCSAbstract
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)

        % Constants pulled from the header file

        SA_CTL_INFINITE = (hex2dec('ffffffff'))
        SA_CTL_HOLD_TIME_INFINITE = -1

        SA_CTL_FALSE = hex2dec('00')
        SA_CTL_TRUE = hex2dec('01')
        SA_CTL_DISABLED = hex2dec('00')
        SA_CTL_ENABLED = hex2dec('01')
        SA_CTL_NON_INVERTED = hex2dec('00')
        SA_CTL_INVERTED = hex2dec('01')
        SA_CTL_FORWARD_DIRECTION = hex2dec('00')
        SA_CTL_BACKWARD_DIRECTION = hex2dec('01')
        SA_CTL_EITHER_DIRECTION = hex2dec('02')

        SA_CTL_STRING_MAX_LENGTH = 63
        SA_CTL_REQUEST_ID_MAX_COUNT = 240

      
        SA_CTL_INTERFACE_USB = hex2dec('0001')
        SA_CTL_INTERFACE_ETHERNET = hex2dec('0002');



        
        SA_CTL_EVENT_NONE = hex2dec('0000')

        SA_CTL_EVENT_MOVEMENT_FINISHED = hex2dec('0001')
        SA_CTL_EVENT_SENSOR_STATE_CHANGED = hex2dec('0002')
        SA_CTL_EVENT_REFERENCE_FOUND = hex2dec('0003')
        SA_CTL_EVENT_FOLLOWING_ERR_LIMIT = hex2dec('0004')
        SA_CTL_EVENT_HOLDING_ABORTED = hex2dec('0005')
        SA_CTL_EVENT_POSITIONER_TYPE_CHANGED = hex2dec('0006')
        SA_CTL_EVENT_PHASING_FINISHED = hex2dec('0007')
        SA_CTL_EVENT_AMP_STATE_CHANGED = hex2dec('000a')

        SA_CTL_EVENT_SM_STATE_CHANGED = hex2dec('4000')
        SA_CTL_EVENT_OVER_TEMPERATURE = hex2dec('4001')
        SA_CTL_EVENT_HIGH_VOLTAGE_OVERLOAD = hex2dec('4002')  // deprecated
        SA_CTL_EVENT_POWER_SUPPLY_OVERLOAD = hex2dec('4002')
        SA_CTL_EVENT_POWER_SUPPLY_FAILURE = hex2dec('4003')
        SA_CTL_EVENT_FAN_FAILURE_STATE_CHANGED = hex2dec('4004')
        SA_CTL_EVENT_ADJUSTMENT_FINISHED = hex2dec('4010')
        SA_CTL_EVENT_ADJUSTMENT_STATE_CHANGED = hex2dec('4011')
        SA_CTL_EVENT_ADJUSTMENT_UPDATE = hex2dec('4012')
        SA_CTL_EVENT_DIGITAL_INPUT_CHANGED = hex2dec('4040')
        SA_CTL_EVENT_SM_DIGITAL_INPUT_CHANGED = hex2dec('4041')

        SA_CTL_EVENT_STREAM_FINISHED = hex2dec('8000')
        SA_CTL_EVENT_STREAM_READY = hex2dec('8001')
        SA_CTL_EVENT_STREAM_TRIGGERED = hex2dec('8002')
        SA_CTL_EVENT_CMD_GROUP_TRIGGERED = hex2dec('8010')
        SA_CTL_EVENT_HM_STATE_CHANGED = hex2dec('8020')
        SA_CTL_EVENT_EMERGENCY_STOP_TRIGGERED = hex2dec('8030')
        SA_CTL_EVENT_EXT_INPUT_TRIGGERED = hex2dec('8040')
        SA_CTL_EVENT_BUS_RESYNC_TRIGGERED = hex2dec('8050')
        SA_CTL_EVENT_UNKNOWN_COMMAND_RECEIVED = hex2dec('8051')
        SA_CTL_EVENT_REQUEST_READY = hex2dec('f000')
        SA_CTL_EVENT_CONNECTION_LOST = hex2dec('f001')


       

        SA_CTL_EVENT_PARAM_DETACHED = hex2dec('00000000')
        SA_CTL_EVENT_PARAM_ATTACHED = hex2dec('00000001')
        SA_CTL_EVENT_PARAM_DISABLED = hex2dec('00000000')
        SA_CTL_EVENT_PARAM_ENABLED = hex2dec('00000001')

        SA_CTL_EVENT_REQ_READY_TYPE_READ = hex2dec('00')
        SA_CTL_EVENT_REQ_READY_TYPE_WRITE = hex2dec('01')

        SA_CTL_EVENT_PARAM_RESULT_MASK = hex2dec('0000ffff')
        SA_CTL_EVENT_PARAM_INDEX_MASK = hex2dec('00ff0000')
        SA_CTL_EVENT_PARAM_HANDLE_MASK = hex2dec('ff000000')


        SA_CTL_EVENT_REQ_READY_ID_MASK = hex2dec('00000000000000ff')
        SA_CTL_EVENT_REQ_READY_TYPE_MASK = hex2dec('000000000000ff00')
        SA_CTL_EVENT_REQ_READY_DATA_TYPE_MASK = hex2dec('0000000000ff0000')
        SA_CTL_EVENT_REQ_READY_ARRAY_SIZE_MASK = hex2dec('00000000ff000000')
        SA_CTL_EVENT_REQ_READY_PROPERTY_KEY_MASK = hex2dec('ffffffff00000000')


        %{ 
            /*********************************************************/
            /* ERROR CODES                                           */
            /*********************************************************/
        %}

        SA_CTL_ERROR_NONE = hex2dec('0000')
        SA_CTL_ERROR_UNKNOWN_COMMAND = hex2dec('0001')
        SA_CTL_ERROR_INVALID_PACKET_SIZE = hex2dec('0002')
        SA_CTL_ERROR_TIMEOUT = hex2dec('0004')
        SA_CTL_ERROR_INVALID_PROTOCOL = hex2dec('0005')
        SA_CTL_ERROR_BUFFER_UNDERFLOW = hex2dec('000c')
        SA_CTL_ERROR_BUFFER_OVERFLOW = hex2dec('000d')
        SA_CTL_ERROR_INVALID_FRAME_SIZE = hex2dec('000e')
        SA_CTL_ERROR_INVALID_PACKET = hex2dec('0010')
        SA_CTL_ERROR_INVALID_KEY = hex2dec('0012')
        SA_CTL_ERROR_INVALID_PARAMETER = hex2dec('0013')
        SA_CTL_ERROR_INVALID_DATA_TYPE = hex2dec('0016')
        SA_CTL_ERROR_INVALID_DATA = hex2dec('0017')
        SA_CTL_ERROR_HANDLE_LIMIT_REACHED = hex2dec('0018')
        SA_CTL_ERROR_ABORTED = hex2dec('0019')

        SA_CTL_ERROR_INVALID_DEVICE_INDEX = hex2dec('0020')
        SA_CTL_ERROR_INVALID_MODULE_INDEX = hex2dec('0021')
        SA_CTL_ERROR_INVALID_CHANNEL_INDEX = hex2dec('0022')

        SA_CTL_ERROR_PERMISSION_DENIED = hex2dec('0023')
        SA_CTL_ERROR_COMMAND_NOT_GROUPABLE = hex2dec('0024')
        SA_CTL_ERROR_MOVEMENT_LOCKED = hex2dec('0025')
        SA_CTL_ERROR_SYNC_FAILED = hex2dec('0026')
        SA_CTL_ERROR_INVALID_ARRAY_SIZE = hex2dec('0027')
        SA_CTL_ERROR_OVERRANGE = hex2dec('0028')
        SA_CTL_ERROR_INVALID_CONFIGURATION = hex2dec('0029')
        SA_CTL_ERROR_INVALID_GROUP_HANDLE = hex2dec('002a')

        SA_CTL_ERROR_NO_HM_PRESENT = hex2dec('0100')
        SA_CTL_ERROR_NO_IOM_PRESENT = hex2dec('0101')
        SA_CTL_ERROR_NO_SM_PRESENT = hex2dec('0102')
        SA_CTL_ERROR_NO_SENSOR_PRESENT = hex2dec('0103')
        SA_CTL_ERROR_SENSOR_DISABLED = hex2dec('0104')
        SA_CTL_ERROR_POWER_SUPPLY_DISABLED = hex2dec('0105')
        SA_CTL_ERROR_AMPLIFIER_DISABLED = hex2dec('0106')
        SA_CTL_ERROR_INVALID_SENSOR_MODE = hex2dec('0107')
        SA_CTL_ERROR_INVALID_ACTUATOR_MODE = hex2dec('0108')
        SA_CTL_ERROR_INVALID_INPUT_TRIG_MODE = hex2dec('0109')
        SA_CTL_ERROR_INVALID_CONTROL_OPTIONS = hex2dec('010a')
        SA_CTL_ERROR_INVALID_REFERENCE_TYPE = hex2dec('010b')
        SA_CTL_ERROR_INVALID_ADJUSTMENT_STATE = hex2dec('010c')
        SA_CTL_ERROR_INVALID_INFO_TYPE = hex2dec('010d')
        SA_CTL_ERROR_NO_FULL_ACCESS = hex2dec('010e')
        SA_CTL_ERROR_ADJUSTMENT_FAILED = hex2dec('010f')
        SA_CTL_ERROR_MOVEMENT_OVERRIDDEN = hex2dec('0110')
        SA_CTL_ERROR_NOT_CALIBRATED = hex2dec('0111')
        SA_CTL_ERROR_NOT_REFERENCED = hex2dec('0112')
        SA_CTL_ERROR_NOT_ADJUSTED = hex2dec('0113')
        SA_CTL_ERROR_SENSOR_TYPE_NOT_SUPPORTED = hex2dec('0114')
        SA_CTL_ERROR_CONTROL_LOOP_INPUT_DISABLED = hex2dec('0115')
        SA_CTL_ERROR_INVALID_CONTROL_LOOP_INPUT = hex2dec('0116')
        SA_CTL_ERROR_UNEXPECTED_SENSOR_DATA = hex2dec('0117')
        SA_CTL_ERROR_NOT_PHASED = hex2dec('0118')
        SA_CTL_ERROR_POSITIONER_FAULT = hex2dec('0119')
        SA_CTL_ERROR_DRIVER_FAULT = hex2dec('011a')
        SA_CTL_ERROR_POSITIONER_TYPE_NOT_SUPPORTED = hex2dec('011b')
        SA_CTL_ERROR_POSITIONER_TYPE_NOT_IDENTIFIED = hex2dec('011c')
        SA_CTL_ERROR_POSITIONER_TYPE_NOT_WRITEABLE = hex2dec('011e')
        SA_CTL_ERROR_INVALID_ACTUATOR_TYPE = hex2dec('0121')
        SA_CTL_ERROR_NO_COMMUTATION_SENSOR_PRESENT = hex2dec('0122')
        SA_CTL_ERROR_AMPLIFIER_LOCKED = hex2dec('0123')
        SA_CTL_ERROR_WRITE_ACCESS_LOCKED = hex2dec('0124')

        SA_CTL_ERROR_BUSY_MOVING = hex2dec('0150')
        SA_CTL_ERROR_BUSY_CALIBRATING = hex2dec('0151')
        SA_CTL_ERROR_BUSY_REFERENCING = hex2dec('0152')
        SA_CTL_ERROR_BUSY_ADJUSTING = hex2dec('0153')
        SA_CTL_ERROR_BUSY_CHANGING_AMP_STATE = hex2dec('0155')

        SA_CTL_ERROR_END_STOP_REACHED = hex2dec('0200')
        SA_CTL_ERROR_FOLLOWING_ERR_LIMIT = hex2dec('0201')
        SA_CTL_ERROR_RANGE_LIMIT_REACHED = hex2dec('0202')
        SA_CTL_ERROR_POSITIONER_OVERLOAD = hex2dec('0203')
        SA_CTL_ERROR_POWER_SUPPLY_FAILURE = hex2dec('0205')
        SA_CTL_ERROR_OVER_TEMPERATURE = hex2dec('0206')
        SA_CTL_ERROR_POWER_SUPPLY_OVERLOAD = hex2dec('0208')

        SA_CTL_ERROR_INVALID_STREAM_HANDLE = hex2dec('0300')
        SA_CTL_ERROR_INVALID_STREAM_CONFIGURATION = hex2dec('0301')
        SA_CTL_ERROR_INSUFFICIENT_FRAMES = hex2dec('0302')
        SA_CTL_ERROR_BUSY_STREAMING = hex2dec('0303')

        SA_CTL_ERROR_HM_INVALID_SLOT_INDEX = hex2dec('0400')
        SA_CTL_ERROR_HM_INVALID_CHANNEL_INDEX = hex2dec('0401')
        SA_CTL_ERROR_HM_INVALID_GROUP_INDEX = hex2dec('0402')
        SA_CTL_ERROR_HM_INVALID_CH_GRP_INDEX = hex2dec('0403')

        SA_CTL_ERROR_INTERNAL_COMMUNICATION = hex2dec('0500')
        SA_CTL_ERROR_EEPROM_BUFFER_OVERFLOW = hex2dec('0501')

        SA_CTL_ERROR_FEATURE_NOT_SUPPORTED = hex2dec('7ffd')
        SA_CTL_ERROR_FEATURE_NOT_IMPLEMENTED = hex2dec('7ffe')

        SA_CTL_ERROR_DEVICE_LIMIT_REACHED = hex2dec('f000')
        SA_CTL_ERROR_INVALID_LOCATOR = hex2dec('f001')
        SA_CTL_ERROR_INITIALIZATION_FAILED = hex2dec('f002')
        SA_CTL_ERROR_NOT_INITIALIZED = hex2dec('f003')
        SA_CTL_ERROR_COMMUNICATION_FAILED = hex2dec('f004')
        SA_CTL_ERROR_INVALID_QUERYBUFFER_SIZE = hex2dec('f006')
        SA_CTL_ERROR_INVALID_DEVICE_HANDLE = hex2dec('f007')
        SA_CTL_ERROR_INVALID_TRANSMIT_HANDLE = hex2dec('f008')
        SA_CTL_ERROR_UNEXPECTED_PACKET_RECEIVED = hex2dec('f00f')
        SA_CTL_ERROR_CANCELED = hex2dec('f010')
        SA_CTL_ERROR_DRIVER_FAILED = hex2dec('f013')
        SA_CTL_ERROR_BUFFER_LIMIT_REACHED = hex2dec('f016')
        SA_CTL_ERROR_INVALID_PROTOCOL_VERSION = hex2dec('f017')
        SA_CTL_ERROR_DEVICE_RESET_FAILED = hex2dec('f018')
        SA_CTL_ERROR_BUFFER_EMPTY = hex2dec('f019')
        SA_CTL_ERROR_DEVICE_NOT_FOUND = hex2dec('f01a')
        SA_CTL_ERROR_THREAD_LIMIT_REACHED = hex2dec('f01b')
        SA_CTL_ERROR_NO_APPLICATION = hex2dec('f01c')


%         /**********************************************************/
%       /* DATA TYPES                                             */
%       /**********************************************************/


        SA_CTL_DTYPE_UINT16 = hex2dec('03')
        SA_CTL_DTYPE_INT32 = hex2dec('06')
        SA_CTL_DTYPE_INT64 = hex2dec('0e')
        SA_CTL_DTYPE_FLOAT32 = hex2dec('10')
        SA_CTL_DTYPE_FLOAT64 = hex2dec('11')
        SA_CTL_DTYPE_STRING = hex2dec('12')
        SA_CTL_DTYPE_NONE = hex2dec('ff')


%         /**********************************************************/
%           /* BASE UNIT TYPES                                        */
%           /**********************************************************/

        SA_CTL_UNIT_NONE = hex2dec('00000000')
        SA_CTL_UNIT_PERCENT = hex2dec('00000001')
        SA_CTL_UNIT_METER = hex2dec('00000002')
        SA_CTL_UNIT_DEGREE = hex2dec('00000003')
        SA_CTL_UNIT_SECOND = hex2dec('00000004')
        SA_CTL_UNIT_HERTZ = hex2dec('00000005')


%         /**********************************************************/
        % /* PROPERTY KEYS                                          */
        % /**********************************************************/




        % // device
        SA_CTL_PKEY_NUMBER_OF_CHANNELS = hex2dec('020F0017')
        SA_CTL_PKEY_NUMBER_OF_BUS_MODULES = hex2dec('020F0016')
        SA_CTL_PKEY_INTERFACE_TYPE = hex2dec('020F0066')
        SA_CTL_PKEY_DEVICE_STATE = hex2dec('020F000F')
        SA_CTL_PKEY_DEVICE_SERIAL_NUMBER = hex2dec('020F005E')
        SA_CTL_PKEY_DEVICE_NAME = hex2dec('020F003D')
        SA_CTL_PKEY_EMERGENCY_STOP_MODE = hex2dec('020F0088')
        SA_CTL_PKEY_DEFAULT_EMERGENCY_STOP_MODE = hex2dec('020F0116')
        SA_CTL_PKEY_NETWORK_DISCOVER_MODE = hex2dec('020F0159')
        SA_CTL_PKEY_NETWORK_DHCP_TIMEOUT = hex2dec('020F015C')
        SA_CTL_PKEY_MIN_FAN_LEVEL = hex2dec('020F00DB')
        % // module
        SA_CTL_PKEY_POWER_SUPPLY_ENABLED = hex2dec('02030010')
        SA_CTL_PKEY_NUMBER_OF_BUS_MODULE_CHANNELS = hex2dec('02030017')
        SA_CTL_PKEY_MODULE_TYPE = hex2dec('02030066')
        SA_CTL_PKEY_MODULE_STATE = hex2dec('0203000F')
        % // positioner
        SA_CTL_PKEY_STARTUP_OPTIONS = hex2dec('0A02005D')
        SA_CTL_PKEY_AMPLIFIER_ENABLED = hex2dec('0302000D')
        SA_CTL_PKEY_AMPLIFIER_MODE = hex2dec('030200BF')
        SA_CTL_PKEY_POSITIONER_CONTROL_OPTIONS = hex2dec('0302005D')
        SA_CTL_PKEY_ACTUATOR_MODE = hex2dec('03020019')
        SA_CTL_PKEY_CONTROL_LOOP_INPUT = hex2dec('03020018')
        SA_CTL_PKEY_SENSOR_INPUT_SELECT = hex2dec('0302009D')
        SA_CTL_PKEY_POSITIONER_TYPE = hex2dec('0302003C')
        SA_CTL_PKEY_POSITIONER_TYPE_NAME = hex2dec('0302003D')
        SA_CTL_PKEY_MOVE_MODE = hex2dec('03050087')
        SA_CTL_PKEY_CHANNEL_TYPE = hex2dec('02020066')
        SA_CTL_PKEY_CHANNEL_STATE = hex2dec('0305000F')
        SA_CTL_PKEY_POSITION = hex2dec('0305001D')
        SA_CTL_PKEY_TARGET_POSITION = hex2dec('0305001E')
        SA_CTL_PKEY_SCAN_POSITION = hex2dec('0305001F')
        SA_CTL_PKEY_SCAN_VELOCITY = hex2dec('0305002A')
        SA_CTL_PKEY_HOLD_TIME = hex2dec('03050028')
        SA_CTL_PKEY_MOVE_VELOCITY = hex2dec('03050029')
        SA_CTL_PKEY_MOVE_ACCELERATION = hex2dec('0305002B')
        SA_CTL_PKEY_MAX_CL_FREQUENCY = hex2dec('0305002F')
        SA_CTL_PKEY_DEFAULT_MAX_CL_FREQUENCY = hex2dec('03050057')
        SA_CTL_PKEY_STEP_FREQUENCY = hex2dec('0305002E')
        SA_CTL_PKEY_STEP_AMPLITUDE = hex2dec('03050030')
        SA_CTL_PKEY_FOLLOWING_ERROR_LIMIT = hex2dec('03050055')
        SA_CTL_PKEY_FOLLOWING_ERROR = hex2dec('03020055')
        SA_CTL_PKEY_FOLLOWING_ERROR_MAX = hex2dec('05020055')
        SA_CTL_PKEY_BROADCAST_STOP_OPTIONS = hex2dec('0305005D')
        SA_CTL_PKEY_SENSOR_POWER_MODE = hex2dec('03080019')
        SA_CTL_PKEY_SENSOR_POWER_SAVE_DELAY = hex2dec('03080054')
        SA_CTL_PKEY_POSITION_MEAN_SHIFT = hex2dec('03090022')
        SA_CTL_PKEY_SAFE_DIRECTION = hex2dec('03090027')
        SA_CTL_PKEY_CL_INPUT_SENSOR_VALUE = hex2dec('0302001D')
        SA_CTL_PKEY_CL_INPUT_AUX_VALUE = hex2dec('030200B2')
        SA_CTL_PKEY_TARGET_TO_ZERO_VOLTAGE_HOLD_TH = hex2dec('030200B9')
        SA_CTL_PKEY_CH_EMERGENCY_STOP_MODE = hex2dec('02020088')
        SA_CTL_PKEY_IN_POSITION_THRESHOLD = hex2dec('03050058')
        SA_CTL_PKEY_IN_POSITION_DELAY = hex2dec('03050054')
        SA_CTL_PKEY_MOTOR_LOAD_PROTECTION_THRESHOLD = hex2dec('03020115')
        SA_CTL_PKEY_BRAKE_OFF_DELAY = hex2dec('03050117')
        SA_CTL_PKEY_BRAKE_ON_DELAY = hex2dec('03050118')

        % // scale
        SA_CTL_PKEY_LOGICAL_SCALE_OFFSET = hex2dec('02040024')
        SA_CTL_PKEY_LOGICAL_SCALE_INVERSION = hex2dec('02040025')
        SA_CTL_PKEY_RANGE_LIMIT_MIN = hex2dec('02040020')
        SA_CTL_PKEY_RANGE_LIMIT_MAX = hex2dec('02040021')
        SA_CTL_PKEY_DEFAULT_RANGE_LIMIT_MIN = hex2dec('020400C0')
        SA_CTL_PKEY_DEFAULT_RANGE_LIMIT_MAX = hex2dec('020400C1')
        % // calibration
        SA_CTL_PKEY_CALIBRATION_OPTIONS = hex2dec('0306005D')
        SA_CTL_PKEY_SIGNAL_CORRECTION_OPTIONS = hex2dec('0306001C')
        % // referencing
        SA_CTL_PKEY_REFERENCING_OPTIONS = hex2dec('0307005D')
        SA_CTL_PKEY_DIST_CODE_INVERTED = hex2dec('0307000E')
        SA_CTL_PKEY_DISTANCE_TO_REF_MARK = hex2dec('030700A2')
        % // tuning and customizing
        SA_CTL_PKEY_POS_MOVEMENT_TYPE = hex2dec('0309003F')
        SA_CTL_PKEY_POS_IS_CUSTOM_TYPE = hex2dec('03090041')
        SA_CTL_PKEY_POS_BASE_UNIT = hex2dec('03090042')
        SA_CTL_PKEY_POS_BASE_RESOLUTION = hex2dec('03090043')
        SA_CTL_PKEY_POS_HEAD_TYPE = hex2dec('0309008E')
        SA_CTL_PKEY_POS_REF_TYPE = hex2dec('03090048')
        SA_CTL_PKEY_POS_P_GAIN = hex2dec('0309004B')
        SA_CTL_PKEY_POS_I_GAIN = hex2dec('0309004C')
        SA_CTL_PKEY_POS_D_GAIN = hex2dec('0309004D')
        SA_CTL_PKEY_POS_PID_SHIFT = hex2dec('0309004E')
        SA_CTL_PKEY_POS_ANTI_WINDUP = hex2dec('0309004F')
        SA_CTL_PKEY_POS_ESD_DIST_TH = hex2dec('03090050')
        SA_CTL_PKEY_POS_ESD_COUNTER_TH = hex2dec('03090051')
        SA_CTL_PKEY_POS_TARGET_REACHED_TH = hex2dec('03090052')
        SA_CTL_PKEY_POS_TARGET_HOLD_TH = hex2dec('03090053')
        SA_CTL_PKEY_POS_SAVE = hex2dec('0309000A')
        SA_CTL_PKEY_POS_WRITE_PROTECTION = hex2dec('0309000D')
        % // streaming
        SA_CTL_PKEY_STREAM_BASE_RATE = hex2dec('040F002C')
        SA_CTL_PKEY_STREAM_EXT_SYNC_RATE = hex2dec('040F002D')
        SA_CTL_PKEY_STREAM_OPTIONS = hex2dec('040F005D')
        SA_CTL_PKEY_STREAM_LOAD_MAX = hex2dec('040F0301')
        % // diagnostic
        SA_CTL_PKEY_CHANNEL_ERROR = hex2dec('0502007A')
        SA_CTL_PKEY_CHANNEL_TEMPERATURE = hex2dec('05020034')
        SA_CTL_PKEY_BUS_MODULE_TEMPERATURE = hex2dec('05030034')
        SA_CTL_PKEY_POSITIONER_FAULT_REASON = hex2dec('05020113')
        SA_CTL_PKEY_MOTOR_LOAD = hex2dec('05020115')
        SA_CTL_PKEY_DIAG_CLOSED_LOOP_FREQUENCY_AVG = hex2dec('0502002e')
        SA_CTL_PKEY_DIAG_CLOSED_LOOP_FREQUENCY_MAX = hex2dec('0502002f')
        SA_CTL_PKEY_DIAG_CLF_MEASURE_TIME_BASE = hex2dec('050200c6')
        % // io module
        SA_CTL_PKEY_IO_MODULE_OPTIONS = hex2dec('0603005D')
        SA_CTL_PKEY_IO_MODULE_VOLTAGE = hex2dec('06030031')
        SA_CTL_PKEY_IO_MODULE_ANALOG_INPUT_RANGE = hex2dec('060300A0')
        % // sensor module
        SA_CTL_PKEY_SENSOR_MODULE_OPTIONS = hex2dec('080B005D')
        % // auxiliary
        SA_CTL_PKEY_AUX_POSITIONER_TYPE = hex2dec('0802003C')
        SA_CTL_PKEY_AUX_POSITIONER_TYPE_NAME = hex2dec('0802003D')
        SA_CTL_PKEY_AUX_INPUT_SELECT = hex2dec('08020018')
        SA_CTL_PKEY_AUX_IO_MODULE_INPUT_INDEX = hex2dec('081100AA')
        SA_CTL_PKEY_AUX_SENSOR_MODULE_INPUT_INDEX = hex2dec('080B00AA')
        SA_CTL_PKEY_AUX_IO_MODULE_INPUT0_VALUE = hex2dec('08110000')
        SA_CTL_PKEY_AUX_IO_MODULE_INPUT1_VALUE = hex2dec('08110001')
        SA_CTL_PKEY_AUX_SENSOR_MODULE_INPUT0_VALUE = hex2dec('080B0000')
        SA_CTL_PKEY_AUX_SENSOR_MODULE_INPUT1_VALUE = hex2dec('080B0001')
        SA_CTL_PKEY_AUX_DIRECTION_INVERSION = hex2dec('0809000E')
        SA_CTL_PKEY_AUX_DIGITAL_INPUT_VALUE = hex2dec('080300AD')
        SA_CTL_PKEY_AUX_SM_DIGITAL_INPUT_VALUE = hex2dec('080B00AD')
        SA_CTL_PKEY_AUX_DIGITAL_OUTPUT_VALUE = hex2dec('080300AE')
        SA_CTL_PKEY_AUX_DIGITAL_OUTPUT_SET = hex2dec('080300B0')
        SA_CTL_PKEY_AUX_DIGITAL_OUTPUT_CLEAR = hex2dec('080300B1')
        SA_CTL_PKEY_AUX_ANALOG_OUTPUT_VALUE0 = hex2dec('08030000')
        SA_CTL_PKEY_AUX_ANALOG_OUTPUT_VALUE1 = hex2dec('08030001')
        SA_CTL_PKEY_AUX_CORRECTION_MAX = hex2dec('080200D8')
        % // threshold detector
        SA_CTL_PKEY_THD_INPUT_SELECT = hex2dec('09020018')
        SA_CTL_PKEY_THD_IO_MODULE_INPUT_INDEX = hex2dec('091100AA')
        SA_CTL_PKEY_THD_SENSOR_MODULE_INPUT_INDEX = hex2dec('090B00AA')
        SA_CTL_PKEY_THD_THRESHOLD_HIGH = hex2dec('090200B4')
        SA_CTL_PKEY_THD_THRESHOLD_LOW = hex2dec('090200B5')
        SA_CTL_PKEY_THD_INVERSION = hex2dec('0902000E')
        % // input trigger
        SA_CTL_PKEY_DEV_INPUT_TRIG_SELECT = hex2dec('060D009D')
        SA_CTL_PKEY_DEV_INPUT_TRIG_MODE = hex2dec('060D0087')
        SA_CTL_PKEY_DEV_INPUT_TRIG_CONDITION = hex2dec('060D005A')
        SA_CTL_PKEY_DEV_INPUT_TRIG_DEBOUNCE = hex2dec('060D0058')
        SA_CTL_PKEY_CH_INPUT_TRIG_SELECT = hex2dec('0615009D')
        SA_CTL_PKEY_CH_INPUT_TRIG_MODE = hex2dec('06150087')
        SA_CTL_PKEY_CH_INPUT_TRIG_CONDITION = hex2dec('0615005A')
        % // output trigger
        SA_CTL_PKEY_CH_OUTPUT_TRIG_MODE = hex2dec('060E0087')
        SA_CTL_PKEY_CH_OUTPUT_TRIG_POLARITY = hex2dec('060E005B')
        SA_CTL_PKEY_CH_OUTPUT_TRIG_PULSE_WIDTH = hex2dec('060E005C')
        SA_CTL_PKEY_CH_POS_COMP_START_THRESHOLD = hex2dec('060E0058')
        SA_CTL_PKEY_CH_POS_COMP_INCREMENT = hex2dec('060E0059')
        SA_CTL_PKEY_CH_POS_COMP_DIRECTION = hex2dec('060E0026')
        SA_CTL_PKEY_CH_POS_COMP_LIMIT_MIN = hex2dec('060E0020')
        SA_CTL_PKEY_CH_POS_COMP_LIMIT_MAX = hex2dec('060E0021')
        % // hand control module
        SA_CTL_PKEY_HM_STATE = hex2dec('020C000F')
        SA_CTL_PKEY_HM_LOCK_OPTIONS = hex2dec('020C0083')
        SA_CTL_PKEY_HM_DEFAULT_LOCK_OPTIONS = hex2dec('020C0084')
        % // api
        SA_CTL_PKEY_API_EVENT_NOTIFICATION_OPTIONS = hex2dec('F010005D')
        % SA_CTL_PKEY_EVENT_NOTIFICATION_OPTIONS = hex2dec('F010005D')  // deprecated
        SA_CTL_PKEY_API_AUTO_RECONNECT = hex2dec('F01000A1')
        % SA_CTL_PKEY_AUTO_RECONNECT = hex2dec('F01000A1')  // deprecated


        % // device states
        SA_CTL_DEV_STATE_BIT_HM_PRESENT = hex2dec('00000001')
        SA_CTL_DEV_STATE_BIT_MOVEMENT_LOCKED = hex2dec('00000002')
        SA_CTL_DEV_STATE_BIT_AMPLIFIER_LOCKED = hex2dec('00000004')
        SA_CTL_DEV_STATE_BIT_IO_MODULE_INPUT = hex2dec('00000008')
        SA_CTL_DEV_STATE_BIT_GLOBAL_INPUT = hex2dec('00000010')
        SA_CTL_DEV_STATE_BIT_INTERNAL_COMM_FAILURE = hex2dec('00000100')
        SA_CTL_DEV_STATE_BIT_IS_STREAMING = hex2dec('00001000')
        SA_CTL_DEV_STATE_BIT_EEPROM_BUSY = hex2dec('00010000')

        % // @constants ModuleState
        SA_CTL_MOD_STATE_BIT_SM_PRESENT = hex2dec('00000001')
        SA_CTL_MOD_STATE_BIT_BOOSTER_PRESENT = hex2dec('00000002')
        SA_CTL_MOD_STATE_BIT_ADJUSTMENT_ACTIVE = hex2dec('00000004')
        SA_CTL_MOD_STATE_BIT_IOM_PRESENT = hex2dec('00000008')
        SA_CTL_MOD_STATE_BIT_INTERNAL_COMM_FAILURE = hex2dec('00000100')
        SA_CTL_MOD_STATE_BIT_FAN_FAILURE = hex2dec('00000800')
        SA_CTL_MOD_STATE_BIT_POWER_SUPPLY_FAILURE = hex2dec('00001000')
        % SA_CTL_MOD_STATE_BIT_HIGH_VOLTAGE_FAILURE = hex2dec('00001000')  // deprecated
        SA_CTL_MOD_STATE_BIT_POWER_SUPPLY_OVERLOAD = hex2dec('00002000')
        % SA_CTL_MOD_STATE_BIT_HIGH_VOLTAGE_OVERLOAD = hex2dec('00002000')  // deprecated
        SA_CTL_MOD_STATE_BIT_OVER_TEMPERATURE = hex2dec('00004000')
        SA_CTL_MOD_STATE_BIT_EEPROM_BUSY = hex2dec('00010000')


        % // @constants ChannelState
        SA_CTL_CH_STATE_BIT_ACTIVELY_MOVING = hex2dec('00000001')
        SA_CTL_CH_STATE_BIT_CLOSED_LOOP_ACTIVE = hex2dec('00000002')
        SA_CTL_CH_STATE_BIT_CALIBRATING = hex2dec('00000004')
        SA_CTL_CH_STATE_BIT_REFERENCING = hex2dec('00000008')
        SA_CTL_CH_STATE_BIT_MOVE_DELAYED = hex2dec('00000010')
        SA_CTL_CH_STATE_BIT_SENSOR_PRESENT = hex2dec('00000020')
        SA_CTL_CH_STATE_BIT_IS_CALIBRATED = hex2dec('00000040')
        SA_CTL_CH_STATE_BIT_IS_REFERENCED = hex2dec('00000080')
        SA_CTL_CH_STATE_BIT_END_STOP_REACHED = hex2dec('00000100')
        SA_CTL_CH_STATE_BIT_RANGE_LIMIT_REACHED = hex2dec('00000200')
        SA_CTL_CH_STATE_BIT_FOLLOWING_LIMIT_REACHED = hex2dec('00000400')
        SA_CTL_CH_STATE_BIT_MOVEMENT_FAILED = hex2dec('00000800')
        SA_CTL_CH_STATE_BIT_IS_STREAMING = hex2dec('00001000')
        SA_CTL_CH_STATE_BIT_POSITIONER_OVERLOAD = hex2dec('00002000')
        SA_CTL_CH_STATE_BIT_OVER_TEMPERATURE = hex2dec('00004000')
        SA_CTL_CH_STATE_BIT_REFERENCE_MARK = hex2dec('00008000')
        SA_CTL_CH_STATE_BIT_IS_PHASED = hex2dec('00010000')
        SA_CTL_CH_STATE_BIT_POSITIONER_FAULT = hex2dec('00020000')
        SA_CTL_CH_STATE_BIT_AMPLIFIER_ENABLED = hex2dec('00040000')
        SA_CTL_CH_STATE_BIT_IN_POSITION = hex2dec('00080000')
        SA_CTL_CH_STATE_BIT_BRAKE_ENABLED = hex2dec('00100000')

        SA_CTL_HM_STATE_BIT_INTERNAL_COMM_FAILURE = hex2dec('00000100')
        SA_CTL_HM_STATE_BIT_IS_INTERNAL = hex2dec('00000200')
        SA_CTL_HM_STATE_BIT_EEPROM_BUSY = hex2dec('00010000')


        SA_CTL_MOVE_MODE_CL_ABSOLUTE                       = 0
        SA_CTL_MOVE_MODE_CL_RELATIVE                       = 1
        SA_CTL_MOVE_MODE_SCAN_ABSOLUTE                     = 2
        SA_CTL_MOVE_MODE_SCAN_RELATIVE                     = 3
        SA_CTL_MOVE_MODE_STEP                              = 4

    end
    
    properties (Access = private)
        
        % S
        % {char 1xm} tcp/ip host
        cHost = '192.168.20.24'
        cPort = '5000'

        dNumChannels = 1
        u32CLFrequency = 6000
        u32MaxHoldTime = this.SA_CTL_INFINITE

        dVelocity = 1000000000
        dAcceleration = 1000000000
        
        cNameOfLib
        cPathDll
        cPathHeader
        
        oDeviceHandle % {uint 32 1x1} a libpointer is passed into SA_OpenSystem and populated with a uint32
        
        lDebug = false
    end
    
    methods
        function this = MCS(varargin)
            
            this.setDefaultPathOfDllAndHeader();

            for k = 1 : 2: length(varargin)
                this.msg(sprintf('passed in %s', varargin{k}));
                if this.hasProp( varargin{k})
                    this.msg(sprintf('settting %s', varargin{k}));
                    this.(varargin{k}) = varargin{k + 1};
                end
            end
            
            this.init()
        end
        
        
        
        %@param {uint32} absolute position to move to in pm
        function goToPositionAbsolute(this, u32Channel, i64Position)
            
            
             if (this.getIsMoving(u32Channel))
                 return
             end
              
            u32Status  = calllib(...
                this.cNameOfLib, ...
                'SA_CTL_Move', ...
                this.oDeviceHandle, ...
                u32Channel, ...
                i64Position, ...
                0 ...
            );
        
            this.printStatusOfError(u32Status);
            
        end
        
        
        function calibrate(this, u32Channel)
            
            u32Status  = calllib(...
                this.cNameOfLib, ...
                'SA_CTL_Calibrate', ...
                this.oDeviceHandle, ...
                u32Channel, ...
                0 ...
            );
        
            this.printStatusOfError(u32Status);
        end

        function findReferenceMark(this, u32Channel)

            u32HoldTimeSeconds = uint32(0);
            u32Status  = calllib(...
                this.cNameOfLib, ...
                'SA_CTL_Reference', ...
                this.oDeviceHandle, ...
                u32Channel, ...
                0 ...
            );
        
            this.printStatusOfError(u32Status);

        end

        
        function l = getIsReferenced(this, u32Channel)
            
            [u32Status, u32Known]  = calllib(...
                this.cNameOfLib, ...
                'SA_GetPhysicalPositionKnown_S', ...
                this.oDeviceHandle, ...
                u32Channel, ....
                0 ... % u32 pointer required
            );
        
            this.printStatusOfError(u32Status);
            l = u32Known == this.SA_PHYSICAL_POSITION_KNOWN;
            
        end
        
        
        function l = getIsMoving(this, u32Channel)
            u32Status = this.getStatusOfMovement(u32Channel);
            l = false;
            if (...
                u32Status == this.SA_TARGET_STATUS || ... 
                u32Status == this.SA_STEPPING_STATUS || ...
                u32Status == this.SA_SCANNING_STATUS ...
            ) 
                l = true;
            end
        end
        
        % returns the position of the sensor in nm
        function i64Position = getPosition(this, u32Channel)
            i64Position = this.getPropertyI64(u32Channel, 'SA_CTL_PKEY_POSITION');
        end
        
        function runTest(this)
            
            this.getSystemLocator();
            this.getSensorEnabled();
            
        end
        
        function delete(this)
            
            this.closeSystem()
        end
        
        
        
        

    end
    
    methods (Access = protected)
        
        function c = getSystemLocator(this)
            
            % Need to have a buffer size of 30 to accommodate the
            % longest possible locator which is formatted as
            % network:xxx.xxx.xxx.xxx:yyyy
            
            [u32Status, c, u32Size] = calllib(...
                this.cNameOfLib, ...
                'SA_GetSystemLocator', ...
                this.oDeviceHandle, ...
                blanks(30), ...
                30 ...
             );
            
         
            this.printStatusOfError(u32Status);
            
            %{
            
            % Create a variable to store the location to be populated
            cLoc = blanks(30);  % empty char class
            
            % Create a pointer to the location
            ptrLoc = libpointer('stringPtr', cLoc);
            
            % Create a variable to store the size of the populated output
            % buffer
            size = 30;
            % Create a pointer to it
            ptrSize = libpointer('uint32Ptr', size);
            
            
            [u32Status, cString, ptrA]  = calllib(...
                this.cNameOfLib, ...
                'SA_GetSystemLocator', ...
                this.oDeviceHandle, ...
                ptrLoc, ...
                ptrSize ...
            )
            %}
                
            
        end
        
        
        
        function closeSystem(this)
            
            u32Status = calllib(...
                this.cNameOfLib, ...
                'SA_CloseSystem', ...
                this.oDeviceHandle ...
            );
        
            this.printStatusOfError(u32Status)

            
        end

       
        function printStatusOfMovement(this, u32Status)
       
            if (~this.lDebug) 
                return; 
            end
            
            switch u32Status
            case 0
                c = 'SA_STOPPED_STATUS';
            case 1
                c = 'SA_STEPPING_STATUS';
            case 2
                c = 'SA_SCANNING_STATUS';
            case 3 
                c = 'SA_HOLDING_STATUS';
            case 4
                c = 'SA_TARGET_STATUS';
            case 5
                c = 'SA_MOVE_DELAY_STATUS';
            case 6
                c = 'SA_CALIBRATING_STATUS';
            case 7
                c = 'SA_FINDING_REF_STATUS';
            case 8
                c = 'SA_OPENING_STATUS';
                
            end
            
            fprintf('Status of movement: %u, %s\n', u32Status, c);

        end
        
        function printSensorMode(this, u32Mode)
            
            if (~this.lDebug) 
                return; 
            end
           
            switch u32Mode
                case 0
                    c = 'SA_SENSOR_DISABLED';
                case 1
                    c = 'SA_SENSOR_ENABLED';
                case 2
                    c = 'SA_SENSOR_POWERSAVE';
            end
            fprintf('Sensor mode: %u, %s\n', u32Mode, c);
                    
            
        end
        
        function printStatusOfError(this, u32Status)
            
            if (~this.lDebug) 
                return; 
            end
            
            switch u32Status
            case 0
                c = 'SA_OK';
            case 1
                c = 'SA_INITIALIZATION_ERROR';
            case 2
                c = 'SA_NOT_INITIALIZED_ERROR';
            case 3
                c = 'SA_NO_SYSTEMS_FOUND_ERROR';                 
            case 4
                c = 'SA_TOO_MANY_SYSTEMS_ERROR';
            case 5
                c = 'SA_INVALID_SYSTEM_INDEX_ERROR';    
            case 6 
                c='SA_INVALID_CHANNEL_INDEX_ERROR';
            case 7 
                c='SA_TRANSMIT_ERROR';
            case 8 
                c='SA_WRITE_ERROR';
            case 9 
                c='SA_INVALID_PARAMETER_ERROR';
            case 10 
                c='SA_READ_ERROR';
            case 12 
                c='SA_INTERNAL_ERROR';
            case 13 
                c='SA_WRONG_MODE_ERROR';
            case 14 
                c='SA_PROTOCOL_ERROR';
            case 15 
                c='SA_TIMEOUT_ERROR';
            case 17 
                c='SA_ID_LIST_TOO_SMALL_ERROR';
            case 18 
                c='SA_SYSTEM_ALREADY_ADDED_ERROR';
            case 19 
                c='SA_WRONG_CHANNEL_TYPE_ERROR';
            case 20 
                c='SA_CANCELED_ERROR';
            case 21
                c='SA_INVALID_SYSTEM_LOCATOR_ERROR';
            case 22 
                c='SA_INPUT_BUFFER_OVERFLOW_ERROR';
            case 23 
                c='SA_QUERYBUFFER_SIZE_ERROR';
            case 24 
                c='SA_DRIVER_ERROR';
            case 25 
                c='SA_COMPATIBILITY_ERROR';
            case 128 
                c='SA_NO_SUCH_SLAVE_ERROR';
            case 129 
                c='SA_NO_SENSOR_PRESENT_ERROR';
            case 130
                 c='SA_AMPLITUDE_TOO_LOW_ERROR';
            case 131 
                c='SA_AMPLITUDE_TOO_HIGH_ERROR';
            case 132 
                c='SA_FREQUENCY_TOO_LOW_ERROR';
            case 133 
                c='SA_FREQUENCY_TOO_HIGH_ERROR';
            case 135 
                c='SA_SCAN_TARGET_TOO_HIGH_ERROR';
            case 136 
                c='SA_SCAN_SPEED_TOO_LOW_ERROR';
            case 137 
                c='SA_SCAN_SPEED_TOO_HIGH_ERROR';
            case 140 
                c='SA_SENSOR_DISABLED_ERROR';
            case 141 
                c='SA_COMMAND_OVERRIDDEN_ERROR';
            case 142
                 c='SA_END_STOP_REACHED_ERROR';
            case 143
                 c='SA_WRONG_SENSOR_TYPE_ERROR';
            case 144 
                c='SA_COULD_NOT_FIND_REF_ERROR';
            case 145 
                c='SA_WRONG_END_EFFECTOR_TYPE_ERROR';
            case 146 
                c='SA_MOVEMENT_LOCKED_ERROR';
            case 147 
                c='SA_RANGE_LIMIT_REACHED_ERROR';
            case 148 
                c='SA_PHYSICAL_POSITION_UNKNOWN_ERROR';
            case 149 
                c='SA_OUTPUT_BUFFER_OVERFLOW_ERROR';
            case 150 
                c='SA_COMMAND_NOT_PROCESSABLE_ERROR';
            case 151 
                c='SA_WAITING_FOR_TRIGGER_ERROR';
            case 152 
                c='SA_COMMAND_NOT_TRIGGERABLE_ERROR';
            case 153
                 c='SA_COMMAND_QUEUE_FULL_ERROR';
            case 154 
                c='SA_INVALID_COMPONENT_ERROR';
            case 155 
                c='SA_INVALID_SUB_COMPONENT_ERROR';
            case 156 
                c='SA_INVALID_PROPERTY_ERROR';
            case 157 
                c='SA_PERMISSION_DENIED_ERROR';
            case 160 
                c='SA_CALIBRATION_FAILED_ERROR';
            case 240 
                c='SA_UNKNOWN_COMMAND_ERROR';
            case 255 
                c='SA_OTHER_ERROR';
            end
            
            fprintf('Status: %u, %s\n', u32Status, c);


        end
        
        % Convert a relative directory path into a canonical path
        % i.e., C:\A\B\..\C becomes C:\A\C.  Uses java io interface
        
        function c = path2canonical(this, cPath)
           jFile = java.io.File(cPath);
           c = char(jFile.getCanonicalPath);
        end
        
        function setDefaultPathOfDllAndHeader(this)
            
            cDir = fileparts(mfilename('fullpath'));
            cDirSdk = fullfile(cDir, '..', '..', 'SDK');
            cArch = computer('arch');
            
            switch cArch
                case 'win64'
                    this.cNameOfLib = 'MCSControl'; % The name of the .dll file
                    this.cPathDll = fullfile(cDirSdk, 'lib64', 'MCSControl.dll');
                    this.cPathHeader = fullfile(cDirSdk, 'include', 'MCSControl.h');
                    
                otherwise
                    % Assume 32-bit
                    this.cNameOfLib = 'MCSControl'; % The name of the .dll file
                    this.cPathDll = fullfile(cDirSdk, 'lib', 'MCSControl.dll');
                    this.cPathHeader = fullfile(cDirSdk, 'include', 'MCSControl.h');
            end
            
            % convert to canonical
            this.cPathDll = this.path2canonical(this.cPathDll);
            this.cPathHeader = this.path2canonical(this.cPathHeader);
                        
            
       end

        
       function l = hasProp(this, c)
            
            l = false;
            if ~isempty(findprop(this, c))
                l = true;
            end
            
       end
       
       
        function msg(this, cMsg)
            fprintf('smaract.MCS %s\n', cMsg);
        end
       
        
        function init(this)
            
             if ~libisloaded(this.cNameOfLib)
                loadlibrary(...
                    this.cPathDll, ...
                    this.cPathHeader ...
                );
             end
            
             this.openSystem();

             for k = 1:this.dNumChannels
                uint32ChannelNumber = uint32(k - 1);
                this.setPropertyU32(uint32ChannelNumber, 'SA_CTL_PKEY_MAX_CL_FREQUENCY', this.u32CLFrequency);
                this.setPropertyU32(uint32ChannelNumber, 'SA_CTL_PKEY_HOLD_TIME', this.u32MaxHoldTime);

                % All moves will be absolute
                this.setPropertyU32(uint32ChannelNumber, 'SA_CTL_PKEY_MOVE_MODE', this.SA_CTL_MOVE_MODE_CL_ABSOLUTE);
                this.setPropertyU32(uint32ChannelNumber, 'SA_CTL_PKEY_MOVE_VELOCITY', this.dVelocity);
                this.setPropertyU32(uint32ChannelNumber, 'SA_CTL_PKEY_MOVE_ACCELERATION', this.dAcceleration);

                % Set referencing options to return to 0 after referencing
                this.setPropertyU32(uint32ChannelNumber, 'SA_CTL_PKEY_REFERENCING_OPTIONS', 0);
                this.setPropertyU32(uint32ChannelNumber, 'SA_CTL_PKEY_CALIBRATION_OPTIONS', 0);

            end
            
        end



        function u32Val = setPropertyU32(this, u32Channel, u32Property, u32Val)
            [u32Status, u32StatusOfMovement] = calllib(...
                this.cNameOfLib, ...
                'SA_CTL_SetProperty_i32', ...
                this.oDeviceHandle, ...
                u32Channel, ...
                u32Property, ...
                u32Val ...
            );
        end

        function u32Val = getPropertyU32(this, u32Channel, u32Property)
            u32Val = 0;
            u32Pointer = libpointer('uint32Ptr', u32Val);
            [u32Status, u32StatusOfMovement] = calllib(...
                this.cNameOfLib, ...
                'SA_CTL_GetProperty_i32', ...
                this.oDeviceHandle, ...
                u32Channel, ...
                u32Property, ...
                u32Pointer, ...
                0 ...
            );

            this.printStatusOfError(u32Status);
        end

        function i64Val = getPropertyI64(this, u32Channel, u32Property)
            i64Val = 0;
            i64Pointer = libpointer('int64Ptr', i64Val);
            [u32Status, u32StatusOfMovement] = calllib(...
                this.cNameOfLib, ...
                'SA_CTL_GetProperty_i32', ...
                this.oDeviceHandle, ...
                u32Channel, ...
                u32Property, ...
                i64Pointer, ...
                0 ...
            );

            this.printStatusOfError(u32Status);
        end


        
        
        function u32StatusOfMovement = getStatusOfMovement(this, u32Channel)
            
            [u32Status, u32StatusOfMovement] = calllib(...
                this.cNameOfLib, ...
                'SA_GetStatus_S', ...
                this.oDeviceHandle, ...
                u32Channel, ...
                0 ...
            );

            this.printStatusOfError(u32Status);
            this.printStatusOfMovement(u32StatusOfMovement)
                    
        end
        
       

        function closeSystem(this)

            u32Status  = calllib(...
                this.cNameOfLib, ...
                'SA_CTL_Close', ...
                this.oDeviceHandle ...
            );

            if u32Status == this.SA_CTL_ERROR_NONE
                this.msg('device closed successfully.');
            else
                this.msg('error closing device.');
                this.printStatusOfError(u32Status);
            end

        end
        
        function openSystem(this)
            
            % SA_OpenSystem
            cLocation = sprintf('network:%s:%s', this.cHost, this.cPort);
            cOptions = 'sync, reset';  
            
            % IMPORTANT
            % if you use double quotes around characters, this is a
            % string class in matlab
            % - if you use single quotes around characters, this is a
            % char class in matlab.  
            
            % @return {double} dId - systemIndex (handle) to the system.  The
            % returned systemIndex must be saved within the application and
            % passed as a parameter to the API functions.
            
            % Per the MCS Programmers Guide, page 44,  SA_OpenSystem function
            % takes a pointer of type SA_INDEX,
            % the SA_INDEX type is defined in the header file as a type:
            % typedef unsigned int SA_INDEX;
            
            % Per the MCS Programmers Guide, page 44, SA_OpenSystem returns
            % a type SA_STATUS which is defined in the header file as 
            % typedef unsigned int SA_STATUS;

            
            % Create a variable to store the system index to be populated
            % by SA_CTL_Open
            oDeviceHandle = 0;

            
            % Define a pointer to this variable
            deviceHandlePtr = libpointer('uint32Ptr', oDeviceHandle);
                    
            u32Status  = calllib(...
                this.cNameOfLib, ...
                'SA_CTL_Open', ...
                deviceHandlePtr, ...
                cLocation, ...
                cOptions ...
            );
        
            if u32Status == this.SA_CTL_ERROR_NONE
                this.msg('device opened successfully.');
                this.oDeviceHandle = deviceHandlePtr.Value;
            else
                this.msg('error opening device.');
                this.printStatusOfError(u32Status);
            end
                        
            
        end

        
    end
    
end

