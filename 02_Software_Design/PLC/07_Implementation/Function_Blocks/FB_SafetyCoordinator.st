FUNCTION_BLOCK FB_SafetyCoordinator
VAR_INPUT
    xFeedbackValid : BOOL;
    xEmergencyActive : BOOL;
    xSafetyRelayHealthy : BOOL;
    xSTOFeedbackHealthy : BOOL;
    xContactorFeedbackHealthy : BOOL;
    xStandardControlPermitRequest : BOOL;

    xLocalResetRequest : BOOL;
    udiResetSequence : UDINT;
    xEquipmentStopped : BOOL;
END_VAR
VAR_OUTPUT
    stSafety : ST_SafetyStatus;
    xResetAccepted : BOOL;
    xResetRejected : BOOL;
END_VAR
VAR
    xResetRequiredLatched : BOOL := TRUE;
    xHasProcessedReset : BOOL;
    udiLastProcessedResetSequence : UDINT;
    xAllObservedHealthy : BOOL;
END_VAR
VAR CONSTANT
    c_uiDiagnosticNone : UINT := 0;
    c_uiDiagnosticFeedbackInvalid : UINT := 50;
    c_uiDiagnosticEmergencyActive : UINT := 51;
    c_uiDiagnosticSafetyRelay : UINT := 52;
    c_uiDiagnosticSTOFeedback : UINT := 53;
    c_uiDiagnosticContactorFeedback : UINT := 54;
    c_uiDiagnosticEquipmentRunning : UINT := 55;
    c_uiDiagnosticPermitRequestActive : UINT := 56;
END_VAR

xResetAccepted := FALSE;
xResetRejected := FALSE;

stSafety.xAutomaticPermitted := FALSE;
stSafety.xMotionPermitted := FALSE;
stSafety.xBlowerPermitted := FALSE;
stSafety.xDosingPermitted := FALSE;
stSafety.xRecoveryPermitted := FALSE;

xAllObservedHealthy := xFeedbackValid AND
                       NOT xEmergencyActive AND
                       xSafetyRelayHealthy AND
                       xSTOFeedbackHealthy AND
                       xContactorFeedbackHealthy;

(* Any unknown, trip, or implausible feedback requires a new local reset. *)
IF NOT xAllObservedHealthy THEN
    xResetRequiredLatched := TRUE;
END_IF;

(* A new sequence is evaluated once; replay produces no result event. *)
IF xLocalResetRequest AND
   (NOT xHasProcessedReset OR
    (udiResetSequence <> udiLastProcessedResetSequence)) THEN
    xHasProcessedReset := TRUE;
    udiLastProcessedResetSequence := udiResetSequence;

    IF NOT xFeedbackValid THEN
        xResetRejected := TRUE;
        stSafety.uiDiagnosticCode :=
            c_uiDiagnosticFeedbackInvalid;
    ELSIF xEmergencyActive THEN
        xResetRejected := TRUE;
        stSafety.uiDiagnosticCode :=
            c_uiDiagnosticEmergencyActive;
    ELSIF NOT xSafetyRelayHealthy THEN
        xResetRejected := TRUE;
        stSafety.uiDiagnosticCode :=
            c_uiDiagnosticSafetyRelay;
    ELSIF NOT xSTOFeedbackHealthy THEN
        xResetRejected := TRUE;
        stSafety.uiDiagnosticCode :=
            c_uiDiagnosticSTOFeedback;
    ELSIF NOT xContactorFeedbackHealthy THEN
        xResetRejected := TRUE;
        stSafety.uiDiagnosticCode :=
            c_uiDiagnosticContactorFeedback;
    ELSIF NOT xEquipmentStopped THEN
        xResetRejected := TRUE;
        stSafety.uiDiagnosticCode :=
            c_uiDiagnosticEquipmentRunning;
    ELSIF xStandardControlPermitRequest THEN
        xResetRejected := TRUE;
        stSafety.uiDiagnosticCode :=
            c_uiDiagnosticPermitRequestActive;
    ELSE
        xResetRequiredLatched := FALSE;
        xResetAccepted := TRUE;
        stSafety.udiLastAcceptedResetSequence :=
            udiResetSequence;
        stSafety.uiDiagnosticCode := c_uiDiagnosticNone;
    END_IF;
END_IF;

(* State and standard-control permits are derived fail-closed each scan. *)
IF NOT xFeedbackValid THEN
    stSafety.eState := SafetyUnknown;
    stSafety.uiDiagnosticCode :=
        c_uiDiagnosticFeedbackInvalid;
ELSIF xEmergencyActive THEN
    stSafety.eState := SafetyTripActive;
    stSafety.uiDiagnosticCode :=
        c_uiDiagnosticEmergencyActive;
ELSIF NOT xSafetyRelayHealthy THEN
    stSafety.eState := SafetyTripActive;
    stSafety.uiDiagnosticCode :=
        c_uiDiagnosticSafetyRelay;
ELSIF NOT xSTOFeedbackHealthy THEN
    stSafety.eState := SafetyFeedbackFault;
    stSafety.uiDiagnosticCode :=
        c_uiDiagnosticSTOFeedback;
ELSIF NOT xContactorFeedbackHealthy THEN
    stSafety.eState := SafetyFeedbackFault;
    stSafety.uiDiagnosticCode :=
        c_uiDiagnosticContactorFeedback;
ELSIF xResetRequiredLatched THEN
    stSafety.eState := SafetyResetRequired;
    IF NOT xResetRejected THEN
        stSafety.uiDiagnosticCode := c_uiDiagnosticNone;
    END_IF;
ELSIF xStandardControlPermitRequest AND
      NOT xResetAccepted THEN
    stSafety.eState := SafetyHealthyPermitted;
    stSafety.uiDiagnosticCode := c_uiDiagnosticNone;
    stSafety.xAutomaticPermitted := TRUE;
    stSafety.xMotionPermitted := TRUE;
    stSafety.xBlowerPermitted := TRUE;
    stSafety.xDosingPermitted := TRUE;
ELSE
    stSafety.eState := SafetyHealthyStopped;
    stSafety.uiDiagnosticCode := c_uiDiagnosticNone;
END_IF;

stSafety.xRecoveryPermitted :=
    xAllObservedHealthy AND
    NOT xResetRequiredLatched AND
    xEquipmentStopped;

stSafety.xFeedbackValid := xFeedbackValid;
stSafety.xEmergencyActive := xEmergencyActive;
stSafety.xSafetyRelayHealthy := xSafetyRelayHealthy;
stSafety.xSTOFeedbackHealthy := xSTOFeedbackHealthy;
stSafety.xContactorFeedbackHealthy :=
    xContactorFeedbackHealthy;
stSafety.xResetRequired := xResetRequiredLatched;

END_FUNCTION_BLOCK
