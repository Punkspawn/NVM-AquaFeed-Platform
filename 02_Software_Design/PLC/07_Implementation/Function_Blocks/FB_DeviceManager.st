FUNCTION_BLOCK FB_DeviceManager
VAR_INPUT
    uiDeviceId : UINT;
    uiDeviceType : UINT;
    usiLineId : USINT;
    xEnableConfig : BOOL;
    xAutoRequest : BOOL;
    xManualRequest : BOOL;
    xRunFeedback : BOOL;
    xFaultFeedback : BOOL;
    xInterlockOK : BOOL;
    xCommunicationOK : BOOL;
END_VAR
VAR_OUTPUT
    stDevice : ST_Device;
    xReady : BOOL;
    xCommandConflict : BOOL;
    xUnexpectedRunFeedback : BOOL;
    uiDiagnosticCode : UINT;
END_VAR
VAR
    xCommonRunPermission : BOOL;
END_VAR
VAR CONSTANT
    c_uiDiagnosticNone : UINT := 0;
    c_uiDiagnosticConfiguration : UINT := 10;
    c_uiDiagnosticDisabled : UINT := 20;
    c_uiDiagnosticModeConflict : UINT := 30;
    c_uiDiagnosticEquipmentFault : UINT := 40;
    c_uiDiagnosticInterlock : UINT := 50;
    c_uiDiagnosticCommunication : UINT := 60;
END_VAR

stDevice.uiDeviceId := uiDeviceId;
stDevice.uiDeviceType := uiDeviceType;
stDevice.usiLineId := usiLineId;
stDevice.xConfigurationValid :=
    (uiDeviceId <> 0) AND (uiDeviceType <> 0);
stDevice.xEnabled :=
    stDevice.xConfigurationValid AND xEnableConfig;
stDevice.xInterlockOK := xInterlockOK;
stDevice.xCommunicationOK := xCommunicationOK;

xCommandConflict := xAutoRequest AND xManualRequest;
stDevice.xAutoMode := FALSE;
stDevice.xManualMode := FALSE;

IF stDevice.xEnabled AND NOT xCommandConflict THEN
    stDevice.xAutoMode := xAutoRequest;
    stDevice.xManualMode := xManualRequest;
END_IF;

xCommonRunPermission :=
    stDevice.xConfigurationValid AND
    stDevice.xEnabled AND
    xInterlockOK AND
    xCommunicationOK AND
    NOT xFaultFeedback;

xUnexpectedRunFeedback :=
    xRunFeedback AND NOT xCommonRunPermission;

stDevice.xUnexpectedRunFeedback :=
    xUnexpectedRunFeedback;
stDevice.xFault :=
    xFaultFeedback OR xUnexpectedRunFeedback;
stDevice.xRunning :=
    xRunFeedback AND xCommonRunPermission;
stDevice.xAvailable :=
    stDevice.xConfigurationValid AND
    stDevice.xEnabled AND
    xInterlockOK AND
    xCommunicationOK AND
    NOT stDevice.xFault;

xReady :=
    stDevice.xAvailable AND
    (stDevice.xAutoMode XOR stDevice.xManualMode) AND
    NOT xCommandConflict;

IF NOT stDevice.xConfigurationValid THEN
    uiDiagnosticCode := c_uiDiagnosticConfiguration;
ELSIF NOT stDevice.xEnabled THEN
    uiDiagnosticCode := c_uiDiagnosticDisabled;
ELSIF xCommandConflict THEN
    uiDiagnosticCode := c_uiDiagnosticModeConflict;
ELSIF xFaultFeedback THEN
    uiDiagnosticCode := c_uiDiagnosticEquipmentFault;
ELSIF NOT xInterlockOK THEN
    uiDiagnosticCode := c_uiDiagnosticInterlock;
ELSIF NOT xCommunicationOK THEN
    uiDiagnosticCode := c_uiDiagnosticCommunication;
ELSE
    uiDiagnosticCode := c_uiDiagnosticNone;
END_IF;

stDevice.uiDiagnosticCode := uiDiagnosticCode;

END_FUNCTION_BLOCK
