FUNCTION_BLOCK FB_RecoveryManager
VAR_INPUT
    xEvaluateRequest : BOOL;
    xResumeApproval : BOOL;
    xRejectRequest : BOOL;
    udiRecoverySequence : UDINT;
    xCheckpointPresent : BOOL;
    stCheckpoint : ST_RecoveryCheckpoint;
    xCheckpointIntegrityValid : BOOL;
    xDesktopCheckpointStillCurrent : BOOL;
    xSafetyRecoveryPermitted : BOOL;
    xEquipmentStopped : BOOL;
    xEquipmentFeedbackKnown : BOOL;
    xConfigurationValid : BOOL;
    xIOHealthy : BOOL;
    xCommunicationHealthy : BOOL;
    xSelectorReady : BOOL;
    xBlowerReady : BOOL;
    xDosingReady : BOOL;
    xReinitializationComplete : BOOL;
    xReinitializationFailed : BOOL;
    xLineResumeAccepted : BOOL;
END_VAR
VAR_OUTPUT
    stRecovery : ST_RecoveryStatus;
    stApprovedJob : ST_JobExecution;
    stApprovedRecipe : ST_RecipeExecution;
    udiApprovedDeliveredCentiKg : UDINT;
    xReinitializeRequest : BOOL;
    xResumeCommandAccepted : BOOL;
    xRequestRejected : BOOL;
END_VAR
VAR
    stAcceptedCheckpoint : ST_RecoveryCheckpoint;
    xHasProcessedRequest : BOOL;
    udiLastProcessedSequence : UDINT;
    xCommandConflict : BOOL;
    xNewRequest : BOOL;
    xLiveValid : BOOL;
    xSnapshotValid : BOOL;
END_VAR
VAR CONSTANT
    c_uiResultNone : UINT := 0;
    c_uiResultCommandConflict : UINT := 1;
    c_uiResultCheckpointMissing : UINT := 10;
    c_uiResultIntegrityInvalid : UINT := 11;
    c_uiResultSnapshotInvalid : UINT := 12;
    c_uiResultQuantityInvalid : UINT := 13;
    c_uiResultTerminalExecution : UINT := 14;
    c_uiResultRetryExhausted : UINT := 15;
    c_uiResultDesktopSuperseded : UINT := 20;
    c_uiResultSafetyBlocked : UINT := 21;
    c_uiResultEquipmentUnknown : UINT := 22;
    c_uiResultPrerequisiteFailed : UINT := 23;
    c_uiResultReinitializationFailed : UINT := 30;
    c_uiResultSequenceExhausted : UINT := 31;
    c_uiResultUnknownState : UINT := 90;
END_VAR

xReinitializeRequest := FALSE;
xResumeCommandAccepted := FALSE;
xRequestRejected := FALSE;
stRecovery.xRecoveryAvailable := FALSE;
stRecovery.xApprovalRequired := FALSE;
stRecovery.xReadyToResume := FALSE;
stRecovery.xApprovedCheckpointValid := FALSE;

xCommandConflict := (xEvaluateRequest AND xResumeApproval) OR
                    (xEvaluateRequest AND xRejectRequest) OR
                    (xResumeApproval AND xRejectRequest);
xNewRequest := (xEvaluateRequest OR xResumeApproval OR xRejectRequest) AND
               (NOT xHasProcessedRequest OR
                (udiRecoverySequence <> udiLastProcessedSequence));

xLiveValid := xDesktopCheckpointStillCurrent AND
              xSafetyRecoveryPermitted AND
              xEquipmentStopped AND
              xEquipmentFeedbackKnown AND
              xConfigurationValid AND
              xIOHealthy AND
              xCommunicationHealthy AND
              xSelectorReady AND
              xBlowerReady AND
              xDosingReady;

IF xNewRequest THEN
    IF xHasProcessedRequest AND
       (udiLastProcessedSequence = 16#FFFFFFFF) AND
       (udiRecoverySequence = 0) THEN
        stRecovery.eState := RecoveryFailed;
        stRecovery.uiResultCode := c_uiResultSequenceExhausted;
        xRequestRejected := TRUE;
    ELSE
        xHasProcessedRequest := TRUE;
        udiLastProcessedSequence := udiRecoverySequence;
        stRecovery.udiLastProcessedRecoverySequence := udiRecoverySequence;

        IF xCommandConflict THEN
            xRequestRejected := TRUE;
            stRecovery.uiResultCode := c_uiResultCommandConflict;
        ELSIF xRejectRequest THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultNone;
            xRequestRejected := TRUE;
        ELSIF xEvaluateRequest THEN
            stAcceptedCheckpoint := stCheckpoint;
            stRecovery.eState := RecoveryEvaluating;
            stRecovery.uiResultCode := c_uiResultNone;
        ELSIF xResumeApproval THEN
            IF stRecovery.eState <> RecoveryAwaitingApproval THEN
                xRequestRejected := TRUE;
                stRecovery.uiResultCode := c_uiResultSnapshotInvalid;
            ELSIF NOT xLiveValid THEN
                xRequestRejected := TRUE;
                stRecovery.eState := RecoveryFailed;
                stRecovery.uiResultCode := c_uiResultPrerequisiteFailed;
            ELSE
                stRecovery.eState := RecoveryReinitializing;
                stRecovery.uiResultCode := c_uiResultNone;
                xResumeCommandAccepted := TRUE;
            END_IF;
        END_IF;
    END_IF;
END_IF;

CASE stRecovery.eState OF
    RecoveryIdle:
        stRecovery.uiResultCode := c_uiResultNone;

    RecoveryEvaluating:
        xSnapshotValid :=
            xCheckpointPresent AND
            xCheckpointIntegrityValid AND
            (stAcceptedCheckpoint.uiCheckpointVersion = 1) AND
            (stAcceptedCheckpoint.stJob.uiSnapshotVersion = 1) AND
            (stAcceptedCheckpoint.stRecipe.uiSnapshotVersion = 1) AND
            (stAcceptedCheckpoint.stJob.udiJobId <> 0) AND
            (stAcceptedCheckpoint.stJob.usiLineId <> 0) AND
            (stAcceptedCheckpoint.stJob.uiRecipeId =
             stAcceptedCheckpoint.stRecipe.uiRecipeId) AND
            (stAcceptedCheckpoint.stJob.udiRecipeRevision =
             stAcceptedCheckpoint.stRecipe.udiRecipeRevision) AND
            (stAcceptedCheckpoint.stJob.udiTargetFeedCentiKg > 0) AND
            (stAcceptedCheckpoint.stJob.uiTargetSelectorOutlet > 0) AND
            stAcceptedCheckpoint.stJob.xAllowRecovery;

        stRecovery.xSnapshotPresent := xCheckpointPresent;
        stRecovery.xSnapshotValid := FALSE;

        IF NOT xCheckpointPresent THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultCheckpointMissing;
        ELSIF NOT xCheckpointIntegrityValid THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultIntegrityInvalid;
        ELSIF NOT xSnapshotValid THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultSnapshotInvalid;
        ELSIF stAcceptedCheckpoint.xExecutionCompleted OR
              stAcceptedCheckpoint.xExecutionCancelled THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultTerminalExecution;
        ELSIF NOT stAcceptedCheckpoint.xQuantityTrustworthy OR
              (stAcceptedCheckpoint.udiDeliveredFeedCentiKg >
               stAcceptedCheckpoint.stJob.udiTargetFeedCentiKg) THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultQuantityInvalid;
        ELSIF stAcceptedCheckpoint.usiRetryCount >=
              stAcceptedCheckpoint.stJob.usiMaximumRetryCount THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultRetryExhausted;
        ELSIF NOT xDesktopCheckpointStillCurrent THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultDesktopSuperseded;
        ELSIF NOT xSafetyRecoveryPermitted THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultSafetyBlocked;
        ELSIF NOT xEquipmentStopped OR NOT xEquipmentFeedbackKnown THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultEquipmentUnknown;
        ELSIF NOT xLiveValid THEN
            stRecovery.eState := RecoveryRejected;
            stRecovery.uiResultCode := c_uiResultPrerequisiteFailed;
        ELSE
            stRecovery.xSnapshotValid := TRUE;
            stRecovery.udiJobId := stAcceptedCheckpoint.stJob.udiJobId;
            stRecovery.udiRecipeRevision :=
                stAcceptedCheckpoint.stRecipe.udiRecipeRevision;
            stRecovery.usiLineId := stAcceptedCheckpoint.stJob.usiLineId;
            stRecovery.uiOutletId :=
                stAcceptedCheckpoint.stJob.uiTargetSelectorOutlet;
            stRecovery.udiTargetFeedCentiKg :=
                stAcceptedCheckpoint.stJob.udiTargetFeedCentiKg;
            stRecovery.udiDeliveredCentiKg :=
                stAcceptedCheckpoint.udiDeliveredFeedCentiKg;
            stRecovery.udiRemainingFeedCentiKg :=
                stAcceptedCheckpoint.stJob.udiTargetFeedCentiKg -
                stAcceptedCheckpoint.udiDeliveredFeedCentiKg;
            stRecovery.usiRetryCount := stAcceptedCheckpoint.usiRetryCount;
            stRecovery.udiLastAcceptedCommandSequence :=
                stAcceptedCheckpoint.udiLastAcceptedCommandSequence;
            stRecovery.uiInterruptionReason :=
                stAcceptedCheckpoint.uiInterruptionReason;
            stRecovery.eState := RecoveryAvailable;
            stRecovery.uiResultCode := c_uiResultNone;
        END_IF;

    RecoveryAvailable:
        stRecovery.xRecoveryAvailable := TRUE;
        stRecovery.eState := RecoveryAwaitingApproval;

    RecoveryAwaitingApproval:
        stRecovery.xRecoveryAvailable := TRUE;
        stRecovery.xApprovalRequired := TRUE;

    RecoveryReinitializing:
        IF NOT xLiveValid THEN
            stRecovery.eState := RecoveryFailed;
            stRecovery.uiResultCode := c_uiResultPrerequisiteFailed;
        ELSIF xReinitializationFailed THEN
            stRecovery.eState := RecoveryFailed;
            stRecovery.uiResultCode := c_uiResultReinitializationFailed;
        ELSIF xReinitializationComplete THEN
            stApprovedJob := stAcceptedCheckpoint.stJob;
            stApprovedRecipe := stAcceptedCheckpoint.stRecipe;
            udiApprovedDeliveredCentiKg :=
                stAcceptedCheckpoint.udiDeliveredFeedCentiKg;
            stRecovery.eState := RecoveryReadyToResume;
            stRecovery.uiResultCode := c_uiResultNone;
        ELSE
            xReinitializeRequest := TRUE;
        END_IF;

    RecoveryReadyToResume:
        IF NOT xLiveValid THEN
            stRecovery.eState := RecoveryFailed;
            stRecovery.uiResultCode := c_uiResultPrerequisiteFailed;
        ELSE
            stRecovery.xReadyToResume := TRUE;
            stRecovery.xApprovedCheckpointValid := TRUE;
            IF xLineResumeAccepted THEN
                stRecovery.eState := RecoveryCompleted;
            END_IF;
        END_IF;

    RecoveryCompleted:
        stRecovery.uiResultCode := c_uiResultNone;

    RecoveryRejected:
        stRecovery.xSnapshotValid := FALSE;

    RecoveryFailed:
        stRecovery.xSnapshotValid := FALSE;

ELSE
    stRecovery.eState := RecoveryFailed;
    stRecovery.uiResultCode := c_uiResultUnknownState;
END_CASE;

END_FUNCTION_BLOCK
