FUNCTION_BLOCK FB_DiagnosticsManager
VAR_INPUT
    xEnable : BOOL;
    udiScanTimeUs : UDINT;
    udiMaximumScanTimeUs : UDINT;
    xScanOverrunEvent : BOOL;
    udiScanOverrunSequence : UDINT;
    xWatchdogHealthy : BOOL;
    xConfigurationValid : BOOL;
    stIO : ST_IO;
    xRequiredCommunicationHealthy : BOOL;
    uiOfflineChannelCount : UINT;
    uiActiveAlarmCount : UINT;
    xEquipmentBlockingDiagnostic : BOOL;
    xEquipmentDegradedDiagnostic : BOOL;
    uiEquipmentDiagnosticCode : UINT;
    uiEquipmentSeverity : UINT;
    xCounterSaturation : BOOL;
END_VAR
VAR_OUTPUT
    stDiagnostics : ST_Diagnostics;
    xDiagnosticOccurrence : BOOL;
    uiOccurrenceCode : UINT;
END_VAR
VAR
    xEffectiveConfigurationValid : BOOL;
    xScanBudgetExceeded : BOOL;
    xInvalidInput : BOOL;
    xInvalidOutput : BOOL;
    xOutputMismatch : BOOL;
    xNonRequiredChannelOffline : BOOL;
    uiEquipmentSeverityBounded : UINT;
    xHasProcessedOverrun : BOOL;
    udiLastProcessedOverrunSequence : UDINT;
    xNewOverrun : BOOL;
    xInitialized : BOOL;
    xPrevConfigurationInvalid : BOOL;
    xPrevWatchdogUnhealthy : BOOL;
    xPrevRequiredIOModuleOffline : BOOL;
    xPrevInvalidInput : BOOL;
    xPrevInvalidOutput : BOOL;
    xPrevOutputMismatch : BOOL;
    xPrevRequiredCommunicationLost : BOOL;
    xPrevEquipmentBlocking : BOOL;
    xPrevScanBudgetExceeded : BOOL;
    xPrevNonRequiredChannelOffline : BOOL;
    xPrevEquipmentDegraded : BOOL;
    xPrevCounterSaturation : BOOL;
END_VAR
VAR CONSTANT
    c_uiCodeNone : UINT := 0;
    c_uiCodeConfiguration : UINT := 10;
    c_uiCodeWatchdog : UINT := 20;
    c_uiCodeRequiredIOOffline : UINT := 30;
    c_uiCodeInvalidInput : UINT := 40;
    c_uiCodeInvalidOutput : UINT := 50;
    c_uiCodeOutputMismatch : UINT := 60;
    c_uiCodeRequiredCommunication : UINT := 70;
    c_uiCodeEquipmentBlocking : UINT := 80;
    c_uiCodeScanBudget : UINT := 90;
    c_uiCodeChannelOffline : UINT := 100;
    c_uiCodeEquipmentDegraded : UINT := 110;
    c_uiCodeCounterSaturation : UINT := 120;
    c_uiSeverityWarning : UINT := 20;
    c_uiSeverityFault : UINT := 30;
    c_uiSeverityCritical : UINT := 40;
END_VAR

xDiagnosticOccurrence := FALSE;
uiOccurrenceCode := c_uiCodeNone;
xNewOverrun := FALSE;

stDiagnostics.xWatchdogHealthy := xWatchdogHealthy;
xEffectiveConfigurationValid :=
    xConfigurationValid AND
    (udiMaximumScanTimeUs <> 0);
stDiagnostics.xConfigurationValid :=
    xEffectiveConfigurationValid;
stDiagnostics.uiActiveAlarmCount := uiActiveAlarmCount;
stDiagnostics.uiInvalidInputCount := stIO.uiInvalidInputCount;
stDiagnostics.uiInvalidOutputCount := stIO.uiInvalidOutputCount;
stDiagnostics.uiOutputMismatchCount := stIO.uiOutputMismatchCount;
stDiagnostics.uiOfflineChannelCount := uiOfflineChannelCount;
stDiagnostics.udiScanTimeUs := udiScanTimeUs;

IF uiEquipmentSeverity > c_uiSeverityCritical THEN
    uiEquipmentSeverityBounded := c_uiSeverityCritical;
ELSE
    uiEquipmentSeverityBounded := uiEquipmentSeverity;
END_IF;

xScanBudgetExceeded :=
    udiScanTimeUs > udiMaximumScanTimeUs;
xInvalidInput := stIO.uiInvalidInputCount <> 0;
xInvalidOutput := stIO.uiInvalidOutputCount <> 0;
xOutputMismatch := stIO.uiOutputMismatchCount <> 0;
xNonRequiredChannelOffline :=
    (uiOfflineChannelCount <> 0) AND
    xRequiredCommunicationHealthy;

IF xEnable AND
   (udiScanTimeUs > stDiagnostics.udiMaxScanTimeUs) THEN
    stDiagnostics.udiMaxScanTimeUs := udiScanTimeUs;
END_IF;

IF xEnable AND xScanOverrunEvent AND
   (NOT xHasProcessedOverrun OR
    (udiScanOverrunSequence <>
     udiLastProcessedOverrunSequence)) THEN
    xHasProcessedOverrun := TRUE;
    udiLastProcessedOverrunSequence :=
        udiScanOverrunSequence;
    xNewOverrun := TRUE;
    IF stDiagnostics.udiScanOverrunCount <
       16#FFFFFFFF THEN
        stDiagnostics.udiScanOverrunCount :=
            stDiagnostics.udiScanOverrunCount + 1;
    END_IF;
END_IF;

stDiagnostics.xReady := FALSE;
stDiagnostics.xDegraded := FALSE;
stDiagnostics.xFault := FALSE;
stDiagnostics.uiLastDiagnosticCode := c_uiCodeNone;
stDiagnostics.uiHighestSeverity := 0;
stDiagnostics.uiActiveDiagnosticCount := 0;

IF xEnable THEN
    IF NOT xEffectiveConfigurationValid THEN
        stDiagnostics.xFault := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeConfiguration;
    ELSIF NOT xWatchdogHealthy THEN
        stDiagnostics.xFault := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeWatchdog;
    ELSIF NOT stIO.xRequiredModulesOnline THEN
        stDiagnostics.xFault := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeRequiredIOOffline;
    ELSIF xInvalidInput THEN
        stDiagnostics.xFault := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeInvalidInput;
    ELSIF xInvalidOutput THEN
        stDiagnostics.xFault := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeInvalidOutput;
    ELSIF xOutputMismatch THEN
        stDiagnostics.xFault := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeOutputMismatch;
    ELSIF NOT xRequiredCommunicationHealthy THEN
        stDiagnostics.xFault := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeRequiredCommunication;
    ELSIF xEquipmentBlockingDiagnostic THEN
        stDiagnostics.xFault := TRUE;
        IF uiEquipmentDiagnosticCode <> 0 THEN
            stDiagnostics.uiLastDiagnosticCode :=
                uiEquipmentDiagnosticCode;
        ELSE
            stDiagnostics.uiLastDiagnosticCode :=
                c_uiCodeEquipmentBlocking;
        END_IF;
    ELSIF xScanBudgetExceeded THEN
        stDiagnostics.xDegraded := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeScanBudget;
    ELSIF xNonRequiredChannelOffline THEN
        stDiagnostics.xDegraded := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeChannelOffline;
    ELSIF xEquipmentDegradedDiagnostic THEN
        stDiagnostics.xDegraded := TRUE;
        IF uiEquipmentDiagnosticCode <> 0 THEN
            stDiagnostics.uiLastDiagnosticCode :=
                uiEquipmentDiagnosticCode;
        ELSE
            stDiagnostics.uiLastDiagnosticCode :=
                c_uiCodeEquipmentDegraded;
        END_IF;
    ELSIF xCounterSaturation THEN
        stDiagnostics.xDegraded := TRUE;
        stDiagnostics.uiLastDiagnosticCode :=
            c_uiCodeCounterSaturation;
    ELSE
        stDiagnostics.xReady := TRUE;
    END_IF;

    IF stDiagnostics.xFault THEN
        IF NOT xWatchdogHealthy THEN
            stDiagnostics.uiHighestSeverity :=
                c_uiSeverityCritical;
        ELSIF xEquipmentBlockingDiagnostic AND
              (uiEquipmentSeverityBounded >
               c_uiSeverityFault) THEN
            stDiagnostics.uiHighestSeverity :=
                uiEquipmentSeverityBounded;
        ELSE
            stDiagnostics.uiHighestSeverity :=
                c_uiSeverityFault;
        END_IF;
    ELSIF stDiagnostics.xDegraded THEN
        IF xEquipmentDegradedDiagnostic AND
           (uiEquipmentSeverityBounded >
            c_uiSeverityWarning) THEN
            stDiagnostics.uiHighestSeverity :=
                uiEquipmentSeverityBounded;
        ELSE
            stDiagnostics.uiHighestSeverity :=
                c_uiSeverityWarning;
        END_IF;
    END_IF;

    IF NOT xEffectiveConfigurationValid THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF NOT xWatchdogHealthy THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF NOT stIO.xRequiredModulesOnline THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF xInvalidInput THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF xInvalidOutput THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF xOutputMismatch THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF NOT xRequiredCommunicationHealthy THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF xEquipmentBlockingDiagnostic THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF xScanBudgetExceeded THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF xNonRequiredChannelOffline THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF xEquipmentDegradedDiagnostic THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;
    IF xCounterSaturation THEN
        stDiagnostics.uiActiveDiagnosticCount :=
            stDiagnostics.uiActiveDiagnosticCount + 1;
    END_IF;

    IF xInitialized THEN
        IF NOT xEffectiveConfigurationValid AND
           NOT xPrevConfigurationInvalid THEN
            uiOccurrenceCode := c_uiCodeConfiguration;
        ELSIF NOT xWatchdogHealthy AND
              NOT xPrevWatchdogUnhealthy THEN
            uiOccurrenceCode := c_uiCodeWatchdog;
        ELSIF NOT stIO.xRequiredModulesOnline AND
              NOT xPrevRequiredIOModuleOffline THEN
            uiOccurrenceCode := c_uiCodeRequiredIOOffline;
        ELSIF xInvalidInput AND NOT xPrevInvalidInput THEN
            uiOccurrenceCode := c_uiCodeInvalidInput;
        ELSIF xInvalidOutput AND NOT xPrevInvalidOutput THEN
            uiOccurrenceCode := c_uiCodeInvalidOutput;
        ELSIF xOutputMismatch AND NOT xPrevOutputMismatch THEN
            uiOccurrenceCode := c_uiCodeOutputMismatch;
        ELSIF NOT xRequiredCommunicationHealthy AND
              NOT xPrevRequiredCommunicationLost THEN
            uiOccurrenceCode :=
                c_uiCodeRequiredCommunication;
        ELSIF xEquipmentBlockingDiagnostic AND
              NOT xPrevEquipmentBlocking THEN
            IF uiEquipmentDiagnosticCode <> 0 THEN
                uiOccurrenceCode :=
                    uiEquipmentDiagnosticCode;
            ELSE
                uiOccurrenceCode :=
                    c_uiCodeEquipmentBlocking;
            END_IF;
        ELSIF xNewOverrun OR
              (xScanBudgetExceeded AND
               NOT xPrevScanBudgetExceeded) THEN
            uiOccurrenceCode := c_uiCodeScanBudget;
        ELSIF xNonRequiredChannelOffline AND
              NOT xPrevNonRequiredChannelOffline THEN
            uiOccurrenceCode := c_uiCodeChannelOffline;
        ELSIF xEquipmentDegradedDiagnostic AND
              NOT xPrevEquipmentDegraded THEN
            IF uiEquipmentDiagnosticCode <> 0 THEN
                uiOccurrenceCode :=
                    uiEquipmentDiagnosticCode;
            ELSE
                uiOccurrenceCode :=
                    c_uiCodeEquipmentDegraded;
            END_IF;
        ELSIF xCounterSaturation AND
              NOT xPrevCounterSaturation THEN
            uiOccurrenceCode :=
                c_uiCodeCounterSaturation;
        END_IF;
    END_IF;

    IF uiOccurrenceCode <> c_uiCodeNone THEN
        xDiagnosticOccurrence := TRUE;
        IF stDiagnostics.udiDiagnosticOccurrenceCount <
           16#FFFFFFFF THEN
            stDiagnostics.udiDiagnosticOccurrenceCount :=
                stDiagnostics.udiDiagnosticOccurrenceCount + 1;
        END_IF;
    END_IF;

    xInitialized := TRUE;
ELSE
    xInitialized := FALSE;
END_IF;

xPrevConfigurationInvalid := NOT xEffectiveConfigurationValid;
xPrevWatchdogUnhealthy := NOT xWatchdogHealthy;
xPrevRequiredIOModuleOffline :=
    NOT stIO.xRequiredModulesOnline;
xPrevInvalidInput := xInvalidInput;
xPrevInvalidOutput := xInvalidOutput;
xPrevOutputMismatch := xOutputMismatch;
xPrevRequiredCommunicationLost :=
    NOT xRequiredCommunicationHealthy;
xPrevEquipmentBlocking :=
    xEquipmentBlockingDiagnostic;
xPrevScanBudgetExceeded := xScanBudgetExceeded;
xPrevNonRequiredChannelOffline :=
    xNonRequiredChannelOffline;
xPrevEquipmentDegraded :=
    xEquipmentDegradedDiagnostic;
xPrevCounterSaturation := xCounterSaturation;

END_FUNCTION_BLOCK
