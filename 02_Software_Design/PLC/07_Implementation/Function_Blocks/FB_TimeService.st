FUNCTION_BLOCK FB_TimeService
VAR_INPUT
    udiRuntimeTickMs : UDINT;
    xRuntimeTickHealthy : BOOL;
    dtObservedUtc : DT;
    udiSyncSequence : UDINT;
    xSyncRequest : BOOL;
END_VAR
VAR_OUTPUT
    stTime : ST_TimeService;
    xSyncAccepted : BOOL;
    xSyncRejected : BOOL;
    uiResultCode : UINT;
END_VAR
VAR
    xInitialized : BOOL;
    xPreviousSyncRequest : BOOL;
    udiPreviousRuntimeTickMs : UDINT;
    udiAccumulatedMs : UDINT;
    udiDeltaMs : UDINT;
    udiElapsedSeconds : UDINT;
END_VAR
VAR CONSTANT
    c_uiResultNone : UINT := 0;
    c_uiResultSequenceSaturated : UINT := 1;
    c_uiResultSyncReplay : UINT := 10;
    c_uiResultUtcOutOfRange : UINT := 11;
    c_uiDiagnosticMonotonicUnhealthy : UINT := 20;
END_VAR

stTime.xOneSecondTick := FALSE;
xSyncAccepted := FALSE;
xSyncRejected := FALSE;
uiResultCode := c_uiResultNone;

IF NOT xInitialized THEN
    udiPreviousRuntimeTickMs := udiRuntimeTickMs;
    stTime.udiMonotonicTickMs := udiRuntimeTickMs;
    stTime.xMonotonicHealthy := xRuntimeTickHealthy;
    xInitialized := TRUE;
ELSE
    IF udiRuntimeTickMs >= udiPreviousRuntimeTickMs THEN
        udiDeltaMs := udiRuntimeTickMs - udiPreviousRuntimeTickMs;
    ELSE
        udiDeltaMs := (c_udiCounterMaximum - udiPreviousRuntimeTickMs) + udiRuntimeTickMs + 1;
    END_IF;

    udiPreviousRuntimeTickMs := udiRuntimeTickMs;
    stTime.udiMonotonicTickMs := udiRuntimeTickMs;
    stTime.xMonotonicHealthy := xRuntimeTickHealthy;

    IF xRuntimeTickHealthy THEN
        udiAccumulatedMs := udiAccumulatedMs + udiDeltaMs;
        udiElapsedSeconds := udiAccumulatedMs / 1000;

        IF udiElapsedSeconds > 0 THEN
            udiAccumulatedMs := udiAccumulatedMs MOD 1000;
            stTime.xOneSecondTick := TRUE;

            IF udiElapsedSeconds > (c_udiCounterMaximum - stTime.udiMonotonicSecondSequence) THEN
                stTime.udiMonotonicSecondSequence := c_udiCounterMaximum;
                stTime.uiTimeDiagnosticCode := c_uiResultSequenceSaturated;
                uiResultCode := c_uiResultSequenceSaturated;
            ELSE
                stTime.udiMonotonicSecondSequence := stTime.udiMonotonicSecondSequence + udiElapsedSeconds;
                stTime.uiTimeDiagnosticCode := c_uiResultNone;
            END_IF;
        ELSE
            stTime.uiTimeDiagnosticCode := c_uiResultNone;
        END_IF;
    ELSE
        udiAccumulatedMs := 0;
        stTime.uiTimeDiagnosticCode := c_uiDiagnosticMonotonicUnhealthy;
    END_IF;
END_IF;

IF xSyncRequest AND NOT xPreviousSyncRequest THEN
    IF udiSyncSequence = stTime.udiLastAcceptedSyncSequence THEN
        xSyncRejected := TRUE;
        uiResultCode := c_uiResultSyncReplay;
    ELSIF (dtObservedUtc < DT#2020-01-01-00:00:00) OR
          (dtObservedUtc > DT#2100-12-31-23:59:59) THEN
        xSyncRejected := TRUE;
        uiResultCode := c_uiResultUtcOutOfRange;
    ELSE
        stTime.dtObservedUtc := dtObservedUtc;
        stTime.udiLastAcceptedSyncSequence := udiSyncSequence;
        stTime.xWallClockValid := TRUE;
        xSyncAccepted := TRUE;
    END_IF;
END_IF;

xPreviousSyncRequest := xSyncRequest;

END_FUNCTION_BLOCK
