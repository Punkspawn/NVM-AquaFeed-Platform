FUNCTION_BLOCK FB_AlarmManager
VAR_INPUT
    astConditions : ARRAY[0..31] OF ST_AlarmCondition;

    xAcknowledgeRequest : BOOL;
    xResetRequest : BOOL;
    udiCommandSequence : UDINT;
    uiTargetAlarmCode : UINT;
    eTargetSource : E_AlarmSource;
    usiTargetLineId : USINT;
    uiTargetDeviceId : UINT;

    udiAcceptedEventSequence : UDINT;
END_VAR
VAR_OUTPUT
    astActiveAlarms : ARRAY[0..63] OF ST_Alarm;
    stPendingEvent : ST_AlarmEvent;
    xPendingEventValid : BOOL;
    uiPendingEventCount : UINT;

    xAnyAlarmActive : BOOL;
    xAnyBlockingAlarm : BOOL;
    xAnyCriticalAlarm : BOOL;
    xAnyEmergencyAlarm : BOOL;
    eHighestSeverity : E_AlarmSeverity;
    uiActiveAlarmCount : UINT;

    xTableOverflow : BOOL;
    xEventBufferOverflow : BOOL;
    xInputRejected : BOOL;
    uiInputResultCode : UINT;

    xCommandAccepted : BOOL;
    xCommandRejected : BOOL;
    uiCommandResultCode : UINT;
    udiLastProcessedCommandSequence : UDINT;
END_VAR
VAR
    astEventBuffer : ARRAY[0..127] OF ST_AlarmEvent;
    uiEventReadIndex : UINT;
    uiEventWriteIndex : UINT;
    udiEventSequence : UDINT;
    xHasProcessedCommand : BOOL;

    iCondition : INT;
    iPreviousCondition : INT;
    iAlarm : INT;
    iFoundAlarm : INT;
    iFreeAlarm : INT;
    iCommandAlarm : INT;

    xDefinitionValid : BOOL;
    xSeverityValid : BOOL;
    xDuplicateUpdate : BOOL;
    xPolicyMatches : BOOL;
    xEmitEvent : BOOL;
    eEmitEventType : E_AlarmEventType;
END_VAR
VAR CONSTANT
    c_uiInputResultNone : UINT := 0;
    c_uiInputResultInvalidDefinition : UINT := 10;
    c_uiInputResultDuplicateKey : UINT := 11;
    c_uiInputResultPolicyChanged : UINT := 12;
    c_uiInputResultTableFull : UINT := 13;

    c_uiCommandResultNone : UINT := 0;
    c_uiCommandResultAccepted : UINT := 1;
    c_uiCommandResultConflict : UINT := 40;
    c_uiCommandResultNotFound : UINT := 41;
    c_uiCommandResultConditionActive : UINT := 42;
    c_uiCommandResultResetNotRequired : UINT := 43;
END_VAR

xCommandAccepted := FALSE;
xCommandRejected := FALSE;
uiCommandResultCode := c_uiCommandResultNone;
xInputRejected := FALSE;
uiInputResultCode := c_uiInputResultNone;

(* Desktop may remove only the exact oldest retained event. *)
IF (uiPendingEventCount > 0) AND
   (udiAcceptedEventSequence <> 0) AND
   (udiAcceptedEventSequence =
    astEventBuffer[uiEventReadIndex].EventSequence) THEN
    IF uiEventReadIndex >= 127 THEN
        uiEventReadIndex := 0;
    ELSE
        uiEventReadIndex := uiEventReadIndex + 1;
    END_IF;
    uiPendingEventCount := uiPendingEventCount - 1;
END_IF;

(* Process at most 32 explicit condition updates in array order. *)
FOR iCondition := 0 TO 31 DO
    IF astConditions[iCondition].Valid THEN
        xDuplicateUpdate := FALSE;
        IF iCondition > 0 THEN
            FOR iPreviousCondition := 0 TO iCondition - 1 DO
                IF astConditions[iPreviousCondition].Valid AND
                   (astConditions[iPreviousCondition].AlarmCode =
                    astConditions[iCondition].AlarmCode) AND
                   (astConditions[iPreviousCondition].Source =
                    astConditions[iCondition].Source) AND
                   (astConditions[iPreviousCondition].LineId =
                    astConditions[iCondition].LineId) AND
                   (astConditions[iPreviousCondition].DeviceId =
                    astConditions[iCondition].DeviceId) THEN
                    xDuplicateUpdate := TRUE;
                END_IF;
            END_FOR;
        END_IF;

        xSeverityValid := FALSE;
        CASE astConditions[iCondition].Severity OF
            ALARM_INFORMATION,
            ALARM_WARNING,
            ALARM_FAULT,
            ALARM_CRITICAL,
            ALARM_EMERGENCY:
                xSeverityValid := TRUE;
        END_CASE;

        xDefinitionValid := xSeverityValid AND
                            (astConditions[iCondition].AlarmCode >= 1000) AND
                            (astConditions[iCondition].AlarmCode <= 1999) AND
                            NOT ((astConditions[iCondition].Severity =
                                  ALARM_INFORMATION) AND
                                 astConditions[iCondition].Blocking);

        IF xDefinitionValid THEN
            CASE astConditions[iCondition].Source OF
                ALARM_SOURCE_SYSTEM:
                    xDefinitionValid :=
                        ((astConditions[iCondition].AlarmCode >= 1000) AND
                         (astConditions[iCondition].AlarmCode <= 1099)) OR
                        ((astConditions[iCondition].AlarmCode >= 1900) AND
                         (astConditions[iCondition].AlarmCode <= 1999));
                ALARM_SOURCE_COMMUNICATION:
                    xDefinitionValid :=
                        ((astConditions[iCondition].AlarmCode >= 1100) AND
                         (astConditions[iCondition].AlarmCode <= 1199)) OR
                        ((astConditions[iCondition].AlarmCode >= 1900) AND
                         (astConditions[iCondition].AlarmCode <= 1999));
                ALARM_SOURCE_SELECTOR:
                    xDefinitionValid :=
                        (astConditions[iCondition].AlarmCode >= 1200) AND
                        (astConditions[iCondition].AlarmCode <= 1299);
                ALARM_SOURCE_BLOWER:
                    xDefinitionValid :=
                        (astConditions[iCondition].AlarmCode >= 1300) AND
                        (astConditions[iCondition].AlarmCode <= 1399);
                ALARM_SOURCE_DOSING:
                    xDefinitionValid :=
                        (astConditions[iCondition].AlarmCode >= 1400) AND
                        (astConditions[iCondition].AlarmCode <= 1499);
                ALARM_SOURCE_LINE:
                    xDefinitionValid :=
                        (astConditions[iCondition].AlarmCode >= 1500) AND
                        (astConditions[iCondition].AlarmCode <= 1599);
                ALARM_SOURCE_SAFETY,
                ALARM_SOURCE_IO:
                    xDefinitionValid :=
                        ((astConditions[iCondition].AlarmCode >= 1600) AND
                         (astConditions[iCondition].AlarmCode <= 1699)) OR
                        ((astConditions[iCondition].Source =
                          ALARM_SOURCE_IO) AND
                         (astConditions[iCondition].AlarmCode >= 1900) AND
                         (astConditions[iCondition].AlarmCode <= 1999));
                ALARM_SOURCE_POWER:
                    xDefinitionValid :=
                        (astConditions[iCondition].AlarmCode >= 1700) AND
                        (astConditions[iCondition].AlarmCode <= 1799);
                ALARM_SOURCE_AUXILIARY:
                    xDefinitionValid :=
                        (astConditions[iCondition].AlarmCode >= 1800) AND
                        (astConditions[iCondition].AlarmCode <= 1899);
            ELSE
                xDefinitionValid := FALSE;
            END_CASE;
        END_IF;

        IF xDuplicateUpdate THEN
            xInputRejected := TRUE;
            uiInputResultCode := c_uiInputResultDuplicateKey;
        ELSIF NOT xDefinitionValid THEN
            xInputRejected := TRUE;
            uiInputResultCode := c_uiInputResultInvalidDefinition;
        ELSE
            iFoundAlarm := -1;
            iFreeAlarm := -1;
            FOR iAlarm := 0 TO 63 DO
                IF (astActiveAlarms[iAlarm].AlarmCode =
                    astConditions[iCondition].AlarmCode) AND
                   (astActiveAlarms[iAlarm].Source =
                    astConditions[iCondition].Source) AND
                   (astActiveAlarms[iAlarm].LineId =
                    astConditions[iCondition].LineId) AND
                   (astActiveAlarms[iAlarm].DeviceId =
                    astConditions[iCondition].DeviceId) THEN
                    iFoundAlarm := iAlarm;
                END_IF;
                IF (iFreeAlarm < 0) AND
                   (astActiveAlarms[iAlarm].State =
                    ALARM_INACTIVE) THEN
                    iFreeAlarm := iAlarm;
                END_IF;
            END_FOR;

            xEmitEvent := FALSE;

            IF astConditions[iCondition].ConditionActive THEN
                IF iFoundAlarm < 0 THEN
                    IF iFreeAlarm < 0 THEN
                        xTableOverflow := TRUE;
                        xInputRejected := TRUE;
                        uiInputResultCode :=
                            c_uiInputResultTableFull;
                    ELSE
                        IF (astActiveAlarms[iFreeAlarm].AlarmCode <>
                            astConditions[iCondition].AlarmCode) OR
                           (astActiveAlarms[iFreeAlarm].Source <>
                            astConditions[iCondition].Source) OR
                           (astActiveAlarms[iFreeAlarm].LineId <>
                            astConditions[iCondition].LineId) OR
                           (astActiveAlarms[iFreeAlarm].DeviceId <>
                            astConditions[iCondition].DeviceId) THEN
                            astActiveAlarms[iFreeAlarm].OccurrenceCount := 0;
                        END_IF;
                        iFoundAlarm := iFreeAlarm;
                    END_IF;
                END_IF;

                IF iFoundAlarm >= 0 THEN
                    xPolicyMatches :=
                        (astActiveAlarms[iFoundAlarm].State =
                         ALARM_INACTIVE) OR
                        ((astActiveAlarms[iFoundAlarm].Severity =
                          astConditions[iCondition].Severity) AND
                         (astActiveAlarms[iFoundAlarm].ResetRequired =
                          astConditions[iCondition].ResetRequired) AND
                         (astActiveAlarms[iFoundAlarm].Blocking =
                          astConditions[iCondition].Blocking));

                    IF NOT xPolicyMatches THEN
                        xInputRejected := TRUE;
                        uiInputResultCode :=
                            c_uiInputResultPolicyChanged;
                    ELSIF astActiveAlarms[iFoundAlarm].State =
                          ALARM_INACTIVE THEN
                        astActiveAlarms[iFoundAlarm].AlarmCode :=
                            astConditions[iCondition].AlarmCode;
                        astActiveAlarms[iFoundAlarm].Source :=
                            astConditions[iCondition].Source;
                        astActiveAlarms[iFoundAlarm].Severity :=
                            astConditions[iCondition].Severity;
                        astActiveAlarms[iFoundAlarm].State :=
                            ALARM_ACTIVE_UNACKNOWLEDGED;
                        astActiveAlarms[iFoundAlarm].LineId :=
                            astConditions[iCondition].LineId;
                        astActiveAlarms[iFoundAlarm].DeviceId :=
                            astConditions[iCondition].DeviceId;
                        astActiveAlarms[iFoundAlarm].ConditionActive := TRUE;
                        astActiveAlarms[iFoundAlarm].Acknowledged := FALSE;
                        astActiveAlarms[iFoundAlarm].ResetRequired :=
                            astConditions[iCondition].ResetRequired;
                        astActiveAlarms[iFoundAlarm].Blocking :=
                            astConditions[iCondition].Blocking;
                        IF astActiveAlarms[iFoundAlarm].OccurrenceCount <
                           65535 THEN
                            astActiveAlarms[iFoundAlarm].OccurrenceCount :=
                                astActiveAlarms[iFoundAlarm].OccurrenceCount + 1;
                        END_IF;
                        xEmitEvent := TRUE;
                        eEmitEventType := ALARM_EVENT_ACTIVATED;
                    ELSE
                        astActiveAlarms[iFoundAlarm].ConditionActive := TRUE;
                    END_IF;
                END_IF;
            ELSE
                IF (iFoundAlarm >= 0) AND
                   (astActiveAlarms[iFoundAlarm].State <>
                    ALARM_INACTIVE) THEN
                    xPolicyMatches :=
                        (astActiveAlarms[iFoundAlarm].Severity =
                         astConditions[iCondition].Severity) AND
                        (astActiveAlarms[iFoundAlarm].ResetRequired =
                         astConditions[iCondition].ResetRequired) AND
                        (astActiveAlarms[iFoundAlarm].Blocking =
                         astConditions[iCondition].Blocking);

                    IF NOT xPolicyMatches THEN
                        xInputRejected := TRUE;
                        uiInputResultCode :=
                            c_uiInputResultPolicyChanged;
                    ELSIF astActiveAlarms[iFoundAlarm].ConditionActive THEN
                        astActiveAlarms[iFoundAlarm].ConditionActive := FALSE;
                        IF astActiveAlarms[iFoundAlarm].ResetRequired THEN
                            astActiveAlarms[iFoundAlarm].State :=
                                ALARM_CLEARED_WAIT_RESET;
                        ELSE
                            astActiveAlarms[iFoundAlarm].State :=
                                ALARM_INACTIVE;
                            astActiveAlarms[iFoundAlarm].Acknowledged := FALSE;
                        END_IF;
                        xEmitEvent := TRUE;
                        eEmitEventType := ALARM_EVENT_CLEARED;
                    END_IF;
                END_IF;
            END_IF;

            IF xEmitEvent AND (iFoundAlarm >= 0) THEN
                IF udiEventSequence >= c_udiCounterMaximum THEN
                    xEventBufferOverflow := TRUE;
                ELSE
                    udiEventSequence := udiEventSequence + 1;
                    astActiveAlarms[iFoundAlarm].EventSequence :=
                        udiEventSequence;
                    IF eEmitEventType = ALARM_EVENT_ACTIVATED THEN
                        astActiveAlarms[iFoundAlarm].ActivationSequence :=
                            udiEventSequence;
                    END_IF;

                    IF uiPendingEventCount >=
                       c_uiAlarmEventCapacity THEN
                        xEventBufferOverflow := TRUE;
                    ELSE
                        astEventBuffer[uiEventWriteIndex].EventSequence :=
                            udiEventSequence;
                        astEventBuffer[uiEventWriteIndex].EventType :=
                            eEmitEventType;
                        astEventBuffer[uiEventWriteIndex].AlarmCode :=
                            astActiveAlarms[iFoundAlarm].AlarmCode;
                        astEventBuffer[uiEventWriteIndex].Source :=
                            astActiveAlarms[iFoundAlarm].Source;
                        astEventBuffer[uiEventWriteIndex].Severity :=
                            astActiveAlarms[iFoundAlarm].Severity;
                        astEventBuffer[uiEventWriteIndex].State :=
                            astActiveAlarms[iFoundAlarm].State;
                        astEventBuffer[uiEventWriteIndex].LineId :=
                            astActiveAlarms[iFoundAlarm].LineId;
                        astEventBuffer[uiEventWriteIndex].DeviceId :=
                            astActiveAlarms[iFoundAlarm].DeviceId;
                        IF uiEventWriteIndex >= 127 THEN
                            uiEventWriteIndex := 0;
                        ELSE
                            uiEventWriteIndex := uiEventWriteIndex + 1;
                        END_IF;
                        uiPendingEventCount := uiPendingEventCount + 1;
                    END_IF;
                END_IF;
            END_IF;
        END_IF;
    END_IF;
END_FOR;

(* Process one idempotent lifecycle command. *)
IF (xAcknowledgeRequest OR xResetRequest) AND
   (NOT xHasProcessedCommand OR
    (udiCommandSequence <>
     udiLastProcessedCommandSequence)) THEN
    udiLastProcessedCommandSequence := udiCommandSequence;
    xHasProcessedCommand := TRUE;
    iCommandAlarm := -1;

    IF xAcknowledgeRequest AND xResetRequest THEN
        xCommandRejected := TRUE;
        uiCommandResultCode := c_uiCommandResultConflict;
    ELSE
        FOR iAlarm := 0 TO 63 DO
            IF (astActiveAlarms[iAlarm].State <>
                ALARM_INACTIVE) AND
               (astActiveAlarms[iAlarm].AlarmCode =
                uiTargetAlarmCode) AND
               (astActiveAlarms[iAlarm].Source =
                eTargetSource) AND
               (astActiveAlarms[iAlarm].LineId =
                usiTargetLineId) AND
               (astActiveAlarms[iAlarm].DeviceId =
                uiTargetDeviceId) THEN
                iCommandAlarm := iAlarm;
            END_IF;
        END_FOR;

        IF iCommandAlarm < 0 THEN
            xCommandRejected := TRUE;
            uiCommandResultCode := c_uiCommandResultNotFound;
        ELSIF xAcknowledgeRequest THEN
            xCommandAccepted := TRUE;
            uiCommandResultCode := c_uiCommandResultAccepted;
            xEmitEvent := FALSE;
            IF NOT astActiveAlarms[iCommandAlarm].Acknowledged THEN
                astActiveAlarms[iCommandAlarm].Acknowledged := TRUE;
                IF astActiveAlarms[iCommandAlarm].State =
                   ALARM_ACTIVE_UNACKNOWLEDGED THEN
                    astActiveAlarms[iCommandAlarm].State :=
                        ALARM_ACTIVE_ACKNOWLEDGED;
                END_IF;
                xEmitEvent := TRUE;
                eEmitEventType := ALARM_EVENT_ACKNOWLEDGED;
            END_IF;
        ELSE
            xEmitEvent := FALSE;
            IF astActiveAlarms[iCommandAlarm].ConditionActive THEN
                xCommandRejected := TRUE;
                uiCommandResultCode :=
                    c_uiCommandResultConditionActive;
            ELSIF astActiveAlarms[iCommandAlarm].State =
                  ALARM_CLEARED_WAIT_RESET THEN
                astActiveAlarms[iCommandAlarm].State := ALARM_INACTIVE;
                astActiveAlarms[iCommandAlarm].Acknowledged := FALSE;
                xCommandAccepted := TRUE;
                uiCommandResultCode := c_uiCommandResultAccepted;
                xEmitEvent := TRUE;
                eEmitEventType := ALARM_EVENT_RESET;
            ELSE
                xCommandRejected := TRUE;
                uiCommandResultCode :=
                    c_uiCommandResultResetNotRequired;
            END_IF;
        END_IF;

        IF xEmitEvent AND (iCommandAlarm >= 0) THEN
            IF udiEventSequence >= c_udiCounterMaximum THEN
                xEventBufferOverflow := TRUE;
            ELSE
                udiEventSequence := udiEventSequence + 1;
                astActiveAlarms[iCommandAlarm].EventSequence :=
                    udiEventSequence;
                IF uiPendingEventCount >=
                   c_uiAlarmEventCapacity THEN
                    xEventBufferOverflow := TRUE;
                ELSE
                    astEventBuffer[uiEventWriteIndex].EventSequence :=
                        udiEventSequence;
                    astEventBuffer[uiEventWriteIndex].EventType :=
                        eEmitEventType;
                    astEventBuffer[uiEventWriteIndex].AlarmCode :=
                        astActiveAlarms[iCommandAlarm].AlarmCode;
                    astEventBuffer[uiEventWriteIndex].Source :=
                        astActiveAlarms[iCommandAlarm].Source;
                    astEventBuffer[uiEventWriteIndex].Severity :=
                        astActiveAlarms[iCommandAlarm].Severity;
                    astEventBuffer[uiEventWriteIndex].State :=
                        astActiveAlarms[iCommandAlarm].State;
                    astEventBuffer[uiEventWriteIndex].LineId :=
                        astActiveAlarms[iCommandAlarm].LineId;
                    astEventBuffer[uiEventWriteIndex].DeviceId :=
                        astActiveAlarms[iCommandAlarm].DeviceId;
                    IF uiEventWriteIndex >= 127 THEN
                        uiEventWriteIndex := 0;
                    ELSE
                        uiEventWriteIndex := uiEventWriteIndex + 1;
                    END_IF;
                    uiPendingEventCount := uiPendingEventCount + 1;
                END_IF;
            END_IF;
        END_IF;
    END_IF;
END_IF;

(* Recalculate bounded summaries from lifecycle records. *)
xAnyAlarmActive := FALSE;
xAnyBlockingAlarm := FALSE;
xAnyCriticalAlarm := FALSE;
xAnyEmergencyAlarm := FALSE;
eHighestSeverity := ALARM_INFORMATION;
uiActiveAlarmCount := 0;

FOR iAlarm := 0 TO 63 DO
    IF astActiveAlarms[iAlarm].State <> ALARM_INACTIVE THEN
        xAnyAlarmActive := TRUE;
        IF uiActiveAlarmCount < c_uiActiveAlarmCapacity THEN
            uiActiveAlarmCount := uiActiveAlarmCount + 1;
        END_IF;
        IF astActiveAlarms[iAlarm].Blocking THEN
            xAnyBlockingAlarm := TRUE;
        END_IF;
        IF astActiveAlarms[iAlarm].Severity > eHighestSeverity THEN
            eHighestSeverity := astActiveAlarms[iAlarm].Severity;
        END_IF;
        IF astActiveAlarms[iAlarm].Severity >= ALARM_CRITICAL THEN
            xAnyCriticalAlarm := TRUE;
        END_IF;
        IF astActiveAlarms[iAlarm].Severity = ALARM_EMERGENCY THEN
            xAnyEmergencyAlarm := TRUE;
        END_IF;
    END_IF;
END_FOR;

xPendingEventValid := uiPendingEventCount > 0;
IF xPendingEventValid THEN
    stPendingEvent := astEventBuffer[uiEventReadIndex];
ELSE
    stPendingEvent.EventSequence := 0;
    stPendingEvent.EventType := ALARM_EVENT_ACTIVATED;
    stPendingEvent.AlarmCode := 0;
    stPendingEvent.Source := ALARM_SOURCE_SYSTEM;
    stPendingEvent.Severity := ALARM_INFORMATION;
    stPendingEvent.State := ALARM_INACTIVE;
    stPendingEvent.LineId := 0;
    stPendingEvent.DeviceId := 0;
END_IF;

END_FUNCTION_BLOCK
