FUNCTION_BLOCK FB_IOManager
VAR_INPUT
    stRawInputs : ST_IO;
    xHardwareConfigValid : BOOL;
    xWatchdogHealthy : BOOL;
    stRequestedOutputs : ST_IO;
    xOutputsPermitted : BOOL;
    xSafetyOK : BOOL;
    xCommissioningMode : BOOL;
    udiCommandSequence : UDINT;
END_VAR
VAR_OUTPUT
    stValidatedInputs : ST_IO;
    stAppliedOutputs : ST_IO;
    xReady : BOOL;
    xFault : BOOL;
    uiDiagnosticCode : UINT;
END_VAR
VAR
    xInitialized : BOOL;
    xApplyRequestedOutputs : BOOL;
    iChannel : INT;
END_VAR
VAR CONSTANT
    c_uiDiagnosticNone : UINT := 0;
    c_uiDiagnosticConfigInvalid : UINT := 10;
    c_uiDiagnosticModuleOffline : UINT := 11;
    c_uiDiagnosticWatchdog : UINT := 12;
    c_uiDiagnosticSafetyInhibit : UINT := 13;
    c_uiDiagnosticPermissionInhibit : UINT := 14;
    c_uiDiagnosticForceRejected : UINT := 15;
END_VAR

(* Inputs are copied once to create the immutable application snapshot. *)
FOR iChannel := 0 TO 63 DO
    stValidatedInputs.axDigitalInput[iChannel] := stRawInputs.axDigitalInput[iChannel];
    stValidatedInputs.axDigitalInputValid[iChannel] := stRawInputs.axDigitalInputValid[iChannel];
    stValidatedInputs.axDigitalOutput[iChannel] := FALSE;
    stValidatedInputs.axDigitalOutputValid[iChannel] := FALSE;
END_FOR;

FOR iChannel := 0 TO 15 DO
    stValidatedInputs.adiAnalogInput[iChannel] := stRawInputs.adiAnalogInput[iChannel];
    stValidatedInputs.axAnalogInputValid[iChannel] := stRawInputs.axAnalogInputValid[iChannel];
    stValidatedInputs.adiAnalogOutput[iChannel] := 0;
    stValidatedInputs.axAnalogOutputValid[iChannel] := FALSE;
END_FOR;

stValidatedInputs.xRequiredModulesOnline := stRawInputs.xRequiredModulesOnline;
stValidatedInputs.xForceActive := FALSE;
stValidatedInputs.uiInvalidInputCount := stRawInputs.uiInvalidInputCount;
stValidatedInputs.uiInvalidOutputCount := 0;
stValidatedInputs.uiOutputMismatchCount := 0;

xReady := xHardwareConfigValid AND
          xWatchdogHealthy AND
          stRawInputs.xRequiredModulesOnline;

xFault := NOT xHardwareConfigValid OR
          NOT xWatchdogHealthy OR
          NOT stRawInputs.xRequiredModulesOnline;

xApplyRequestedOutputs := xInitialized AND
                          xReady AND
                          xOutputsPermitted AND
                          xSafetyOK AND
                          NOT stRequestedOutputs.xForceActive;

uiDiagnosticCode := c_uiDiagnosticNone;

IF NOT xHardwareConfigValid THEN
    uiDiagnosticCode := c_uiDiagnosticConfigInvalid;
ELSIF NOT stRawInputs.xRequiredModulesOnline THEN
    uiDiagnosticCode := c_uiDiagnosticModuleOffline;
ELSIF NOT xWatchdogHealthy THEN
    uiDiagnosticCode := c_uiDiagnosticWatchdog;
ELSIF NOT xSafetyOK THEN
    uiDiagnosticCode := c_uiDiagnosticSafetyInhibit;
ELSIF NOT xOutputsPermitted THEN
    uiDiagnosticCode := c_uiDiagnosticPermissionInhibit;
ELSIF stRequestedOutputs.xForceActive THEN
    uiDiagnosticCode := c_uiDiagnosticForceRejected;
END_IF;

(* FALSE and zero are the current approved baseline safe image.
   A future non-zero safe channel requires an approved IO configuration. *)
FOR iChannel := 0 TO 63 DO
    stAppliedOutputs.axDigitalOutputValid[iChannel] :=
        stRequestedOutputs.axDigitalOutputValid[iChannel] AND xHardwareConfigValid;

    IF xApplyRequestedOutputs AND
       stRequestedOutputs.axDigitalOutputValid[iChannel] THEN
        stAppliedOutputs.axDigitalOutput[iChannel] :=
            stRequestedOutputs.axDigitalOutput[iChannel];
    ELSE
        stAppliedOutputs.axDigitalOutput[iChannel] := FALSE;
    END_IF;
END_FOR;

FOR iChannel := 0 TO 15 DO
    stAppliedOutputs.axAnalogOutputValid[iChannel] :=
        stRequestedOutputs.axAnalogOutputValid[iChannel] AND xHardwareConfigValid;

    IF xApplyRequestedOutputs AND
       stRequestedOutputs.axAnalogOutputValid[iChannel] THEN
        stAppliedOutputs.adiAnalogOutput[iChannel] :=
            stRequestedOutputs.adiAnalogOutput[iChannel];
    ELSE
        stAppliedOutputs.adiAnalogOutput[iChannel] := 0;
    END_IF;
END_FOR;

stAppliedOutputs.xRequiredModulesOnline := stRawInputs.xRequiredModulesOnline;
stAppliedOutputs.xForceActive := FALSE;
stAppliedOutputs.uiInvalidInputCount := stRawInputs.uiInvalidInputCount;
stAppliedOutputs.uiInvalidOutputCount := stRequestedOutputs.uiInvalidOutputCount;
stAppliedOutputs.uiOutputMismatchCount := 0;
stAppliedOutputs.uiDiagnosticCode := uiDiagnosticCode;

IF stAppliedOutputs.udiImageSequence < c_udiCounterMaximum THEN
    stAppliedOutputs.udiImageSequence :=
        stAppliedOutputs.udiImageSequence + 1;
END_IF;

stValidatedInputs.udiImageSequence := stAppliedOutputs.udiImageSequence;
stValidatedInputs.uiDiagnosticCode := uiDiagnosticCode;

(* Retained for deterministic diagnostics; level requests remain idempotent. *)
IF udiCommandSequence = c_udiCounterMaximum THEN
    udiCommandSequence := udiCommandSequence;
END_IF;

xInitialized := TRUE;

END_FUNCTION_BLOCK
