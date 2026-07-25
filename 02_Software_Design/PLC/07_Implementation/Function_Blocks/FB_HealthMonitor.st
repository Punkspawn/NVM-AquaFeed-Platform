FUNCTION_BLOCK FB_HealthMonitor
VAR_INPUT
    xSystemOperational : BOOL;
    xSafetyHealthy : BOOL;
    xIOHealthy : BOOL;
    xRequiredCommunicationHealthy : BOOL;
    xDesktopCommunicationHealthy : BOOL;
    xSelectorHealthy : BOOL;
    xBlowerHealthy : BOOL;
    xDosingHealthy : BOOL;
    xConfigurationValid : BOOL;
    xDiagnosticsBlocking : BOOL;
    xDiagnosticsDegraded : BOOL;
    uiDiagnosticsSeverity : UINT;
END_VAR
VAR_OUTPUT
    stHealth : ST_HealthStatus;
    xTransitionEvent : BOOL;
    uiTransitionCode : UINT;
END_VAR
VAR
    stPrevious : ST_HealthStatus;
    xInitialized : BOOL;
    xMaterialChange : BOOL;
    uiBoundedDiagnosticSeverity : UINT;
END_VAR
VAR CONSTANT
    c_uiReasonNone : UINT := 0;
    c_uiReasonSafety : UINT := 10;
    c_uiReasonConfiguration : UINT := 20;
    c_uiReasonIO : UINT := 30;
    c_uiReasonSystem : UINT := 40;
    c_uiReasonRequiredCommunication : UINT := 50;
    c_uiReasonSelector : UINT := 60;
    c_uiReasonBlower : UINT := 70;
    c_uiReasonDosing : UINT := 80;
    c_uiReasonDiagnostics : UINT := 90;
    c_uiReasonDesktopCommunication : UINT := 100;
    c_uiReasonDiagnosticsDegraded : UINT := 110;
    c_uiSeverityWarning : UINT := 20;
    c_uiSeverityFault : UINT := 30;
    c_uiSeverityCritical : UINT := 40;
END_VAR

xTransitionEvent := FALSE;
stHealth.xSafetyHealthy := xSafetyHealthy;
stHealth.xIOHealthy := xIOHealthy;
stHealth.xRequiredCommunicationHealthy :=
    xRequiredCommunicationHealthy;
stHealth.xSelectorHealthy := xSelectorHealthy;
stHealth.xBlowerHealthy := xBlowerHealthy;
stHealth.xDosingHealthy := xDosingHealthy;
stHealth.xConfigurationValid := xConfigurationValid;

IF uiDiagnosticsSeverity > c_uiSeverityCritical THEN
    uiBoundedDiagnosticSeverity := c_uiSeverityCritical;
ELSE
    uiBoundedDiagnosticSeverity := uiDiagnosticsSeverity;
END_IF;

stHealth.xBlockingFault := FALSE;
stHealth.uiBlockingReasonCode := c_uiReasonNone;

IF NOT xSafetyHealthy THEN
    stHealth.xBlockingFault := TRUE;
    stHealth.uiBlockingReasonCode := c_uiReasonSafety;
ELSIF NOT xConfigurationValid THEN
    stHealth.xBlockingFault := TRUE;
    stHealth.uiBlockingReasonCode := c_uiReasonConfiguration;
ELSIF NOT xIOHealthy THEN
    stHealth.xBlockingFault := TRUE;
    stHealth.uiBlockingReasonCode := c_uiReasonIO;
ELSIF NOT xSystemOperational THEN
    stHealth.xBlockingFault := TRUE;
    stHealth.uiBlockingReasonCode := c_uiReasonSystem;
ELSIF NOT xRequiredCommunicationHealthy THEN
    stHealth.xBlockingFault := TRUE;
    stHealth.uiBlockingReasonCode :=
        c_uiReasonRequiredCommunication;
ELSIF NOT xSelectorHealthy THEN
    stHealth.xBlockingFault := TRUE;
    stHealth.uiBlockingReasonCode := c_uiReasonSelector;
ELSIF NOT xBlowerHealthy THEN
    stHealth.xBlockingFault := TRUE;
    stHealth.uiBlockingReasonCode := c_uiReasonBlower;
ELSIF NOT xDosingHealthy THEN
    stHealth.xBlockingFault := TRUE;
    stHealth.uiBlockingReasonCode := c_uiReasonDosing;
ELSIF xDiagnosticsBlocking THEN
    stHealth.xBlockingFault := TRUE;
    stHealth.uiBlockingReasonCode := c_uiReasonDiagnostics;
END_IF;

stHealth.xReadyForNewJob :=
    NOT stHealth.xBlockingFault AND
    xDesktopCommunicationHealthy;
stHealth.xCurrentJobMayContinue :=
    NOT stHealth.xBlockingFault;

stHealth.xDegraded :=
    NOT stHealth.xBlockingFault AND
    (NOT xDesktopCommunicationHealthy OR
     xDiagnosticsDegraded);
stHealth.uiDegradedReasonCode := c_uiReasonNone;

IF stHealth.xDegraded THEN
    IF NOT xDesktopCommunicationHealthy THEN
        stHealth.uiDegradedReasonCode :=
            c_uiReasonDesktopCommunication;
    ELSE
        stHealth.uiDegradedReasonCode :=
            c_uiReasonDiagnosticsDegraded;
    END_IF;
END_IF;

IF stHealth.xBlockingFault THEN
    IF stHealth.uiBlockingReasonCode = c_uiReasonSafety THEN
        stHealth.uiHighestSeverity := c_uiSeverityCritical;
    ELSIF uiBoundedDiagnosticSeverity >
          c_uiSeverityFault THEN
        stHealth.uiHighestSeverity :=
            uiBoundedDiagnosticSeverity;
    ELSE
        stHealth.uiHighestSeverity := c_uiSeverityFault;
    END_IF;
ELSIF stHealth.xDegraded THEN
    IF uiBoundedDiagnosticSeverity >
       c_uiSeverityWarning THEN
        stHealth.uiHighestSeverity :=
            uiBoundedDiagnosticSeverity;
    ELSE
        stHealth.uiHighestSeverity :=
            c_uiSeverityWarning;
    END_IF;
ELSE
    stHealth.uiHighestSeverity := 0;
END_IF;

IF stHealth.xBlockingFault THEN
    uiTransitionCode := stHealth.uiBlockingReasonCode;
ELSE
    uiTransitionCode := stHealth.uiDegradedReasonCode;
END_IF;

xMaterialChange :=
    (stHealth.xReadyForNewJob <>
     stPrevious.xReadyForNewJob) OR
    (stHealth.xCurrentJobMayContinue <>
     stPrevious.xCurrentJobMayContinue) OR
    (stHealth.xDegraded <> stPrevious.xDegraded) OR
    (stHealth.xBlockingFault <>
     stPrevious.xBlockingFault) OR
    (stHealth.xSafetyHealthy <>
     stPrevious.xSafetyHealthy) OR
    (stHealth.xIOHealthy <> stPrevious.xIOHealthy) OR
    (stHealth.xRequiredCommunicationHealthy <>
     stPrevious.xRequiredCommunicationHealthy) OR
    (stHealth.xSelectorHealthy <>
     stPrevious.xSelectorHealthy) OR
    (stHealth.xBlowerHealthy <>
     stPrevious.xBlowerHealthy) OR
    (stHealth.xDosingHealthy <>
     stPrevious.xDosingHealthy) OR
    (stHealth.xConfigurationValid <>
     stPrevious.xConfigurationValid) OR
    (stHealth.uiHighestSeverity <>
     stPrevious.uiHighestSeverity) OR
    (stHealth.uiBlockingReasonCode <>
     stPrevious.uiBlockingReasonCode) OR
    (stHealth.uiDegradedReasonCode <>
     stPrevious.uiDegradedReasonCode);

IF NOT xInitialized THEN
    xInitialized := TRUE;
ELSIF xMaterialChange THEN
    xTransitionEvent := TRUE;
    IF stHealth.udiStatusSequence < 16#FFFFFFFF THEN
        stHealth.udiStatusSequence :=
            stHealth.udiStatusSequence + 1;
    END_IF;
END_IF;

stPrevious := stHealth;

END_FUNCTION_BLOCK
