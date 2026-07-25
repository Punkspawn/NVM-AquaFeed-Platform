FUNCTION_BLOCK FB_Dosing
VAR_INPUT
    xEnable : BOOL;
    xStartRequest : BOOL;
    xStopRequest : BOOL;
    udiCommandSequence : UDINT;
    udiResetSequence : UDINT;
    udiJobId : UDINT;
    uiOutletId : UINT;
    udiTargetCentiKg : UDINT;
    uiTargetSpeedPermille : UINT;
    udiCentiKgPer1000Pulses : UDINT;
    uiCalibrationVersion : UINT;
    xSelectorInPosition : BOOL;
    xBlowerAtSpeed : BOOL;
    xFeedAvailable : BOOL;
    xSafetyOK : BOOL;
    xDriveRunning : BOOL;
    xDriveFault : BOOL;
    xPulse : BOOL;
    stConfig : ST_DosingConfig;
    udiMonotonicTickMs : UDINT;
END_VAR
VAR_OUTPUT
    eState : E_DosingState := DosingDisabled;
    xMotorRunRequest : BOOL;
    uiSpeedPermille : UINT;
    xReady : BOOL;
    xRunning : BOOL;
    xFault : BOOL;
    xCompletedEvent : BOOL;
    udiDeliveredCentiKg : UDINT;
    udiDeliveredIncrementCentiKg : UDINT;
    uiDiagnosticCode : UINT;
    udiLastAcceptedSequence : UDINT;
END_VAR
VAR
    udiLatchedJobId : UDINT;
    uiLatchedOutletId : UINT;
    udiLatchedTargetCentiKg : UDINT;
    uiLatchedSpeedPermille : UINT;
    udiLatchedCentiKgPer1000Pulses : UDINT;
    uiLatchedCalibrationVersion : UINT;
    udiTransactionStartTickMs : UDINT;
    udiStateStartTickMs : UDINT;
    udiLastPulseTickMs : UDINT;
    udiPulseRemainder : UDINT;
    udiBaseIncrement : UDINT;
    udiRemainderStep : UDINT;
    udiPulseIncrement : UDINT;
    udiLastResetSequence : UDINT;
    xHasAcceptedCommand : BOOL;
    xHasAcceptedReset : BOOL;
    xCompletionPending : BOOL;
    xConfigValid : BOOL;
    xTransactionActive : BOOL;
    xParameterChanged : BOOL;
    xTargetReached : BOOL;
END_VAR
VAR CONSTANT
    c_uiDiagnosticNone : UINT := 0;
    c_uiDiagnosticConfig : UINT := 40;
    c_uiDiagnosticInvalidCommand : UINT := 41;
    c_uiDiagnosticInterlock : UINT := 42;
    c_uiDiagnosticDriveFault : UINT := 43;
    c_uiDiagnosticStartTimeout : UINT := 44;
    c_uiDiagnosticFirstPulseTimeout : UINT := 45;
    c_uiDiagnosticNoFlow : UINT := 46;
    c_uiDiagnosticExcessiveRate : UINT := 47;
    c_uiDiagnosticTargetTimeout : UINT := 48;
    c_uiDiagnosticStopTimeout : UINT := 49;
    c_uiDiagnosticUnexpectedPulse : UINT := 50;
    c_uiDiagnosticParameterChanged : UINT := 51;
    c_uiDiagnosticArithmetic : UINT := 52;
    c_uiDiagnosticFeedback : UINT := 53;
    c_uiDiagnosticStopped : UINT := 54;
END_VAR

xMotorRunRequest := FALSE;
uiSpeedPermille := 0;
xReady := FALSE;
xRunning := FALSE;
xFault := FALSE;
xCompletedEvent := FALSE;
udiDeliveredIncrementCentiKg := 0;
udiPulseIncrement := 0;

xConfigValid := (stConfig.udiMaximumTargetCentiKg > 0) AND
                (stConfig.udiMaximumCentiKgPer1000Pulses > 0) AND
                (stConfig.uiMinimumSpeedPermille > 0) AND
                (stConfig.uiMinimumSpeedPermille <= 1000) AND
                (stConfig.udiStartTimeoutMs > 0) AND
                (stConfig.udiFirstPulseTimeoutMs > 0) AND
                (stConfig.udiNoFlowTimeoutMs > 0) AND
                (stConfig.udiMinimumPulseIntervalMs > 0) AND
                (stConfig.udiTargetTimeoutMs > 0) AND
                (stConfig.udiStopTimeoutMs > 0);

xTransactionActive := (eState = DosingStarting) OR
                      (eState = DosingWaitFirstPulse) OR
                      (eState = DosingActive) OR
                      (eState = DosingStopping);

xParameterChanged := xTransactionActive AND
    ((udiJobId <> udiLatchedJobId) OR
     (uiOutletId <> uiLatchedOutletId) OR
     (udiTargetCentiKg <> udiLatchedTargetCentiKg) OR
     (uiTargetSpeedPermille <> uiLatchedSpeedPermille) OR
     (udiCentiKgPer1000Pulses <>
      udiLatchedCentiKgPer1000Pulses) OR
     (uiCalibrationVersion <> uiLatchedCalibrationVersion));

IF NOT xEnable THEN
    eState := DosingDisabled;
    uiDiagnosticCode := c_uiDiagnosticNone;
    xCompletionPending := FALSE;
ELSIF NOT xConfigValid THEN
    eState := DosingFault;
    uiDiagnosticCode := c_uiDiagnosticConfig;
ELSIF xDriveFault THEN
    eState := DosingFault;
    uiDiagnosticCode := c_uiDiagnosticDriveFault;
ELSIF xTransactionActive AND
      (NOT xSafetyOK OR
       NOT xSelectorInPosition OR
       NOT xBlowerAtSpeed OR
       NOT xFeedAvailable) THEN
    eState := DosingFault;
    uiDiagnosticCode := c_uiDiagnosticInterlock;
ELSIF ((eState = DosingWaitFirstPulse) OR
       (eState = DosingActive)) AND
      NOT xDriveRunning THEN
    eState := DosingFault;
    uiDiagnosticCode := c_uiDiagnosticFeedback;
ELSE
    IF xParameterChanged THEN
        uiDiagnosticCode := c_uiDiagnosticParameterChanged;
    END_IF;

    CASE eState OF
        DosingDisabled:
            eState := DosingReady;
            udiDeliveredCentiKg := 0;
            uiDiagnosticCode := c_uiDiagnosticNone;

        DosingReady:
            xReady := TRUE;

            IF xPulse THEN
                uiDiagnosticCode := c_uiDiagnosticUnexpectedPulse;
            END_IF;

            IF xStartRequest AND
               (NOT xHasAcceptedCommand OR
                (udiCommandSequence <> udiLastAcceptedSequence)) THEN
                udiLastAcceptedSequence := udiCommandSequence;
                xHasAcceptedCommand := TRUE;

                IF (udiJobId = 0) OR
                   (uiOutletId = 0) OR
                   (uiCalibrationVersion = 0) OR
                   (udiTargetCentiKg = 0) OR
                   (udiTargetCentiKg >
                    stConfig.udiMaximumTargetCentiKg) OR
                   (uiTargetSpeedPermille <
                    stConfig.uiMinimumSpeedPermille) OR
                   (uiTargetSpeedPermille > 1000) OR
                   (udiCentiKgPer1000Pulses = 0) OR
                   (udiCentiKgPer1000Pulses >
                    stConfig.udiMaximumCentiKgPer1000Pulses) THEN
                    uiDiagnosticCode := c_uiDiagnosticInvalidCommand;
                ELSIF NOT xSafetyOK OR
                      NOT xSelectorInPosition OR
                      NOT xBlowerAtSpeed OR
                      NOT xFeedAvailable OR
                      xDriveRunning THEN
                    uiDiagnosticCode := c_uiDiagnosticInterlock;
                ELSE
                    udiLatchedJobId := udiJobId;
                    uiLatchedOutletId := uiOutletId;
                    udiLatchedTargetCentiKg := udiTargetCentiKg;
                    uiLatchedSpeedPermille := uiTargetSpeedPermille;
                    udiLatchedCentiKgPer1000Pulses :=
                        udiCentiKgPer1000Pulses;
                    uiLatchedCalibrationVersion :=
                        uiCalibrationVersion;
                    udiDeliveredCentiKg := 0;
                    udiPulseRemainder := 0;
                    udiTransactionStartTickMs :=
                        udiMonotonicTickMs;
                    udiStateStartTickMs := udiMonotonicTickMs;
                    xCompletionPending := FALSE;
                    eState := DosingStarting;
                    uiDiagnosticCode := c_uiDiagnosticNone;
                END_IF;
            END_IF;

        DosingStarting:
            xMotorRunRequest := TRUE;
            uiSpeedPermille := uiLatchedSpeedPermille;
            xRunning := xDriveRunning;

            IF xStopRequest THEN
                xMotorRunRequest := FALSE;
                uiSpeedPermille := 0;
                udiStateStartTickMs := udiMonotonicTickMs;
                xCompletionPending := FALSE;
                eState := DosingStopping;
                uiDiagnosticCode := c_uiDiagnosticStopped;
            ELSIF xDriveRunning THEN
                udiStateStartTickMs := udiMonotonicTickMs;
                eState := DosingWaitFirstPulse;
            ELSIF F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                             udiStartTickMs := udiStateStartTickMs) >=
                  stConfig.udiStartTimeoutMs THEN
                eState := DosingFault;
                uiDiagnosticCode := c_uiDiagnosticStartTimeout;
            END_IF;

        DosingWaitFirstPulse:
            xMotorRunRequest := TRUE;
            uiSpeedPermille := uiLatchedSpeedPermille;
            xRunning := TRUE;

            IF xStopRequest THEN
                xMotorRunRequest := FALSE;
                uiSpeedPermille := 0;
                udiStateStartTickMs := udiMonotonicTickMs;
                xCompletionPending := FALSE;
                eState := DosingStopping;
                uiDiagnosticCode := c_uiDiagnosticStopped;
            ELSIF xPulse THEN
                udiBaseIncrement :=
                    udiLatchedCentiKgPer1000Pulses / 1000;
                udiRemainderStep :=
                    udiLatchedCentiKgPer1000Pulses MOD 1000;
                udiPulseIncrement := udiBaseIncrement;
                udiPulseRemainder :=
                    udiPulseRemainder + udiRemainderStep;

                IF udiPulseRemainder >= 1000 THEN
                    udiPulseRemainder := udiPulseRemainder - 1000;
                    udiPulseIncrement := udiPulseIncrement + 1;
                END_IF;

                IF udiDeliveredCentiKg >
                   (stConfig.udiMaximumTargetCentiKg -
                    udiPulseIncrement) THEN
                    udiDeliveredCentiKg :=
                        stConfig.udiMaximumTargetCentiKg;
                    eState := DosingFault;
                    uiDiagnosticCode := c_uiDiagnosticArithmetic;
                ELSE
                    udiDeliveredCentiKg :=
                        udiDeliveredCentiKg + udiPulseIncrement;
                    udiDeliveredIncrementCentiKg :=
                        udiPulseIncrement;
                    udiLastPulseTickMs := udiMonotonicTickMs;

                    xTargetReached :=
                        (udiDeliveredCentiKg >=
                         udiLatchedTargetCentiKg) OR
                        ((udiLatchedTargetCentiKg >
                          udiDeliveredCentiKg) AND
                         ((udiLatchedTargetCentiKg -
                           udiDeliveredCentiKg) <=
                          stConfig.udiCompletionToleranceCentiKg));

                    IF xTargetReached THEN
                        xMotorRunRequest := FALSE;
                        uiSpeedPermille := 0;
                        udiStateStartTickMs := udiMonotonicTickMs;
                        xCompletionPending := TRUE;
                        eState := DosingStopping;
                    ELSE
                        eState := DosingActive;
                    END_IF;
                END_IF;
            ELSIF F_ElapsedMs(
                      udiCurrentTickMs := udiMonotonicTickMs,
                      udiStartTickMs := udiStateStartTickMs) >=
                  stConfig.udiFirstPulseTimeoutMs THEN
                eState := DosingFault;
                uiDiagnosticCode := c_uiDiagnosticFirstPulseTimeout;
            END_IF;

        DosingActive:
            xMotorRunRequest := TRUE;
            uiSpeedPermille := uiLatchedSpeedPermille;
            xRunning := TRUE;

            IF xStopRequest THEN
                xMotorRunRequest := FALSE;
                uiSpeedPermille := 0;
                udiStateStartTickMs := udiMonotonicTickMs;
                xCompletionPending := FALSE;
                eState := DosingStopping;
                uiDiagnosticCode := c_uiDiagnosticStopped;
            ELSIF xPulse THEN
                IF F_ElapsedMs(
                       udiCurrentTickMs := udiMonotonicTickMs,
                       udiStartTickMs := udiLastPulseTickMs) <
                   stConfig.udiMinimumPulseIntervalMs THEN
                    eState := DosingFault;
                    uiDiagnosticCode := c_uiDiagnosticExcessiveRate;
                ELSE
                    udiBaseIncrement :=
                        udiLatchedCentiKgPer1000Pulses / 1000;
                    udiRemainderStep :=
                        udiLatchedCentiKgPer1000Pulses MOD 1000;
                    udiPulseIncrement := udiBaseIncrement;
                    udiPulseRemainder :=
                        udiPulseRemainder + udiRemainderStep;

                    IF udiPulseRemainder >= 1000 THEN
                        udiPulseRemainder :=
                            udiPulseRemainder - 1000;
                        udiPulseIncrement := udiPulseIncrement + 1;
                    END_IF;

                    IF udiDeliveredCentiKg >
                       (stConfig.udiMaximumTargetCentiKg -
                        udiPulseIncrement) THEN
                        udiDeliveredCentiKg :=
                            stConfig.udiMaximumTargetCentiKg;
                        eState := DosingFault;
                        uiDiagnosticCode := c_uiDiagnosticArithmetic;
                    ELSE
                        udiDeliveredCentiKg :=
                            udiDeliveredCentiKg +
                            udiPulseIncrement;
                        udiDeliveredIncrementCentiKg :=
                            udiPulseIncrement;
                        udiLastPulseTickMs := udiMonotonicTickMs;
                    END_IF;
                END_IF;
            ELSIF F_ElapsedMs(
                      udiCurrentTickMs := udiMonotonicTickMs,
                      udiStartTickMs := udiLastPulseTickMs) >=
                  stConfig.udiNoFlowTimeoutMs THEN
                eState := DosingFault;
                uiDiagnosticCode := c_uiDiagnosticNoFlow;
            END_IF;

            xTargetReached :=
                (udiDeliveredCentiKg >=
                 udiLatchedTargetCentiKg) OR
                ((udiLatchedTargetCentiKg >
                  udiDeliveredCentiKg) AND
                 ((udiLatchedTargetCentiKg -
                   udiDeliveredCentiKg) <=
                  stConfig.udiCompletionToleranceCentiKg));

            IF (eState = DosingActive) AND xTargetReached THEN
                xMotorRunRequest := FALSE;
                uiSpeedPermille := 0;
                udiStateStartTickMs := udiMonotonicTickMs;
                xCompletionPending := TRUE;
                eState := DosingStopping;
            ELSIF (eState = DosingActive) AND
                  (F_ElapsedMs(
                       udiCurrentTickMs := udiMonotonicTickMs,
                       udiStartTickMs := udiTransactionStartTickMs) >=
                   stConfig.udiTargetTimeoutMs) THEN
                eState := DosingFault;
                uiDiagnosticCode := c_uiDiagnosticTargetTimeout;
            END_IF;

        DosingStopping:
            IF NOT xDriveRunning THEN
                IF xCompletionPending THEN
                    eState := DosingComplete;
                ELSE
                    eState := DosingReady;
                END_IF;
            ELSIF F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                             udiStartTickMs := udiStateStartTickMs) >=
                  stConfig.udiStopTimeoutMs THEN
                eState := DosingFault;
                uiDiagnosticCode := c_uiDiagnosticStopTimeout;
            END_IF;

        DosingComplete:
            xCompletedEvent := TRUE;
            xCompletionPending := FALSE;
            eState := DosingReady;
            uiDiagnosticCode := c_uiDiagnosticNone;

        DosingFault:
            xFault := TRUE;

            IF (NOT xHasAcceptedReset OR
                (udiResetSequence <> udiLastResetSequence)) AND
               NOT xStartRequest AND
               NOT xDriveRunning AND
               NOT xDriveFault AND
               xSafetyOK AND
               xSelectorInPosition AND
               xBlowerAtSpeed AND
               xFeedAvailable THEN
                udiLastResetSequence := udiResetSequence;
                xHasAcceptedReset := TRUE;
                xCompletionPending := FALSE;
                eState := DosingReady;
                uiDiagnosticCode := c_uiDiagnosticNone;
            END_IF;

    ELSE
        eState := DosingFault;
        uiDiagnosticCode := c_uiDiagnosticConfig;
    END_CASE;
END_IF;

IF eState = DosingFault THEN
    xMotorRunRequest := FALSE;
    uiSpeedPermille := 0;
    xRunning := FALSE;
    xFault := TRUE;
    xCompletedEvent := FALSE;
END_IF;

END_FUNCTION_BLOCK
