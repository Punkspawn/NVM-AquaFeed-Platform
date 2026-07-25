FUNCTION_BLOCK FB_Blower
VAR_INPUT
    xEnable : BOOL;
    xRunRequest : BOOL;
    xNormalStopRequest : BOOL;
    uiTargetFreqCentiHz : UINT;
    udiRequestedPostRunTimeMs : UDINT;
    udiCommandSequence : UDINT;
    udiResetSequence : UDINT;
    xSafetyOK : BOOL;
    xDriveReady : BOOL;
    xDriveRunning : BOOL;
    xDriveFault : BOOL;
    xCommunicationHealthy : BOOL;
    uiActualFreqCentiHz : UINT;
    uiDriveFaultCode : UINT;
    stConfig : ST_BlowerConfig;
    udiMonotonicTickMs : UDINT;
END_VAR
VAR_OUTPUT
    eState : E_BlowerState := BlowerDisabled;
    xDriveRunRequest : BOOL;
    uiDriveFreqCentiHz : UINT;
    xReady : BOOL;
    xRunning : BOOL;
    xAtSpeed : BOOL;
    xDosingPermitted : BOOL;
    uiDiagnosticCode : UINT;
    udiLastAcceptedSequence : UDINT;
END_VAR
VAR
    uiLatchedFreqCentiHz : UINT;
    udiLatchedPostRunTimeMs : UDINT;
    udiStateStartTickMs : UDINT;
    udiStableStartTickMs : UDINT;
    udiFeedbackLossStartTickMs : UDINT;
    udiLastResetSequence : UDINT;
    xHasAcceptedCommand : BOOL;
    xHasAcceptedReset : BOOL;
    xStableTimerActive : BOOL;
    xFeedbackLossTimerActive : BOOL;
    xConfigValid : BOOL;
    xFrequencyInTolerance : BOOL;
    diFrequencyError : DINT;
END_VAR
VAR CONSTANT
    c_uiDiagnosticNone : UINT := 0;
    c_uiDiagnosticConfig : UINT := 20;
    c_uiDiagnosticFrequencyRange : UINT := 21;
    c_uiDiagnosticDriveNotReady : UINT := 22;
    c_uiDiagnosticStartTimeout : UINT := 23;
    c_uiDiagnosticAccelerationTimeout : UINT := 24;
    c_uiDiagnosticFeedbackLoss : UINT := 25;
    c_uiDiagnosticStopTimeout : UINT := 26;
    c_uiDiagnosticPostRunTimeout : UINT := 27;
    c_uiDiagnosticCommunication : UINT := 28;
    c_uiDiagnosticDriveFault : UINT := 29;
    c_uiDiagnosticSafety : UINT := 30;
END_VAR

xDriveRunRequest := FALSE;
uiDriveFreqCentiHz := 0;
xReady := FALSE;
xRunning := FALSE;
xAtSpeed := FALSE;
xDosingPermitted := FALSE;

xConfigValid := (stConfig.uiMinimumFreqCentiHz > 0) AND
                (stConfig.uiMinimumFreqCentiHz <=
                 stConfig.uiMaximumFreqCentiHz) AND
                (stConfig.uiAtSpeedToleranceCentiHz > 0) AND
                (stConfig.udiAtSpeedStableTimeMs > 0) AND
                (stConfig.udiStartTimeoutMs > 0) AND
                (stConfig.udiAccelerationTimeoutMs > 0) AND
                (stConfig.udiFeedbackLossTimeoutMs > 0) AND
                (stConfig.udiStopTimeoutMs > 0) AND
                (stConfig.udiPostRunTimeMs > 0) AND
                (stConfig.udiMaximumPostRunTimeMs >=
                 stConfig.udiPostRunTimeMs);

diFrequencyError := UINT_TO_DINT(uiActualFreqCentiHz) -
                    UINT_TO_DINT(uiLatchedFreqCentiHz);
xFrequencyInTolerance :=
    ABS(diFrequencyError) <=
    UINT_TO_DINT(stConfig.uiAtSpeedToleranceCentiHz);

IF NOT xEnable THEN
    eState := BlowerDisabled;
    uiDiagnosticCode := c_uiDiagnosticNone;
    xStableTimerActive := FALSE;
    xFeedbackLossTimerActive := FALSE;
ELSIF NOT xSafetyOK THEN
    eState := BlowerFault;
    uiDiagnosticCode := c_uiDiagnosticSafety;
ELSIF xDriveFault THEN
    eState := BlowerFault;
    uiDiagnosticCode := c_uiDiagnosticDriveFault;
ELSIF NOT xCommunicationHealthy THEN
    eState := BlowerFault;
    uiDiagnosticCode := c_uiDiagnosticCommunication;
ELSIF NOT xConfigValid THEN
    eState := BlowerFault;
    uiDiagnosticCode := c_uiDiagnosticConfig;
ELSE
    CASE eState OF
        BlowerDisabled:
            eState := BlowerReady;
            uiDiagnosticCode := c_uiDiagnosticNone;

        BlowerReady:
            xReady := xDriveReady AND NOT xDriveRunning;

            IF xDriveRunning THEN
                eState := BlowerFault;
                uiDiagnosticCode := c_uiDiagnosticFeedbackLoss;
            ELSIF xRunRequest AND
                  (NOT xHasAcceptedCommand OR
                   (udiCommandSequence <> udiLastAcceptedSequence)) THEN
                udiLastAcceptedSequence := udiCommandSequence;
                xHasAcceptedCommand := TRUE;

                IF (uiTargetFreqCentiHz <
                    stConfig.uiMinimumFreqCentiHz) OR
                   (uiTargetFreqCentiHz >
                    stConfig.uiMaximumFreqCentiHz) OR
                   (udiRequestedPostRunTimeMs >
                    stConfig.udiMaximumPostRunTimeMs) THEN
                    uiDiagnosticCode := c_uiDiagnosticFrequencyRange;
                ELSIF NOT xDriveReady THEN
                    uiDiagnosticCode := c_uiDiagnosticDriveNotReady;
                ELSE
                    uiLatchedFreqCentiHz := uiTargetFreqCentiHz;
                    IF udiRequestedPostRunTimeMs > 0 THEN
                        udiLatchedPostRunTimeMs :=
                            udiRequestedPostRunTimeMs;
                    ELSE
                        udiLatchedPostRunTimeMs :=
                            stConfig.udiPostRunTimeMs;
                    END_IF;
                    udiStateStartTickMs := udiMonotonicTickMs;
                    xStableTimerActive := FALSE;
                    xFeedbackLossTimerActive := FALSE;
                    eState := BlowerStarting;
                    uiDiagnosticCode := c_uiDiagnosticNone;
                END_IF;
            END_IF;

        BlowerStarting:
            xDriveRunRequest := TRUE;
            uiDriveFreqCentiHz := uiLatchedFreqCentiHz;
            xRunning := xDriveRunning;

            IF xDriveRunning THEN
                udiStateStartTickMs := udiMonotonicTickMs;
                xStableTimerActive := FALSE;
                eState := BlowerAccelerating;
            ELSIF F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                             udiStartTickMs := udiStateStartTickMs) >=
                  stConfig.udiStartTimeoutMs THEN
                eState := BlowerFault;
                uiDiagnosticCode := c_uiDiagnosticStartTimeout;
            END_IF;

        BlowerAccelerating:
            xDriveRunRequest := TRUE;
            uiDriveFreqCentiHz := uiLatchedFreqCentiHz;
            xRunning := xDriveRunning;

            IF NOT xDriveRunning THEN
                eState := BlowerFault;
                uiDiagnosticCode := c_uiDiagnosticFeedbackLoss;
            ELSIF xFrequencyInTolerance THEN
                IF NOT xStableTimerActive THEN
                    udiStableStartTickMs := udiMonotonicTickMs;
                    xStableTimerActive := TRUE;
                ELSIF F_ElapsedMs(
                          udiCurrentTickMs := udiMonotonicTickMs,
                          udiStartTickMs := udiStableStartTickMs) >=
                      stConfig.udiAtSpeedStableTimeMs THEN
                    xStableTimerActive := FALSE;
                    eState := BlowerAtSpeed;
                    uiDiagnosticCode := c_uiDiagnosticNone;
                END_IF;
            ELSE
                xStableTimerActive := FALSE;
            END_IF;

            IF (eState = BlowerAccelerating) AND
               (F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                            udiStartTickMs := udiStateStartTickMs) >=
                stConfig.udiAccelerationTimeoutMs) THEN
                eState := BlowerFault;
                uiDiagnosticCode := c_uiDiagnosticAccelerationTimeout;
            END_IF;

        BlowerAtSpeed:
            xDriveRunRequest := TRUE;
            uiDriveFreqCentiHz := uiLatchedFreqCentiHz;
            xRunning := xDriveRunning;
            xAtSpeed := xDriveRunning AND xFrequencyInTolerance;
            xDosingPermitted := xAtSpeed AND xDriveReady;

            IF xNormalStopRequest OR NOT xRunRequest THEN
                udiStateStartTickMs := udiMonotonicTickMs;
                xFeedbackLossTimerActive := FALSE;
                eState := BlowerPostRun;
            ELSIF NOT xDriveRunning OR NOT xFrequencyInTolerance THEN
                IF NOT xFeedbackLossTimerActive THEN
                    udiFeedbackLossStartTickMs := udiMonotonicTickMs;
                    xFeedbackLossTimerActive := TRUE;
                ELSIF F_ElapsedMs(
                          udiCurrentTickMs := udiMonotonicTickMs,
                          udiStartTickMs := udiFeedbackLossStartTickMs) >=
                      stConfig.udiFeedbackLossTimeoutMs THEN
                    eState := BlowerFault;
                    uiDiagnosticCode := c_uiDiagnosticFeedbackLoss;
                END_IF;
            ELSE
                xFeedbackLossTimerActive := FALSE;
            END_IF;

        BlowerPostRun:
            xDriveRunRequest := TRUE;
            uiDriveFreqCentiHz := uiLatchedFreqCentiHz;
            xRunning := xDriveRunning;

            IF F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                           udiStartTickMs := udiStateStartTickMs) >=
               udiLatchedPostRunTimeMs THEN
                udiStateStartTickMs := udiMonotonicTickMs;
                eState := BlowerStopping;
            END_IF;

        BlowerStopping:
            IF NOT xDriveRunning THEN
                eState := BlowerReady;
                uiDiagnosticCode := c_uiDiagnosticNone;
            ELSIF F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                             udiStartTickMs := udiStateStartTickMs) >=
                  stConfig.udiStopTimeoutMs THEN
                eState := BlowerFault;
                uiDiagnosticCode := c_uiDiagnosticStopTimeout;
            END_IF;

        BlowerFault:
            IF (NOT xHasAcceptedReset OR
                (udiResetSequence <> udiLastResetSequence)) AND
               NOT xRunRequest AND
               NOT xNormalStopRequest AND
               xSafetyOK AND
               xCommunicationHealthy AND
               NOT xDriveFault AND
               NOT xDriveRunning AND
               xDriveReady THEN
                udiLastResetSequence := udiResetSequence;
                xHasAcceptedReset := TRUE;
                xStableTimerActive := FALSE;
                xFeedbackLossTimerActive := FALSE;
                eState := BlowerReady;
                uiDiagnosticCode := c_uiDiagnosticNone;
            END_IF;

    ELSE
        eState := BlowerFault;
        uiDiagnosticCode := c_uiDiagnosticConfig;
    END_CASE;
END_IF;

END_FUNCTION_BLOCK
