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
