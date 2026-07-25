TYPE E_SystemState :
(
    SYSTEM_OFF := 0,
    SYSTEM_INITIALIZING := 10,
    SYSTEM_READY := 20,
    SYSTEM_RUNNING := 30,
    SYSTEM_PAUSED := 40,
    SYSTEM_STOPPING := 50,
    SYSTEM_FAULT := 90,
    SYSTEM_EMERGENCY := 100
);
END_TYPE

TYPE ST_SystemStatus :
STRUCT
    SystemState : E_SystemState;
    SystemReady : BOOL;
    SystemRunning : BOOL;
    SystemPaused : BOOL;
    SystemStopped : BOOL;
    AutoMode : BOOL;
    ManualMode : BOOL;
    ServiceMode : BOOL;
    SimulationMode : BOOL;
    ModeConflict : BOOL;
    SafetyOK : BOOL;
    EmergencyStop : BOOL;
    BlockingFault : BOOL;
    AlarmActive : BOOL;
    DesktopCommunicationOK : BOOL;
    AllRequiredLinesReady : BOOL;
    AnyLineRunning : BOOL;
    FeedingActive : BOOL;
    CurrentLine : USINT;
    ActiveRecipeId : UINT;
    CurrentJobId : UDINT;
END_STRUCT;
END_TYPE

TYPE E_AlarmSeverity :
(
    ALARM_INFORMATION := 0,
    ALARM_WARNING := 10,
    ALARM_FAULT := 20,
    ALARM_CRITICAL := 30,
    ALARM_EMERGENCY := 40
);
END_TYPE

TYPE E_AlarmSource :
(
    ALARM_SOURCE_SYSTEM := 0,
    ALARM_SOURCE_SAFETY := 10,
    ALARM_SOURCE_IO := 20,
    ALARM_SOURCE_COMMUNICATION := 30,
    ALARM_SOURCE_LINE := 40,
    ALARM_SOURCE_SELECTOR := 50,
    ALARM_SOURCE_BLOWER := 60,
    ALARM_SOURCE_DOSING := 70,
    ALARM_SOURCE_POWER := 80,
    ALARM_SOURCE_AUXILIARY := 90
);
END_TYPE

TYPE E_AlarmState :
(
    ALARM_INACTIVE := 0,
    ALARM_ACTIVE_UNACKNOWLEDGED := 10,
    ALARM_ACTIVE_ACKNOWLEDGED := 20,
    ALARM_CLEARED_WAIT_RESET := 30
);
END_TYPE

TYPE E_AlarmEventType :
(
    ALARM_EVENT_ACTIVATED := 10,
    ALARM_EVENT_ACKNOWLEDGED := 20,
    ALARM_EVENT_CLEARED := 30,
    ALARM_EVENT_RESET := 40
);
END_TYPE

TYPE ST_AlarmCondition :
STRUCT
    Valid : BOOL;
    ConditionActive : BOOL;
    AlarmCode : UINT;
    Source : E_AlarmSource;
    Severity : E_AlarmSeverity;
    LineId : USINT;
    DeviceId : UINT;
    ResetRequired : BOOL;
    Blocking : BOOL;
END_STRUCT;
END_TYPE

TYPE ST_Alarm :
STRUCT
    AlarmCode : UINT;
    Source : E_AlarmSource;
    Severity : E_AlarmSeverity;
    State : E_AlarmState;
    LineId : USINT;
    DeviceId : UINT;
    ConditionActive : BOOL;
    Acknowledged : BOOL;
    ResetRequired : BOOL;
    Blocking : BOOL;
    ActivationSequence : UDINT;
    EventSequence : UDINT;
    OccurrenceCount : UINT;
END_STRUCT;
END_TYPE

TYPE ST_AlarmEvent :
STRUCT
    EventSequence : UDINT;
    EventType : E_AlarmEventType;
    AlarmCode : UINT;
    Source : E_AlarmSource;
    Severity : E_AlarmSeverity;
    State : E_AlarmState;
    LineId : USINT;
    DeviceId : UINT;
END_STRUCT;
END_TYPE

TYPE E_LineState :
(
    LINE_OFF := 0,
    LINE_INITIALIZING := 10,
    LINE_READY := 20,
    LINE_LOAD_JOB := 30,
    LINE_VALIDATE := 40,
    LINE_MOVE_SELECTOR := 50,
    LINE_WAIT_SELECTOR := 60,
    LINE_START_BLOWER := 70,
    LINE_WAIT_BLOWER := 80,
    LINE_PRE_RUN := 90,
    LINE_START_DOSING := 100,
    LINE_FEEDING := 110,
    LINE_STOP_DOSING := 120,
    LINE_POST_RUN := 130,
    LINE_COMPLETE := 140,
    LINE_PAUSED := 150,
    LINE_STOPPING := 160,
    LINE_RECOVERY := 170,
    LINE_FAULT := 190,
    LINE_EMERGENCY := 200,
    LINE_SERVICE := 210
);
END_TYPE

TYPE E_SelectorState :
(
    SelectorDisabled := 0,
    SelectorInitializing := 10,
    SelectorHoming := 20,
    SelectorReady := 30,
    SelectorMoving := 40,
    SelectorSettling := 50,
    SelectorFault := 90
);
END_TYPE

TYPE E_BlowerState :
(
    BlowerDisabled := 0,
    BlowerReady := 10,
    BlowerStarting := 20,
    BlowerAccelerating := 30,
    BlowerAtSpeed := 40,
    BlowerPostRun := 50,
    BlowerStopping := 60,
    BlowerFault := 90
);
END_TYPE

TYPE E_DosingState :
(
    DosingDisabled := 0,
    DosingReady := 10,
    DosingStarting := 20,
    DosingWaitFirstPulse := 30,
    DosingActive := 40,
    DosingStopping := 50,
    DosingComplete := 60,
    DosingFault := 90
);
END_TYPE

TYPE E_RecoveryState :
(
    RecoveryIdle := 0,
    RecoveryEvaluating := 10,
    RecoveryAvailable := 20,
    RecoveryAwaitingApproval := 30,
    RecoveryReinitializing := 40,
    RecoveryReadyToResume := 50,
    RecoveryCompleted := 60,
    RecoveryRejected := 80,
    RecoveryFailed := 90
);
END_TYPE

TYPE E_SafetyCoordinationState :
(
    SafetyUnknown := 0,
    SafetyHealthyStopped := 10,
    SafetyHealthyPermitted := 20,
    SafetyTripActive := 80,
    SafetyResetRequired := 90,
    SafetyFeedbackFault := 100
);
END_TYPE

TYPE ST_SafetyStatus :
STRUCT
    eState : E_SafetyCoordinationState;
    xFeedbackValid : BOOL;
    xEmergencyActive : BOOL;
    xSafetyRelayHealthy : BOOL;
    xSTOFeedbackHealthy : BOOL;
    xContactorFeedbackHealthy : BOOL;
    xResetRequired : BOOL;
    xAutomaticPermitted : BOOL;
    xMotionPermitted : BOOL;
    xBlowerPermitted : BOOL;
    xDosingPermitted : BOOL;
    xRecoveryPermitted : BOOL;
    udiLastAcceptedResetSequence : UDINT;
    uiDiagnosticCode : UINT;
END_STRUCT;
END_TYPE

TYPE ST_TimeService :
STRUCT
    udiMonotonicTickMs : UDINT;
    udiMonotonicSecondSequence : UDINT;
    xOneSecondTick : BOOL;
    xMonotonicHealthy : BOOL;
    dtObservedUtc : DT;
    xWallClockValid : BOOL;
    udiLastAcceptedSyncSequence : UDINT;
    uiTimeDiagnosticCode : UINT;
END_STRUCT;
END_TYPE

TYPE ST_IO :
STRUCT
    axDigitalInput : ARRAY[0..63] OF BOOL;
    axDigitalInputValid : ARRAY[0..63] OF BOOL;
    axDigitalOutput : ARRAY[0..63] OF BOOL;
    axDigitalOutputValid : ARRAY[0..63] OF BOOL;
    adiAnalogInput : ARRAY[0..15] OF DINT;
    axAnalogInputValid : ARRAY[0..15] OF BOOL;
    adiAnalogOutput : ARRAY[0..15] OF DINT;
    axAnalogOutputValid : ARRAY[0..15] OF BOOL;
    xRequiredModulesOnline : BOOL;
    xForceActive : BOOL;
    uiInvalidInputCount : UINT;
    uiInvalidOutputCount : UINT;
    uiOutputMismatchCount : UINT;
    uiDiagnosticCode : UINT;
    udiImageSequence : UDINT;
END_STRUCT;
END_TYPE

TYPE E_SelectorTravelMode :
(
    SelectorLinearLimited := 0,
    SelectorCyclic360 := 1
);
END_TYPE

TYPE ST_SelectorConfig :
STRUCT
    eTravelMode : E_SelectorTravelMode;
    uiOutletCount : UINT;
    adiOutletPosition : ARRAY[1..64] OF DINT;
    axOutletCalibrated : ARRAY[1..64] OF BOOL;
    diPositionTolerance : DINT;
    diAnalogMinimum : DINT;
    diAnalogMaximum : DINT;
    diCycleLength : DINT;
    udiSettleTimeMs : UDINT;
    udiMoveTimeoutMs : UDINT;
    xLimitsEnabled : BOOL;
    xAbsolutePositionFeedback : BOOL;
    xReverseDirection : BOOL;
END_STRUCT;
END_TYPE

TYPE ST_BlowerConfig :
STRUCT
    uiMinimumFreqCentiHz : UINT;
    uiMaximumFreqCentiHz : UINT;
    uiAtSpeedToleranceCentiHz : UINT;
    udiAtSpeedStableTimeMs : UDINT;
    udiStartTimeoutMs : UDINT;
    udiAccelerationTimeoutMs : UDINT;
    udiFeedbackLossTimeoutMs : UDINT;
    udiStopTimeoutMs : UDINT;
    udiPostRunTimeMs : UDINT;
    udiMaximumPostRunTimeMs : UDINT;
END_STRUCT;
END_TYPE

TYPE ST_DosingConfig :
STRUCT
    udiMaximumTargetCentiKg : UDINT;
    udiMaximumCentiKgPer1000Pulses : UDINT;
    uiMinimumSpeedPermille : UINT;
    udiCompletionToleranceCentiKg : UDINT;
    udiStartTimeoutMs : UDINT;
    udiFirstPulseTimeoutMs : UDINT;
    udiNoFlowTimeoutMs : UDINT;
    udiMinimumPulseIntervalMs : UDINT;
    udiTargetTimeoutMs : UDINT;
    udiStopTimeoutMs : UDINT;
END_STRUCT;
END_TYPE

TYPE ST_JobExecution :
STRUCT
    uiSnapshotVersion : UINT;
    udiTransferSequence : UDINT;
    udiJobId : UDINT;
    usiLineId : USINT;
    uiRecipeId : UINT;
    udiRecipeRevision : UDINT;
    uiTargetSelectorOutlet : UINT;
    byDosingUnitMask : BYTE;
    udiTargetFeedCentiKg : UDINT;
    udiMaximumExecutionTimeSec : UDINT;
    xAllowRecovery : BOOL;
    usiMaximumRetryCount : USINT;
    uiPayloadCRC16 : UINT;
END_STRUCT;
END_TYPE

TYPE ST_RecipeExecution :
STRUCT
    uiSnapshotVersion : UINT;
    uiRecipeId : UINT;
    udiRecipeRevision : UDINT;
    uiDosingSpeedPermille : UINT;
    uiBlowerFreqCentiHz : UINT;
    udiSelectorSettleTimeMs : UDINT;
    udiBlowerPreRunTimeMs : UDINT;
    udiBlowerPostRunTimeMs : UDINT;
    udiMaximumDosingTimeSec : UDINT;
    udiFeedToleranceCentiKg : UDINT;
    uiPayloadCRC16 : UINT;
END_STRUCT;
END_TYPE

TYPE ST_LineConfig :
STRUCT
    usiLineId : USINT;
    uiSelectorOutletCount : UINT;
    xDosing1Enabled : BOOL;
    xDosing2Enabled : BOOL;
    udiMaximumTargetCentiKg : UDINT;
    udiMaximumFeedToleranceCentiKg : UDINT;
    uiMinimumDosingSpeedPermille : UINT;
    uiMaximumDosingSpeedPermille : UINT;
    uiMinimumBlowerFreqCentiHz : UINT;
    uiMaximumBlowerFreqCentiHz : UINT;
    udiMaximumSelectorSettleTimeMs : UDINT;
    udiMaximumBlowerPreRunTimeMs : UDINT;
    udiMaximumBlowerPostRunTimeMs : UDINT;
    udiMaximumDosingTimeSec : UDINT;
    udiMaximumExecutionTimeSec : UDINT;
END_STRUCT;
END_TYPE

TYPE ST_Line :
STRUCT
    usiLineId : USINT;
    eLineState : E_LineState;
    xEnabled : BOOL;
    xReady : BOOL;
    xBusy : BOOL;
    xRunning : BOOL;
    xPaused : BOOL;
    xCompleted : BOOL;
    xFault : BOOL;
    xEmergency : BOOL;
    xAutoMode : BOOL;
    xManualMode : BOOL;
    xServiceMode : BOOL;
    xSimulationMode : BOOL;
    xActiveJobValid : BOOL;
    udiActiveJobId : UDINT;
    uiActiveRecipeId : UINT;
    uiTargetSelectorOutlet : UINT;
    uiCurrentSelectorOutlet : UINT;
    xSelectorAtTarget : BOOL;
    udiTargetFeedCentiKg : UDINT;
    udiDeliveredFeedCentiKg : UDINT;
    udiRemainingFeedCentiKg : UDINT;
    uiProgressPermille : UINT;
    udiElapsedTimeSec : UDINT;
    udiRemainingTimeSec : UDINT;
    xBlowerRunning : BOOL;
    xDosing1Running : BOOL;
    xDosing2Running : BOOL;
    uiActiveAlarmId : UINT;
END_STRUCT;
END_TYPE


TYPE ST_RecoveryCheckpoint :
STRUCT
    uiCheckpointVersion : UINT;
    stJob : ST_JobExecution;
    stRecipe : ST_RecipeExecution;
    udiDeliveredFeedCentiKg : UDINT;
    udiLastAcceptedCommandSequence : UDINT;
    uiInterruptionReason : UINT;
    usiRetryCount : USINT;
    xQuantityTrustworthy : BOOL;
    xExecutionCompleted : BOOL;
    xExecutionCancelled : BOOL;
    uiPayloadCRC16 : UINT;
END_STRUCT;
END_TYPE

TYPE ST_RecoveryStatus :
STRUCT
    eState : E_RecoveryState;
    xSnapshotPresent : BOOL;
    xSnapshotValid : BOOL;
    xRecoveryAvailable : BOOL;
    xApprovalRequired : BOOL;
    xReadyToResume : BOOL;
    xApprovedCheckpointValid : BOOL;
    udiJobId : UDINT;
    udiRecipeRevision : UDINT;
    usiLineId : USINT;
    uiOutletId : UINT;
    udiTargetFeedCentiKg : UDINT;
    udiDeliveredCentiKg : UDINT;
    udiRemainingFeedCentiKg : UDINT;
    usiRetryCount : USINT;
    udiLastAcceptedCommandSequence : UDINT;
    udiLastProcessedRecoverySequence : UDINT;
    uiInterruptionReason : UINT;
    uiResultCode : UINT;
END_STRUCT;
END_TYPE
