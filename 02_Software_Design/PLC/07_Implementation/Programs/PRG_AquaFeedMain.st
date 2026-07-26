PROGRAM PRG_AquaFeedMain
VAR
    fbTime : FB_TimeService;
    fbIO : FB_IOManager;
    fbSafety : FB_SafetyCoordinator;
    fbAlarm : FB_AlarmManager;
    fbDiagnostics : FB_DiagnosticsManager;
    fbSelectorDevice : FB_DeviceManager;
    fbBlowerDevice : FB_DeviceManager;
    fbDosing1Device : FB_DeviceManager;
    fbDosing2Device : FB_DeviceManager;
    fbDesktopCommunication : FB_CommunicationManager;
    fbHealth : FB_HealthMonitor;
    fbSelector : FB_Selector;
    fbBlower : FB_Blower;
    fbDosing1 : FB_Dosing;
    fbDosing2 : FB_Dosing;
    fbLine1 : FB_LineManager;
    fbRecovery : FB_RecoveryManager;
    fbSystem : FB_SystemManager;

    stRawIO : ST_IO;
    stRequestedIO : ST_IO;
    stSystem : ST_SystemStatus;
    stLine1Config : ST_LineConfig;
    stSelectorConfig : ST_SelectorConfig;
    stBlowerConfig : ST_BlowerConfig;
    stDosing1Config : ST_DosingConfig;
    stDosing2Config : ST_DosingConfig;
    stJobCandidate : ST_JobExecution;
    stRecipeCandidate : ST_RecipeExecution;
    stRecoveryCheckpoint : ST_RecoveryCheckpoint;
    astAlarmConditions : ARRAY[0..31] OF ST_AlarmCondition;
END_VAR

(* Compile-safe one-line composition shell.
   All configuration structures remain zero until approved vendor/bench
   parameters are entered. Safety feedback is invalid and physical output
   permission is deliberately FALSE. This program cannot energize equipment. *)

IF g_udiScanSequence < c_udiCounterMaximum THEN
    g_udiScanSequence := g_udiScanSequence + 1;
END_IF;

(* 1. Monotonic time source. Vendor runtime tick is not mapped yet. *)
fbTime(
    udiRuntimeTickMs := 0,
    xRuntimeTickHealthy := FALSE,
    udiSyncSequence := 0,
    xSyncRequest := FALSE);

(* 2. IO snapshot and final-output owner.
   Applied outputs remain safe because permission is hard FALSE. *)
fbIO(
    stRawInputs := stRawIO,
    xHardwareConfigValid := FALSE,
    xWatchdogHealthy := FALSE,
    stRequestedOutputs := stRequestedIO,
    xOutputsPermitted := FALSE,
    xSafetyOK := FALSE,
    xCommissioningMode := FALSE,
    udiCommandSequence := g_udiScanSequence);

(* 3. Standard-PLC observation of approved hardwired safety. *)
fbSafety(
    xFeedbackValid := FALSE,
    xEmergencyActive := TRUE,
    xSafetyRelayHealthy := FALSE,
    xSTOFeedbackHealthy := FALSE,
    xContactorFeedbackHealthy := FALSE,
    xStandardControlPermitRequest := FALSE,
    xLocalResetRequest := FALSE,
    udiResetSequence := 0,
    xEquipmentStopped := TRUE);

(* 4. Communication channel supervision; transport is not mapped. *)
fbDesktopCommunication(
    xEnable := FALSE,
    uiChannelId := 0,
    uiProfileId := 0,
    uiChannelType := 0,
    xRequiredForControl := FALSE,
    xTransportReady := FALSE,
    udiFreshnessTimeoutMs := 0,
    uiFailureThreshold := 0,
    xRxEvent := FALSE,
    xTxEvent := FALSE,
    xProtocolErrorEvent := FALSE,
    xTimeoutEvent := FALSE,
    udiReceivedSequence := 0,
    udiMonotonicTickMs := fbTime.stTime.udiMonotonicTickMs,
    xResetCountersRequest := FALSE,
    udiResetSequence := 0,
    xServicePermission := FALSE);

(* 5. One line consumes prior-scan equipment status and system permission. *)
fbLine1(
    xEnableFromSystem := fbSystem.xLineEnable,
    xStart := FALSE,
    xPause := FALSE,
    xStop := FALSE,
    xCancel := FALSE,
    udiCommandSequence := 0,
    udiResetSequence := 0,
    xEmergencyStop := TRUE,
    xSafetyOK := fbSafety.stSafety.xAutomaticPermitted,
    xBlockingFault := TRUE,
    xDesktopCommunicationOK :=
        fbDesktopCommunication.stChannel.xFresh,
    stConfig := stLine1Config,
    udiMonotonicTickMs := fbTime.stTime.udiMonotonicTickMs,
    xJobAvailable := FALSE,
    xAcceptJob := FALSE,
    xCandidateIntegrityValid := FALSE,
    stJobCandidate := stJobCandidate,
    stRecipeCandidate := stRecipeCandidate,
    xSelectorReady := fbSelector.xReady,
    xSelectorInPosition := fbSelector.xInPosition,
    uiSelectorOutlet := fbSelector.uiCurrentOutlet,
    xSelectorFault := (fbSelector.eState = SelectorFault),
    xBlowerReady := fbBlower.xReady,
    xBlowerRunning := fbBlower.xRunning,
    xBlowerAtSpeed := fbBlower.xAtSpeed,
    xBlowerDosingPermitted := fbBlower.xDosingPermitted,
    xBlowerFault := (fbBlower.eState = BlowerFault),
    xDosing1Ready := fbDosing1.xReady,
    xDosing1Running := fbDosing1.xRunning,
    xDosing1Fault := fbDosing1.xFault,
    xDosing1CompletedEvent := fbDosing1.xCompletedEvent,
    udiDosing1DeliveredCentiKg :=
        fbDosing1.udiDeliveredCentiKg,
    udiDosing1IncrementCentiKg :=
        fbDosing1.udiDeliveredIncrementCentiKg,
    xDosing2Ready := fbDosing2.xReady,
    xDosing2Running := fbDosing2.xRunning,
    xDosing2Fault := fbDosing2.xFault,
    xDosing2CompletedEvent := fbDosing2.xCompletedEvent,
    udiDosing2DeliveredCentiKg :=
        fbDosing2.udiDeliveredCentiKg,
    udiDosing2IncrementCentiKg :=
        fbDosing2.udiDeliveredIncrementCentiKg);

(* 6. Equipment blocks consume current LineManager requests. *)
fbSelector(
    xEnable := FALSE,
    xHomeRequest := FALSE,
    xMoveRequest := fbLine1.xSelectorMoveRequest,
    uiTargetOutlet := fbLine1.uiSelectorTargetOutlet,
    udiCommandSequence := fbLine1.udiSelectorCommandSequence,
    udiResetSequence := fbLine1.udiEquipmentResetSequence,
    xStopRequest := TRUE,
    xServicePermission := FALSE,
    xSafetyOK := fbSafety.stSafety.xMotionPermitted,
    diPosition := 0,
    xPositionValid := FALSE,
    xLeftLimit := FALSE,
    xRightLimit := FALSE,
    xMotorRunning := FALSE,
    xMotorFault := FALSE,
    stConfig := stSelectorConfig,
    udiMonotonicTickMs := fbTime.stTime.udiMonotonicTickMs);

fbBlower(
    xEnable := FALSE,
    xRunRequest := fbLine1.xBlowerRunRequest,
    xNormalStopRequest := TRUE,
    uiTargetFreqCentiHz :=
        fbLine1.uiBlowerTargetFreqCentiHz,
    udiRequestedPostRunTimeMs :=
        fbLine1.udiBlowerRequestedPostRunTimeMs,
    udiCommandSequence := fbLine1.udiBlowerCommandSequence,
    udiResetSequence := fbLine1.udiEquipmentResetSequence,
    xSafetyOK := fbSafety.stSafety.xBlowerPermitted,
    xDriveReady := FALSE,
    xDriveRunning := FALSE,
    xDriveFault := TRUE,
    xCommunicationHealthy := FALSE,
    uiActualFreqCentiHz := 0,
    uiDriveFaultCode := 0,
    stConfig := stBlowerConfig,
    udiMonotonicTickMs := fbTime.stTime.udiMonotonicTickMs);

fbDosing1(
    xEnable := FALSE,
    xStartRequest := fbLine1.xDosing1StartRequest,
    xStopRequest := TRUE,
    udiCommandSequence := fbLine1.udiDosing1CommandSequence,
    udiResetSequence := fbLine1.udiEquipmentResetSequence,
    udiJobId := fbLine1.udiDosing1JobId,
    uiOutletId := fbLine1.uiDosing1OutletId,
    udiTargetCentiKg := fbLine1.udiDosing1TargetCentiKg,
    uiTargetSpeedPermille := fbLine1.uiDosing1SpeedPermille,
    udiCentiKgPer1000Pulses := 0,
    uiCalibrationVersion := 0,
    xSelectorInPosition := fbSelector.xInPosition,
    xBlowerAtSpeed := fbBlower.xAtSpeed,
    xFeedAvailable := FALSE,
    xSafetyOK := fbSafety.stSafety.xDosingPermitted,
    xDriveRunning := FALSE,
    xDriveFault := TRUE,
    xPulse := FALSE,
    stConfig := stDosing1Config,
    udiMonotonicTickMs := fbTime.stTime.udiMonotonicTickMs);

fbDosing2(
    xEnable := FALSE,
    xStartRequest := fbLine1.xDosing2StartRequest,
    xStopRequest := TRUE,
    udiCommandSequence := fbLine1.udiDosing2CommandSequence,
    udiResetSequence := fbLine1.udiEquipmentResetSequence,
    udiJobId := fbLine1.udiDosing2JobId,
    uiOutletId := fbLine1.uiDosing2OutletId,
    udiTargetCentiKg := fbLine1.udiDosing2TargetCentiKg,
    uiTargetSpeedPermille := fbLine1.uiDosing2SpeedPermille,
    udiCentiKgPer1000Pulses := 0,
    uiCalibrationVersion := 0,
    xSelectorInPosition := fbSelector.xInPosition,
    xBlowerAtSpeed := fbBlower.xAtSpeed,
    xFeedAvailable := FALSE,
    xSafetyOK := fbSafety.stSafety.xDosingPermitted,
    xDriveRunning := FALSE,
    xDriveFault := TRUE,
    xPulse := FALSE,
    stConfig := stDosing2Config,
    udiMonotonicTickMs := fbTime.stTime.udiMonotonicTickMs);

(* 7. Common device snapshots do not command equipment. *)
fbSelectorDevice(
    uiDeviceId := 1,
    uiDeviceType := 10,
    usiLineId := 1,
    xEnableConfig := FALSE,
    xAutoRequest := FALSE,
    xManualRequest := FALSE,
    xRunFeedback := fbSelector.xMoving,
    xFaultFeedback := (fbSelector.eState = SelectorFault),
    xInterlockOK := FALSE,
    xCommunicationOK := TRUE);

fbBlowerDevice(
    uiDeviceId := 2,
    uiDeviceType := 20,
    usiLineId := 1,
    xEnableConfig := FALSE,
    xAutoRequest := FALSE,
    xManualRequest := FALSE,
    xRunFeedback := fbBlower.xRunning,
    xFaultFeedback := (fbBlower.eState = BlowerFault),
    xInterlockOK := FALSE,
    xCommunicationOK := FALSE);

fbDosing1Device(
    uiDeviceId := 3,
    uiDeviceType := 30,
    usiLineId := 1,
    xEnableConfig := FALSE,
    xAutoRequest := FALSE,
    xManualRequest := FALSE,
    xRunFeedback := fbDosing1.xRunning,
    xFaultFeedback := fbDosing1.xFault,
    xInterlockOK := FALSE,
    xCommunicationOK := TRUE);

fbDosing2Device(
    uiDeviceId := 4,
    uiDeviceType := 30,
    usiLineId := 1,
    xEnableConfig := FALSE,
    xAutoRequest := FALSE,
    xManualRequest := FALSE,
    xRunFeedback := fbDosing2.xRunning,
    xFaultFeedback := fbDosing2.xFault,
    xInterlockOK := FALSE,
    xCommunicationOK := TRUE);

(* 8. Alarm, diagnostics, recovery, and health aggregation. *)
fbAlarm(
    astConditions := astAlarmConditions,
    xAcknowledgeRequest := FALSE,
    xResetRequest := FALSE,
    udiCommandSequence := 0,
    uiTargetAlarmCode := 0,
    eTargetSource := ALARM_SOURCE_SYSTEM,
    usiTargetLineId := 0,
    uiTargetDeviceId := 0,
    udiAcceptedEventSequence := 0);

fbDiagnostics(
    xEnable := TRUE,
    udiScanTimeUs := 0,
    udiMaximumScanTimeUs := 0,
    xScanOverrunEvent := FALSE,
    udiScanOverrunSequence := 0,
    xWatchdogHealthy := FALSE,
    xConfigurationValid := FALSE,
    stIO := fbIO.stValidatedInputs,
    xRequiredCommunicationHealthy := FALSE,
    uiOfflineChannelCount := 1,
    uiActiveAlarmCount := fbAlarm.uiActiveAlarmCount,
    xEquipmentBlockingDiagnostic := TRUE,
    xEquipmentDegradedDiagnostic := FALSE,
    uiEquipmentDiagnosticCode := 0,
    uiEquipmentSeverity := 30,
    xCounterSaturation :=
        (g_udiScanSequence = c_udiCounterMaximum));

fbRecovery(
    xEvaluateRequest := FALSE,
    xResumeApproval := FALSE,
    xRejectRequest := FALSE,
    udiRecoverySequence := 0,
    xCheckpointPresent := FALSE,
    stCheckpoint := stRecoveryCheckpoint,
    xCheckpointIntegrityValid := FALSE,
    xDesktopCheckpointStillCurrent := FALSE,
    xSafetyRecoveryPermitted :=
        fbSafety.stSafety.xRecoveryPermitted,
    xEquipmentStopped := TRUE,
    xEquipmentFeedbackKnown := FALSE,
    xConfigurationValid := FALSE,
    xIOHealthy := fbIO.xReady,
    xCommunicationHealthy := FALSE,
    xSelectorReady := fbSelector.xReady,
    xBlowerReady := fbBlower.xReady,
    xDosingReady :=
        fbDosing1.xReady OR fbDosing2.xReady,
    xReinitializationComplete := FALSE,
    xReinitializationFailed := FALSE,
    xLineResumeAccepted := FALSE);

fbHealth(
    xSystemOperational := FALSE,
    xSafetyHealthy :=
        fbSafety.stSafety.xFeedbackValid,
    xIOHealthy := fbIO.xReady,
    xRequiredCommunicationHealthy := FALSE,
    xDesktopCommunicationHealthy := FALSE,
    xSelectorHealthy := fbSelectorDevice.stDevice.xAvailable,
    xBlowerHealthy := fbBlowerDevice.stDevice.xAvailable,
    xDosingHealthy :=
        fbDosing1Device.stDevice.xAvailable OR
        fbDosing2Device.stDevice.xAvailable,
    xConfigurationValid := FALSE,
    xDiagnosticsBlocking := fbDiagnostics.stDiagnostics.xFault,
    xDiagnosticsDegraded :=
        fbDiagnostics.stDiagnostics.xDegraded,
    uiDiagnosticsSeverity :=
        fbDiagnostics.stDiagnostics.uiHighestSeverity);

(* 9. System lifecycle publishes fail-closed status for this shell. *)
fbSystem(
    xEnable := FALSE,
    xStart := FALSE,
    xStop := TRUE,
    xPause := FALSE,
    xReset := FALSE,
    xAutoRequest := FALSE,
    xManualRequest := FALSE,
    xServiceRequest := FALSE,
    xSimulationRequest := FALSE,
    xEmergencyStop := TRUE,
    xSafetyOK := fbSafety.stSafety.xAutomaticPermitted,
    xBlockingFault := TRUE,
    xAllRequiredLinesReady := fbLine1.xReady,
    xAnyLineRunning := fbLine1.stLine.xRunning,
    xAllLinesStopped := NOT fbLine1.stLine.xRunning,
    xDesktopCommunicationOK := FALSE,
    xAlarmActive := fbAlarm.xAnyAlarmActive,
    xFeedingActive := fbLine1.stLine.xRunning,
    usiCurrentLine := 1,
    uiActiveRecipeId := fbLine1.stLine.uiActiveRecipeId,
    udiCurrentJobId := fbLine1.stLine.udiActiveJobId,
    stSystemStatus := stSystem);

END_PROGRAM
