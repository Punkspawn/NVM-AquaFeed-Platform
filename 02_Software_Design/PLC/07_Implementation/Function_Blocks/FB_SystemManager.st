FUNCTION_BLOCK FB_SystemManager
VAR_INPUT
    xEnable : BOOL;
    xStart : BOOL;
    xStop : BOOL;
    xPause : BOOL;
    xReset : BOOL;

    xAutoRequest : BOOL;
    xManualRequest : BOOL;
    xServiceRequest : BOOL;
    xSimulationRequest : BOOL;

    xEmergencyStop : BOOL;
    xSafetyOK : BOOL;
    xBlockingFault : BOOL;
    xAllRequiredLinesReady : BOOL;
    xAnyLineRunning : BOOL;
    xAllLinesStopped : BOOL;
    xDesktopCommunicationOK : BOOL;
    xAlarmActive : BOOL;

    xFeedingActive : BOOL;
    usiCurrentLine : USINT;
    uiActiveRecipeId : UINT;
    udiCurrentJobId : UDINT;
END_VAR
VAR_IN_OUT
    stSystemStatus : ST_SystemStatus;
END_VAR
VAR_OUTPUT
    xSystemReady : BOOL;
    xLineEnable : BOOL;
    xModeConflict : BOOL;
    xResetAccepted : BOOL;
END_VAR
VAR
    eState : E_SystemState := SYSTEM_OFF;
    uiRequestedModeCount : UINT;
    xAutoModeValid : BOOL;
    xStartEdge : BOOL;
    xStopEdge : BOOL;
    xPauseEdge : BOOL;
    xResetEdge : BOOL;
    xPreviousStart : BOOL;
    xPreviousStop : BOOL;
    xPreviousPause : BOOL;
    xPreviousReset : BOOL;
END_VAR

xStartEdge := xStart AND NOT xPreviousStart;
xStopEdge := xStop AND NOT xPreviousStop;
xPauseEdge := xPause AND NOT xPreviousPause;
xResetEdge := xReset AND NOT xPreviousReset;
xResetAccepted := FALSE;

uiRequestedModeCount := 0;
IF xAutoRequest THEN
    uiRequestedModeCount := uiRequestedModeCount + 1;
END_IF;
IF xManualRequest THEN
    uiRequestedModeCount := uiRequestedModeCount + 1;
END_IF;
IF xServiceRequest THEN
    uiRequestedModeCount := uiRequestedModeCount + 1;
END_IF;
IF xSimulationRequest THEN
    uiRequestedModeCount := uiRequestedModeCount + 1;
END_IF;

xModeConflict := uiRequestedModeCount > 1;
xAutoModeValid := xAutoRequest AND
                  (uiRequestedModeCount = 1);

IF xEmergencyStop THEN
    eState := SYSTEM_EMERGENCY;
ELSIF NOT xSafetyOK OR xBlockingFault THEN
    eState := SYSTEM_FAULT;
ELSIF NOT xEnable THEN
    eState := SYSTEM_OFF;
ELSE
    CASE eState OF
        SYSTEM_OFF:
            eState := SYSTEM_INITIALIZING;

        SYSTEM_INITIALIZING:
            IF (uiRequestedModeCount = 1) AND
               xAllRequiredLinesReady THEN
                eState := SYSTEM_READY;
            END_IF;

        SYSTEM_READY:
            IF xStopEdge THEN
                eState := SYSTEM_STOPPING;
            ELSIF (uiRequestedModeCount <> 1) THEN
                eState := SYSTEM_INITIALIZING;
            ELSIF xStartEdge AND xAutoModeValid AND
                  xAllRequiredLinesReady THEN
                eState := SYSTEM_RUNNING;
            END_IF;

        SYSTEM_RUNNING:
            IF xStopEdge OR NOT xAutoModeValid THEN
                eState := SYSTEM_STOPPING;
            ELSIF xPauseEdge THEN
                eState := SYSTEM_PAUSED;
            END_IF;

        SYSTEM_PAUSED:
            IF xStopEdge OR NOT xAutoModeValid THEN
                eState := SYSTEM_STOPPING;
            ELSIF xStartEdge AND
                  xAllRequiredLinesReady THEN
                eState := SYSTEM_RUNNING;
            END_IF;

        SYSTEM_STOPPING:
            IF xAllLinesStopped THEN
                IF (uiRequestedModeCount = 1) AND
                   xAllRequiredLinesReady THEN
                    eState := SYSTEM_READY;
                ELSE
                    eState := SYSTEM_INITIALIZING;
                END_IF;
            END_IF;

        SYSTEM_FAULT:
            IF xResetEdge AND xAllLinesStopped THEN
                xResetAccepted := TRUE;
                eState := SYSTEM_INITIALIZING;
            END_IF;

        SYSTEM_EMERGENCY:
            IF xResetEdge AND xAllLinesStopped THEN
                xResetAccepted := TRUE;
                eState := SYSTEM_INITIALIZING;
            END_IF;

    ELSE
        eState := SYSTEM_FAULT;
    END_CASE;
END_IF;

xSystemReady := eState = SYSTEM_READY;
xLineEnable := xAutoModeValid AND
               xSafetyOK AND
               NOT xEmergencyStop AND
               NOT xBlockingFault AND
               ((eState = SYSTEM_READY) OR
                (eState = SYSTEM_RUNNING) OR
                (eState = SYSTEM_PAUSED));

stSystemStatus.SystemState := eState;
stSystemStatus.SystemReady := xSystemReady;
stSystemStatus.SystemRunning := eState = SYSTEM_RUNNING;
stSystemStatus.SystemPaused := eState = SYSTEM_PAUSED;
stSystemStatus.SystemStopped := xAllLinesStopped AND
                                NOT xAnyLineRunning;
stSystemStatus.AutoMode := xAutoModeValid;
stSystemStatus.ManualMode := xManualRequest AND
                             (uiRequestedModeCount = 1);
stSystemStatus.ServiceMode := xServiceRequest AND
                              (uiRequestedModeCount = 1);
stSystemStatus.SimulationMode :=
    xSimulationRequest AND (uiRequestedModeCount = 1);
stSystemStatus.ModeConflict := xModeConflict;
stSystemStatus.SafetyOK := xSafetyOK;
stSystemStatus.EmergencyStop := xEmergencyStop;
stSystemStatus.BlockingFault := xBlockingFault;
stSystemStatus.AlarmActive := xAlarmActive;
stSystemStatus.DesktopCommunicationOK :=
    xDesktopCommunicationOK;
stSystemStatus.AllRequiredLinesReady :=
    xAllRequiredLinesReady;
stSystemStatus.AnyLineRunning := xAnyLineRunning;
stSystemStatus.FeedingActive :=
    xFeedingActive AND xAnyLineRunning;

IF stSystemStatus.FeedingActive THEN
    stSystemStatus.CurrentLine := usiCurrentLine;
    stSystemStatus.ActiveRecipeId := uiActiveRecipeId;
    stSystemStatus.CurrentJobId := udiCurrentJobId;
ELSE
    stSystemStatus.CurrentLine := 0;
    stSystemStatus.ActiveRecipeId := 0;
    stSystemStatus.CurrentJobId := 0;
END_IF;

xPreviousStart := xStart;
xPreviousStop := xStop;
xPreviousPause := xPause;
xPreviousReset := xReset;

END_FUNCTION_BLOCK
