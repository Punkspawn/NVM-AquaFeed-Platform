FUNCTION_BLOCK FB_CommunicationManager
VAR_INPUT
    xEnable : BOOL;
    uiChannelId : UINT;
    uiProfileId : UINT;
    uiChannelType : UINT;
    xRequiredForControl : BOOL;
    xTransportReady : BOOL;
    udiFreshnessTimeoutMs : UDINT;
    uiFailureThreshold : UINT;
    xRxEvent : BOOL;
    xTxEvent : BOOL;
    xProtocolErrorEvent : BOOL;
    xTimeoutEvent : BOOL;
    udiReceivedSequence : UDINT;
    udiMonotonicTickMs : UDINT;
    xResetCountersRequest : BOOL;
    udiResetSequence : UDINT;
    xServicePermission : BOOL;
END_VAR
VAR_OUTPUT
    stChannel : ST_CommunicationChannel;
    xNewFaultEvent : BOOL;
    xRecoveryEvent : BOOL;
    uiResultCode : UINT;
END_VAR
VAR
    xConfigurationValid : BOOL;
    xHasReceived : BOOL;
    xFaultLatched : BOOL;
    xWasFaultLatched : BOOL;
    xHasProcessedReset : BOOL;
    udiLastProcessedResetSequence : UDINT;
    udiElapsedSinceRxMs : UDINT;
END_VAR
VAR CONSTANT
    c_uiStateDisabled : UINT := 0;
    c_uiStateStarting : UINT := 10;
    c_uiStateReady : UINT := 20;
    c_uiStateStale : UINT := 30;
    c_uiStateFault : UINT := 90;
    c_uiDiagnosticNone : UINT := 0;
    c_uiDiagnosticConfiguration : UINT := 10;
    c_uiDiagnosticTransportUnavailable : UINT := 11;
    c_uiDiagnosticNoReceive : UINT := 12;
    c_uiDiagnosticStale : UINT := 13;
    c_uiDiagnosticFailureThreshold : UINT := 14;
    c_uiResultNone : UINT := 0;
    c_uiResultResetAccepted : UINT := 1;
    c_uiResultResetPermissionDenied : UINT := 2;
END_VAR

xNewFaultEvent := FALSE;
xRecoveryEvent := FALSE;
uiResultCode := c_uiResultNone;
xWasFaultLatched := xFaultLatched;

xConfigurationValid := (uiChannelId <> 0) AND
                       (uiProfileId <> 0) AND
                       (uiChannelType <> 0) AND
                       (udiFreshnessTimeoutMs <> 0) AND
                       (uiFailureThreshold <> 0);

stChannel.uiChannelId := uiChannelId;
stChannel.uiProfileId := uiProfileId;
stChannel.uiChannelType := uiChannelType;
stChannel.xEnabled := xEnable;
stChannel.xRequiredForControl := xRequiredForControl;
stChannel.xReady := FALSE;
stChannel.xFresh := FALSE;

IF xResetCountersRequest AND
   (NOT xHasProcessedReset OR
    (udiResetSequence <> udiLastProcessedResetSequence)) THEN
    xHasProcessedReset := TRUE;
    udiLastProcessedResetSequence := udiResetSequence;

    IF xServicePermission THEN
        stChannel.udiTxCount := 0;
        stChannel.udiRxCount := 0;
        stChannel.udiErrorCount := 0;
        stChannel.udiTimeoutCount := 0;
        stChannel.udiRetryCount := 0;
        uiResultCode := c_uiResultResetAccepted;
    ELSE
        uiResultCode := c_uiResultResetPermissionDenied;
    END_IF;
END_IF;

IF NOT xEnable THEN
    stChannel.uiState := c_uiStateDisabled;
    stChannel.uiDiagnosticCode := c_uiDiagnosticNone;
    stChannel.xFault := FALSE;
    stChannel.uiConsecutiveFailureCount := 0;
    xHasReceived := FALSE;
    xFaultLatched := FALSE;
ELSIF NOT xConfigurationValid THEN
    stChannel.uiState := c_uiStateFault;
    stChannel.uiDiagnosticCode := c_uiDiagnosticConfiguration;
    stChannel.xFault := TRUE;
    xFaultLatched := TRUE;
ELSIF NOT xTransportReady THEN
    stChannel.uiState := c_uiStateStale;
    stChannel.uiDiagnosticCode := c_uiDiagnosticTransportUnavailable;
    stChannel.xFault := xFaultLatched;
ELSE
    IF xTxEvent THEN
        stChannel.udiLastTxTickMs := udiMonotonicTickMs;
        IF stChannel.udiTxCount < 16#FFFFFFFF THEN
            stChannel.udiTxCount := stChannel.udiTxCount + 1;
        END_IF;
    END_IF;

    IF xProtocolErrorEvent THEN
        IF stChannel.udiErrorCount < 16#FFFFFFFF THEN
            stChannel.udiErrorCount := stChannel.udiErrorCount + 1;
        END_IF;
    END_IF;

    IF xTimeoutEvent THEN
        IF stChannel.udiErrorCount < 16#FFFFFFFF THEN
            stChannel.udiErrorCount := stChannel.udiErrorCount + 1;
        END_IF;
        IF stChannel.udiTimeoutCount < 16#FFFFFFFF THEN
            stChannel.udiTimeoutCount := stChannel.udiTimeoutCount + 1;
        END_IF;
        IF stChannel.udiRetryCount < 16#FFFFFFFF THEN
            stChannel.udiRetryCount := stChannel.udiRetryCount + 1;
        END_IF;
    END_IF;

    IF xProtocolErrorEvent OR xTimeoutEvent THEN
        IF stChannel.uiConsecutiveFailureCount < 65535 THEN
            stChannel.uiConsecutiveFailureCount :=
                stChannel.uiConsecutiveFailureCount + 1;
        END_IF;

        IF stChannel.uiConsecutiveFailureCount >=
           uiFailureThreshold THEN
            xFaultLatched := TRUE;
        END_IF;
    END_IF;

    IF xRxEvent THEN
        stChannel.udiLastRxTickMs := udiMonotonicTickMs;
        IF stChannel.udiRxCount < 16#FFFFFFFF THEN
            stChannel.udiRxCount := stChannel.udiRxCount + 1;
        END_IF;

        IF NOT xHasReceived OR
           (udiReceivedSequence <>
            stChannel.udiLastAcceptedSequence) THEN
            stChannel.udiLastAcceptedSequence :=
                udiReceivedSequence;
        END_IF;

        xHasReceived := TRUE;
        stChannel.uiConsecutiveFailureCount := 0;
        xFaultLatched := FALSE;
    END_IF;

    IF xHasReceived THEN
        udiElapsedSinceRxMs := F_ElapsedMs(
            udiCurrentTickMs := udiMonotonicTickMs,
            udiStartTickMs := stChannel.udiLastRxTickMs);
    ELSE
        udiElapsedSinceRxMs := 0;
    END_IF;

    IF xFaultLatched THEN
        stChannel.uiState := c_uiStateFault;
        stChannel.uiDiagnosticCode :=
            c_uiDiagnosticFailureThreshold;
        stChannel.xFault := TRUE;
    ELSIF NOT xHasReceived THEN
        stChannel.uiState := c_uiStateStarting;
        stChannel.uiDiagnosticCode := c_uiDiagnosticNoReceive;
        stChannel.xFault := FALSE;
    ELSIF udiElapsedSinceRxMs >= udiFreshnessTimeoutMs THEN
        stChannel.uiState := c_uiStateStale;
        stChannel.uiDiagnosticCode := c_uiDiagnosticStale;
        stChannel.xFault := FALSE;
    ELSE
        stChannel.uiState := c_uiStateReady;
        stChannel.uiDiagnosticCode := c_uiDiagnosticNone;
        stChannel.xReady := TRUE;
        stChannel.xFresh := TRUE;
        stChannel.xFault := FALSE;
    END_IF;
END_IF;

IF xFaultLatched AND NOT xWasFaultLatched THEN
    xNewFaultEvent := TRUE;
ELSIF NOT xFaultLatched AND xWasFaultLatched AND xRxEvent THEN
    xRecoveryEvent := TRUE;
END_IF;

END_FUNCTION_BLOCK
