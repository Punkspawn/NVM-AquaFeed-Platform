FUNCTION_BLOCK FB_LineManager
VAR_INPUT
    xEnableFromSystem : BOOL;
    xStart : BOOL;
    xPause : BOOL;
    xStop : BOOL;
    xCancel : BOOL;
    udiCommandSequence : UDINT;
    udiResetSequence : UDINT;
    xEmergencyStop : BOOL;
    xSafetyOK : BOOL;
    xBlockingFault : BOOL;
    xDesktopCommunicationOK : BOOL;
    stConfig : ST_LineConfig;
    udiMonotonicTickMs : UDINT;

    xJobAvailable : BOOL;
    xAcceptJob : BOOL;
    xCandidateIntegrityValid : BOOL;
    stJobCandidate : ST_JobExecution;
    stRecipeCandidate : ST_RecipeExecution;

    xSelectorReady : BOOL;
    xSelectorInPosition : BOOL;
    uiSelectorOutlet : UINT;
    xSelectorFault : BOOL;

    xBlowerReady : BOOL;
    xBlowerRunning : BOOL;
    xBlowerAtSpeed : BOOL;
    xBlowerDosingPermitted : BOOL;
    xBlowerFault : BOOL;

    xDosing1Ready : BOOL;
    xDosing1Running : BOOL;
    xDosing1Fault : BOOL;
    xDosing1CompletedEvent : BOOL;
    udiDosing1DeliveredCentiKg : UDINT;
    udiDosing1IncrementCentiKg : UDINT;

    xDosing2Ready : BOOL;
    xDosing2Running : BOOL;
    xDosing2Fault : BOOL;
    xDosing2CompletedEvent : BOOL;
    udiDosing2DeliveredCentiKg : UDINT;
    udiDosing2IncrementCentiKg : UDINT;
END_VAR
VAR_OUTPUT
    stLine : ST_Line;
    xReady : BOOL;
    xBusy : BOOL;
    xCompleted : BOOL;
    xJobAccepted : BOOL;
    xJobRejected : BOOL;
    uiResultCode : UINT;
    udiLastAcceptedCommandSequence : UDINT;

    xSelectorMoveRequest : BOOL;
    uiSelectorTargetOutlet : UINT;
    udiSelectorCommandSequence : UDINT;

    xBlowerRunRequest : BOOL;
    xBlowerNormalStopRequest : BOOL;
    uiBlowerTargetFreqCentiHz : UINT;
    udiBlowerRequestedPostRunTimeMs : UDINT;
    udiBlowerCommandSequence : UDINT;

    xDosing1StartRequest : BOOL;
    xDosing1StopRequest : BOOL;
    udiDosing1CommandSequence : UDINT;
    udiDosing1JobId : UDINT;
    uiDosing1OutletId : UINT;
    udiDosing1TargetCentiKg : UDINT;
    uiDosing1SpeedPermille : UINT;

    xDosing2StartRequest : BOOL;
    xDosing2StopRequest : BOOL;
    udiDosing2CommandSequence : UDINT;
    udiDosing2JobId : UDINT;
    uiDosing2OutletId : UINT;
    udiDosing2TargetCentiKg : UDINT;
    uiDosing2SpeedPermille : UINT;

    xEquipmentResetRequest : BOOL;
    udiEquipmentResetSequence : UDINT;
END_VAR
VAR
    eState : E_LineState := LINE_OFF;
    stAcceptedJob : ST_JobExecution;
    stAcceptedRecipe : ST_RecipeExecution;
    xActiveJobValid : BOOL;
    xConfigValid : BOOL;
    xCandidateValid : BOOL;
    xSelectedDosingReady : BOOL;
    xSelectedDosingRunning : BOOL;
    xSelectedDosingFault : BOOL;
    xSelectedDosingComplete : BOOL;
    udiSelectedDosingIncrement : UDINT;
    udiSelectedDosingTarget : UDINT;
    udiExecutionStartTickMs : UDINT;
    udiStateStartTickMs : UDINT;
    udiLastResetSequence : UDINT;
    udiInternalCommandSequence : UDINT;
    xHasAcceptedCommand : BOOL;
    xHasAcceptedReset : BOOL;
    xShutdownForPause : BOOL;
    xShutdownForCancel : BOOL;
    xShutdownForStop : BOOL;
    xSelectorSettleTimerActive : BOOL;
    xCompleteEventIssued : BOOL;
END_VAR
VAR CONSTANT
    c_udiMaximumProgressTarget : UDINT := 4000000;
    c_uiResultNone : UINT := 0;
    c_uiResultAccepted : UINT := 1;
    c_uiResultCompleted : UINT := 2;
    c_uiResultStopped : UINT := 3;
    c_uiResultCancelled : UINT := 4;
    c_uiResultInvalidConfig : UINT := 60;
    c_uiResultDesktopOffline : UINT := 61;
    c_uiResultIntegrity : UINT := 62;
    c_uiResultInvalidCandidate : UINT := 63;
    c_uiResultEquipmentNotReady : UINT := 64;
    c_uiResultEquipmentFault : UINT := 65;
    c_uiResultSafety : UINT := 66;
    c_uiResultEmergency : UINT := 67;
    c_uiResultTimeout : UINT := 68;
    c_uiResultSequenceOverflow : UINT := 69;
    c_uiResultArithmetic : UINT := 70;
END_VAR

xReady := FALSE;
xBusy := xActiveJobValid;
xCompleted := FALSE;
xJobAccepted := FALSE;
xJobRejected := FALSE;
xSelectorMoveRequest := FALSE;
uiSelectorTargetOutlet := 0;
xBlowerRunRequest := FALSE;
xBlowerNormalStopRequest := FALSE;
uiBlowerTargetFreqCentiHz := 0;
udiBlowerRequestedPostRunTimeMs := 0;
xDosing1StartRequest := FALSE;
xDosing1StopRequest := FALSE;
udiDosing1JobId := 0;
uiDosing1OutletId := 0;
udiDosing1TargetCentiKg := 0;
uiDosing1SpeedPermille := 0;
xDosing2StartRequest := FALSE;
xDosing2StopRequest := FALSE;
udiDosing2JobId := 0;
uiDosing2OutletId := 0;
udiDosing2TargetCentiKg := 0;
uiDosing2SpeedPermille := 0;
xEquipmentResetRequest := FALSE;

xConfigValid := (stConfig.usiLineId > 0) AND
                (stConfig.uiSelectorOutletCount > 0) AND
                (stConfig.uiSelectorOutletCount <= 64) AND
                (stConfig.xDosing1Enabled OR
                 stConfig.xDosing2Enabled) AND
                (stConfig.udiMaximumTargetCentiKg > 0) AND
                (stConfig.udiMaximumTargetCentiKg <=
                 c_udiMaximumProgressTarget) AND
                (stConfig.udiMaximumFeedToleranceCentiKg <
                 stConfig.udiMaximumTargetCentiKg) AND
                (stConfig.uiMinimumDosingSpeedPermille > 0) AND
                (stConfig.uiMinimumDosingSpeedPermille <=
                 stConfig.uiMaximumDosingSpeedPermille) AND
                (stConfig.uiMaximumDosingSpeedPermille <= 1000) AND
                (stConfig.uiMinimumBlowerFreqCentiHz > 0) AND
                (stConfig.uiMinimumBlowerFreqCentiHz <=
                 stConfig.uiMaximumBlowerFreqCentiHz) AND
                (stConfig.udiMaximumSelectorSettleTimeMs > 0) AND
                (stConfig.udiMaximumBlowerPreRunTimeMs > 0) AND
                (stConfig.udiMaximumBlowerPostRunTimeMs > 0) AND
                (stConfig.udiMaximumDosingTimeSec > 0) AND
                (stConfig.udiMaximumExecutionTimeSec > 0);

xCandidateValid := xJobAvailable AND
                   xCandidateIntegrityValid AND
                   (stJobCandidate.uiSnapshotVersion = 1) AND
                   (stRecipeCandidate.uiSnapshotVersion = 1) AND
                   (stJobCandidate.udiJobId > 0) AND
                   (stJobCandidate.usiLineId =
                    stConfig.usiLineId) AND
                   (stJobCandidate.uiRecipeId > 0) AND
                   (stJobCandidate.uiRecipeId =
                    stRecipeCandidate.uiRecipeId) AND
                   (stJobCandidate.udiRecipeRevision =
                    stRecipeCandidate.udiRecipeRevision) AND
                   (stJobCandidate.uiTargetSelectorOutlet > 0) AND
                   (stJobCandidate.uiTargetSelectorOutlet <=
                    stConfig.uiSelectorOutletCount) AND
                   (((stJobCandidate.byDosingUnitMask = 16#01) AND
                     stConfig.xDosing1Enabled) OR
                    ((stJobCandidate.byDosingUnitMask = 16#02) AND
                     stConfig.xDosing2Enabled)) AND
                   (stJobCandidate.udiTargetFeedCentiKg > 0) AND
                   (stJobCandidate.udiTargetFeedCentiKg <=
                    stConfig.udiMaximumTargetCentiKg) AND
                   (stRecipeCandidate.udiFeedToleranceCentiKg <=
                    stConfig.udiMaximumFeedToleranceCentiKg) AND
                   (stRecipeCandidate.udiFeedToleranceCentiKg <
                    stJobCandidate.udiTargetFeedCentiKg) AND
                   (stRecipeCandidate.uiDosingSpeedPermille >=
                    stConfig.uiMinimumDosingSpeedPermille) AND
                   (stRecipeCandidate.uiDosingSpeedPermille <=
                    stConfig.uiMaximumDosingSpeedPermille) AND
                   (stRecipeCandidate.uiBlowerFreqCentiHz >=
                    stConfig.uiMinimumBlowerFreqCentiHz) AND
                   (stRecipeCandidate.uiBlowerFreqCentiHz <=
                    stConfig.uiMaximumBlowerFreqCentiHz) AND
                   (stRecipeCandidate.udiSelectorSettleTimeMs <=
                    stConfig.udiMaximumSelectorSettleTimeMs) AND
                   (stRecipeCandidate.udiBlowerPreRunTimeMs <=
                    stConfig.udiMaximumBlowerPreRunTimeMs) AND
                   (stRecipeCandidate.udiBlowerPostRunTimeMs > 0) AND
                   (stRecipeCandidate.udiBlowerPostRunTimeMs <=
                    stConfig.udiMaximumBlowerPostRunTimeMs) AND
                   (stRecipeCandidate.udiMaximumDosingTimeSec > 0) AND
                   (stRecipeCandidate.udiMaximumDosingTimeSec <=
                    stConfig.udiMaximumDosingTimeSec) AND
                   (stJobCandidate.udiMaximumExecutionTimeSec > 0) AND
                   (stJobCandidate.udiMaximumExecutionTimeSec <=
                    stConfig.udiMaximumExecutionTimeSec);

xSelectedDosingReady := FALSE;
xSelectedDosingRunning := FALSE;
xSelectedDosingFault := FALSE;
xSelectedDosingComplete := FALSE;
udiSelectedDosingIncrement := 0;

IF xActiveJobValid THEN
    IF stAcceptedJob.byDosingUnitMask = 16#01 THEN
        xSelectedDosingReady := xDosing1Ready;
        xSelectedDosingRunning := xDosing1Running;
        xSelectedDosingFault := xDosing1Fault;
        xSelectedDosingComplete := xDosing1CompletedEvent;
        udiSelectedDosingIncrement :=
            udiDosing1IncrementCentiKg;
    ELSIF stAcceptedJob.byDosingUnitMask = 16#02 THEN
        xSelectedDosingReady := xDosing2Ready;
        xSelectedDosingRunning := xDosing2Running;
        xSelectedDosingFault := xDosing2Fault;
        xSelectedDosingComplete := xDosing2CompletedEvent;
        udiSelectedDosingIncrement :=
            udiDosing2IncrementCentiKg;
    END_IF;
END_IF;

IF NOT xEnableFromSystem THEN
    eState := LINE_OFF;
    xActiveJobValid := FALSE;
    xShutdownForPause := FALSE;
    xShutdownForCancel := FALSE;
    xShutdownForStop := FALSE;
    xCompleteEventIssued := FALSE;
    uiResultCode := c_uiResultNone;
ELSIF NOT xConfigValid THEN
    eState := LINE_FAULT;
    uiResultCode := c_uiResultInvalidConfig;
ELSIF xEmergencyStop THEN
    eState := LINE_EMERGENCY;
    uiResultCode := c_uiResultEmergency;
ELSIF xActiveJobValid AND
      (NOT xSafetyOK OR xBlockingFault) THEN
    eState := LINE_FAULT;
    uiResultCode := c_uiResultSafety;
ELSIF xActiveJobValid AND
      (xSelectorFault OR xBlowerFault OR
       xSelectedDosingFault) THEN
    eState := LINE_FAULT;
    uiResultCode := c_uiResultEquipmentFault;
ELSE
    IF xActiveJobValid AND
       (eState <> LINE_PAUSED) AND
       (eState <> LINE_FAULT) AND
       (eState <> LINE_EMERGENCY) AND
       (F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                    udiStartTickMs := udiExecutionStartTickMs) >=
        (stAcceptedJob.udiMaximumExecutionTimeSec * 1000)) THEN
        eState := LINE_FAULT;
        uiResultCode := c_uiResultTimeout;
    END_IF;

    IF xActiveJobValid AND
       (eState <> LINE_LOAD_JOB) AND
       (eState <> LINE_READY) AND
       (eState <> LINE_PAUSED) AND
       (eState <> LINE_FAULT) AND
       (eState <> LINE_EMERGENCY) AND
       (NOT xHasAcceptedCommand OR
        (udiCommandSequence <>
         udiLastAcceptedCommandSequence)) THEN
        IF xCancel OR xStop OR xPause THEN
            udiLastAcceptedCommandSequence :=
                udiCommandSequence;
            xHasAcceptedCommand := TRUE;
            xShutdownForCancel := xCancel;
            xShutdownForStop := xStop AND NOT xCancel;
            xShutdownForPause :=
                xPause AND NOT xStop AND NOT xCancel;
            eState := LINE_STOP_DOSING;
        END_IF;
    END_IF;

    CASE eState OF
        LINE_OFF:
            eState := LINE_INITIALIZING;
            uiResultCode := c_uiResultNone;

        LINE_INITIALIZING:
            IF xSafetyOK AND
               NOT xBlockingFault AND
               NOT xSelectorFault AND
               NOT xBlowerFault THEN
                eState := LINE_READY;
            END_IF;

        LINE_READY:
            xReady := TRUE;

            IF xAcceptJob THEN
                IF NOT xDesktopCommunicationOK THEN
                    xJobRejected := TRUE;
                    uiResultCode := c_uiResultDesktopOffline;
                ELSIF NOT xCandidateIntegrityValid THEN
                    xJobRejected := TRUE;
                    uiResultCode := c_uiResultIntegrity;
                ELSIF NOT xCandidateValid THEN
                    xJobRejected := TRUE;
                    uiResultCode := c_uiResultInvalidCandidate;
                ELSE
                    stAcceptedJob := stJobCandidate;
                    stAcceptedRecipe := stRecipeCandidate;
                    xActiveJobValid := TRUE;
                    xJobAccepted := TRUE;
                    xShutdownForPause := FALSE;
                    xShutdownForCancel := FALSE;
                    xShutdownForStop := FALSE;
                    xCompleteEventIssued := FALSE;
                    stLine.udiDeliveredFeedCentiKg := 0;
                    uiResultCode := c_uiResultAccepted;
                    eState := LINE_LOAD_JOB;
                END_IF;
            END_IF;

        LINE_LOAD_JOB:
            IF xStart AND
               (NOT xHasAcceptedCommand OR
                (udiCommandSequence <>
                 udiLastAcceptedCommandSequence)) THEN
                udiLastAcceptedCommandSequence :=
                    udiCommandSequence;
                xHasAcceptedCommand := TRUE;
                udiExecutionStartTickMs :=
                    udiMonotonicTickMs;
                eState := LINE_VALIDATE;
            END_IF;

        LINE_VALIDATE:
            IF NOT xSafetyOK OR xBlockingFault OR
               NOT xSelectorReady OR
               NOT xBlowerReady OR
               NOT xSelectedDosingReady THEN
                eState := LINE_FAULT;
                uiResultCode := c_uiResultEquipmentNotReady;
            ELSIF udiInternalCommandSequence =
                  16#FFFFFFFF THEN
                eState := LINE_FAULT;
                uiResultCode := c_uiResultSequenceOverflow;
            ELSE
                udiInternalCommandSequence :=
                    udiInternalCommandSequence + 1;
                udiSelectorCommandSequence :=
                    udiInternalCommandSequence;
                eState := LINE_MOVE_SELECTOR;
            END_IF;

        LINE_MOVE_SELECTOR:
            xSelectorMoveRequest := TRUE;
            uiSelectorTargetOutlet :=
                stAcceptedJob.uiTargetSelectorOutlet;
            eState := LINE_WAIT_SELECTOR;
            xSelectorSettleTimerActive := FALSE;

        LINE_WAIT_SELECTOR:
            uiSelectorTargetOutlet :=
                stAcceptedJob.uiTargetSelectorOutlet;

            IF xSelectorInPosition AND
               (uiSelectorOutlet =
                stAcceptedJob.uiTargetSelectorOutlet) THEN
                IF NOT xSelectorSettleTimerActive THEN
                    udiStateStartTickMs :=
                        udiMonotonicTickMs;
                    xSelectorSettleTimerActive := TRUE;
                ELSIF F_ElapsedMs(
                          udiCurrentTickMs :=
                              udiMonotonicTickMs,
                          udiStartTickMs :=
                              udiStateStartTickMs) >=
                      stAcceptedRecipe.
                          udiSelectorSettleTimeMs THEN
                    eState := LINE_START_BLOWER;
                END_IF;
            ELSE
                xSelectorSettleTimerActive := FALSE;
            END_IF;

        LINE_START_BLOWER:
            IF udiInternalCommandSequence =
               16#FFFFFFFF THEN
                eState := LINE_FAULT;
                uiResultCode := c_uiResultSequenceOverflow;
            ELSE
                udiInternalCommandSequence :=
                    udiInternalCommandSequence + 1;
                udiBlowerCommandSequence :=
                    udiInternalCommandSequence;
                eState := LINE_WAIT_BLOWER;
            END_IF;

        LINE_WAIT_BLOWER:
            xBlowerRunRequest := TRUE;
            uiBlowerTargetFreqCentiHz :=
                stAcceptedRecipe.uiBlowerFreqCentiHz;
            udiBlowerRequestedPostRunTimeMs :=
                stAcceptedRecipe.udiBlowerPostRunTimeMs;

            IF xBlowerAtSpeed AND
               xBlowerDosingPermitted THEN
                udiStateStartTickMs :=
                    udiMonotonicTickMs;
                eState := LINE_PRE_RUN;
            END_IF;

        LINE_PRE_RUN:
            xBlowerRunRequest := TRUE;
            uiBlowerTargetFreqCentiHz :=
                stAcceptedRecipe.uiBlowerFreqCentiHz;
            udiBlowerRequestedPostRunTimeMs :=
                stAcceptedRecipe.udiBlowerPostRunTimeMs;

            IF NOT xSelectorInPosition OR
               (uiSelectorOutlet <>
                stAcceptedJob.uiTargetSelectorOutlet) OR
               NOT xBlowerDosingPermitted THEN
                eState := LINE_FAULT;
                uiResultCode := c_uiResultEquipmentFault;
            ELSIF F_ElapsedMs(
                      udiCurrentTickMs :=
                          udiMonotonicTickMs,
                      udiStartTickMs :=
                          udiStateStartTickMs) >=
                  stAcceptedRecipe.
                      udiBlowerPreRunTimeMs THEN
                eState := LINE_START_DOSING;
            END_IF;

        LINE_START_DOSING:
            xBlowerRunRequest := TRUE;
            uiBlowerTargetFreqCentiHz :=
                stAcceptedRecipe.uiBlowerFreqCentiHz;
            udiBlowerRequestedPostRunTimeMs :=
                stAcceptedRecipe.udiBlowerPostRunTimeMs;

            IF udiInternalCommandSequence =
               16#FFFFFFFF THEN
                eState := LINE_FAULT;
                uiResultCode := c_uiResultSequenceOverflow;
            ELSE
                udiInternalCommandSequence :=
                    udiInternalCommandSequence + 1;
                IF stAcceptedJob.byDosingUnitMask =
                   16#01 THEN
                    udiDosing1CommandSequence :=
                        udiInternalCommandSequence;
                ELSE
                    udiDosing2CommandSequence :=
                        udiInternalCommandSequence;
                END_IF;

                IF stLine.udiDeliveredFeedCentiKg >=
                   stAcceptedJob.udiTargetFeedCentiKg THEN
                    udiSelectedDosingTarget := 0;
                ELSE
                    udiSelectedDosingTarget :=
                        stAcceptedJob.
                            udiTargetFeedCentiKg -
                        stLine.
                            udiDeliveredFeedCentiKg;
                END_IF;
                eState := LINE_FEEDING;
            END_IF;

        LINE_FEEDING:
            xBlowerRunRequest := TRUE;
            uiBlowerTargetFreqCentiHz :=
                stAcceptedRecipe.uiBlowerFreqCentiHz;
            udiBlowerRequestedPostRunTimeMs :=
                stAcceptedRecipe.udiBlowerPostRunTimeMs;

            IF stAcceptedJob.byDosingUnitMask = 16#01 THEN
                xDosing1StartRequest := TRUE;
                udiDosing1JobId := stAcceptedJob.udiJobId;
                uiDosing1OutletId :=
                    stAcceptedJob.uiTargetSelectorOutlet;
                udiDosing1TargetCentiKg :=
                    udiSelectedDosingTarget;
                uiDosing1SpeedPermille :=
                    stAcceptedRecipe.uiDosingSpeedPermille;
            ELSE
                xDosing2StartRequest := TRUE;
                udiDosing2JobId := stAcceptedJob.udiJobId;
                uiDosing2OutletId :=
                    stAcceptedJob.uiTargetSelectorOutlet;
                udiDosing2TargetCentiKg :=
                    udiSelectedDosingTarget;
                uiDosing2SpeedPermille :=
                    stAcceptedRecipe.uiDosingSpeedPermille;
            END_IF;

            IF NOT xSelectorInPosition OR
               (uiSelectorOutlet <>
                stAcceptedJob.uiTargetSelectorOutlet) OR
               NOT xBlowerDosingPermitted THEN
                eState := LINE_FAULT;
                uiResultCode := c_uiResultEquipmentFault;
            ELSE
                IF udiSelectedDosingIncrement >
                   (stAcceptedJob.udiTargetFeedCentiKg -
                    stLine.udiDeliveredFeedCentiKg) THEN
                    stLine.udiDeliveredFeedCentiKg :=
                        stAcceptedJob.udiTargetFeedCentiKg;
                ELSE
                    stLine.udiDeliveredFeedCentiKg :=
                        stLine.udiDeliveredFeedCentiKg +
                        udiSelectedDosingIncrement;
                END_IF;

                IF xSelectedDosingComplete THEN
                    eState := LINE_STOP_DOSING;
                END_IF;
            END_IF;

        LINE_STOP_DOSING:
            xBlowerRunRequest := xBlowerRunning;
            uiBlowerTargetFreqCentiHz :=
                stAcceptedRecipe.uiBlowerFreqCentiHz;
            udiBlowerRequestedPostRunTimeMs :=
                stAcceptedRecipe.udiBlowerPostRunTimeMs;

            IF stAcceptedJob.byDosingUnitMask = 16#01 THEN
                xDosing1StopRequest := TRUE;
            ELSE
                xDosing2StopRequest := TRUE;
            END_IF;

            IF NOT xSelectedDosingRunning THEN
                eState := LINE_POST_RUN;
            END_IF;

        LINE_POST_RUN:
            xBlowerRunRequest := TRUE;
            xBlowerNormalStopRequest := TRUE;
            uiBlowerTargetFreqCentiHz :=
                stAcceptedRecipe.uiBlowerFreqCentiHz;
            udiBlowerRequestedPostRunTimeMs :=
                stAcceptedRecipe.udiBlowerPostRunTimeMs;

            IF NOT xBlowerRunning AND xBlowerReady THEN
                IF xShutdownForPause THEN
                    eState := LINE_PAUSED;
                ELSIF xShutdownForCancel THEN
                    xActiveJobValid := FALSE;
                    uiResultCode := c_uiResultCancelled;
                    eState := LINE_READY;
                ELSIF xShutdownForStop THEN
                    xActiveJobValid := FALSE;
                    uiResultCode := c_uiResultStopped;
                    eState := LINE_READY;
                ELSE
                    eState := LINE_COMPLETE;
                    xCompleteEventIssued := FALSE;
                END_IF;
            END_IF;

        LINE_COMPLETE:
            IF NOT xCompleteEventIssued THEN
                xCompleted := TRUE;
                xCompleteEventIssued := TRUE;
                uiResultCode := c_uiResultCompleted;
            ELSE
                xActiveJobValid := FALSE;
                xCompleteEventIssued := FALSE;
                eState := LINE_READY;
            END_IF;

        LINE_PAUSED:
            IF xStart AND
               (udiCommandSequence <>
                udiLastAcceptedCommandSequence) AND
               xSafetyOK AND
               NOT xBlockingFault THEN
                udiLastAcceptedCommandSequence :=
                    udiCommandSequence;
                xShutdownForPause := FALSE;
                xShutdownForCancel := FALSE;
                xShutdownForStop := FALSE;
                eState := LINE_VALIDATE;
            ELSIF xCancel OR xStop THEN
                xActiveJobValid := FALSE;
                IF xCancel THEN
                    uiResultCode := c_uiResultCancelled;
                ELSE
                    uiResultCode := c_uiResultStopped;
                END_IF;
                eState := LINE_READY;
            END_IF;

        LINE_STOPPING:
            eState := LINE_STOP_DOSING;

        LINE_RECOVERY:
            eState := LINE_VALIDATE;

        LINE_FAULT:
            IF (NOT xHasAcceptedReset OR
                (udiResetSequence <> udiLastResetSequence)) AND
               NOT xEmergencyStop AND
               xSafetyOK AND
               NOT xBlockingFault AND
               NOT xSelectorFault AND
               NOT xBlowerFault AND
               NOT xSelectedDosingFault AND
               NOT xSelectorMoveRequest AND
               NOT xBlowerRunning AND
               NOT xSelectedDosingRunning THEN
                udiLastResetSequence := udiResetSequence;
                xHasAcceptedReset := TRUE;
                udiEquipmentResetSequence :=
                    udiResetSequence;
                xEquipmentResetRequest := TRUE;
                xActiveJobValid := FALSE;
                xShutdownForPause := FALSE;
                xShutdownForCancel := FALSE;
                xShutdownForStop := FALSE;
                eState := LINE_INITIALIZING;
                uiResultCode := c_uiResultNone;
            END_IF;

        LINE_EMERGENCY:
            IF (NOT xHasAcceptedReset OR
                (udiResetSequence <> udiLastResetSequence)) AND
               NOT xEmergencyStop AND
               xSafetyOK AND
               NOT xBlockingFault AND
               NOT xBlowerRunning AND
               NOT xSelectedDosingRunning THEN
                udiLastResetSequence := udiResetSequence;
                xHasAcceptedReset := TRUE;
                udiEquipmentResetSequence :=
                    udiResetSequence;
                xEquipmentResetRequest := TRUE;
                xActiveJobValid := FALSE;
                eState := LINE_INITIALIZING;
                uiResultCode := c_uiResultNone;
            END_IF;

        LINE_SERVICE:
            eState := LINE_READY;

    ELSE
        eState := LINE_FAULT;
        uiResultCode := c_uiResultInvalidConfig;
    END_CASE;
END_IF;

IF (eState = LINE_FAULT) OR
   (eState = LINE_EMERGENCY) OR
   (eState = LINE_OFF) THEN
    xSelectorMoveRequest := FALSE;
    xBlowerRunRequest := FALSE;
    xBlowerNormalStopRequest := FALSE;
    xDosing1StartRequest := FALSE;
    xDosing2StartRequest := FALSE;
END_IF;

IF xActiveJobValid THEN
    IF stLine.udiDeliveredFeedCentiKg >=
       stAcceptedJob.udiTargetFeedCentiKg THEN
        stLine.udiRemainingFeedCentiKg := 0;
        stLine.uiProgressPermille := 1000;
    ELSE
        stLine.udiRemainingFeedCentiKg :=
            stAcceptedJob.udiTargetFeedCentiKg -
            stLine.udiDeliveredFeedCentiKg;
        stLine.uiProgressPermille :=
            UDINT_TO_UINT(
                (stLine.udiDeliveredFeedCentiKg * 1000) /
                stAcceptedJob.udiTargetFeedCentiKg);
    END_IF;
ELSE
    stLine.udiRemainingFeedCentiKg := 0;
    stLine.uiProgressPermille := 0;
END_IF;

stLine.usiLineId := stConfig.usiLineId;
stLine.eLineState := eState;
stLine.xEnabled := xEnableFromSystem;
stLine.xReady := xReady;
stLine.xBusy := xActiveJobValid;
stLine.xRunning := (eState >= LINE_MOVE_SELECTOR) AND
                   (eState <= LINE_POST_RUN);
stLine.xPaused := eState = LINE_PAUSED;
stLine.xCompleted := xCompleted;
stLine.xFault := eState = LINE_FAULT;
stLine.xEmergency := eState = LINE_EMERGENCY;
stLine.xAutoMode := TRUE;
stLine.xManualMode := FALSE;
stLine.xServiceMode := FALSE;
stLine.xSimulationMode := FALSE;
stLine.xActiveJobValid := xActiveJobValid;
stLine.udiActiveJobId := stAcceptedJob.udiJobId;
stLine.uiActiveRecipeId := stAcceptedJob.uiRecipeId;
stLine.uiTargetSelectorOutlet :=
    stAcceptedJob.uiTargetSelectorOutlet;
stLine.uiCurrentSelectorOutlet := uiSelectorOutlet;
stLine.xSelectorAtTarget :=
    xSelectorInPosition AND
    (uiSelectorOutlet =
     stAcceptedJob.uiTargetSelectorOutlet);
stLine.udiTargetFeedCentiKg :=
    stAcceptedJob.udiTargetFeedCentiKg;
stLine.udiElapsedTimeSec :=
    F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                udiStartTickMs := udiExecutionStartTickMs) /
    1000;
stLine.udiRemainingTimeSec := 0;
stLine.xBlowerRunning := xBlowerRunning;
stLine.xDosing1Running := xDosing1Running;
stLine.xDosing2Running := xDosing2Running;
stLine.uiActiveAlarmId := 0;

xReady := eState = LINE_READY;
xBusy := xActiveJobValid;

END_FUNCTION_BLOCK
