FUNCTION_BLOCK FB_Selector
VAR_INPUT
    xEnable : BOOL;
    xHomeRequest : BOOL;
    xMoveRequest : BOOL;
    uiTargetOutlet : UINT;
    udiCommandSequence : UDINT;
    udiResetSequence : UDINT;
    xStopRequest : BOOL;
    xServicePermission : BOOL;
    xSafetyOK : BOOL;
    diPosition : DINT;
    xPositionValid : BOOL;
    xLeftLimit : BOOL;
    xRightLimit : BOOL;
    xMotorRunning : BOOL;
    xMotorFault : BOOL;
    stConfig : ST_SelectorConfig;
    udiMonotonicTickMs : UDINT;
END_VAR
VAR_OUTPUT
    eState : E_SelectorState := SelectorDisabled;
    xMoveLeftRequest : BOOL;
    xMoveRightRequest : BOOL;
    xReady : BOOL;
    xMoving : BOOL;
    xInPosition : BOOL;
    uiCurrentOutlet : UINT;
    uiDiagnosticCode : UINT;
    udiLastAcceptedSequence : UDINT;
END_VAR
VAR
    uiLatchedTargetOutlet : UINT;
    diLatchedTargetPosition : DINT;
    udiMoveStartTickMs : UDINT;
    udiSettleStartTickMs : UDINT;
    udiLastResetSequence : UDINT;
    xHasAcceptedCommand : BOOL;
    xHasAcceptedReset : BOOL;
    diPositionError : DINT;
    iOutlet : INT;
    iTargetOutlet : INT;
    uiPositionMatchCount : UINT;
    xConfigValid : BOOL;
    xTargetValid : BOOL;
    xLogicalLeft : BOOL;
END_VAR
VAR CONSTANT
    c_uiDiagnosticNone : UINT := 0;
    c_uiDiagnosticConfig : UINT := 10;
    c_uiDiagnosticInvalidTarget : UINT := 11;
    c_uiDiagnosticPosition : UINT := 12;
    c_uiDiagnosticMotorFault : UINT := 13;
    c_uiDiagnosticLeftLimit : UINT := 14;
    c_uiDiagnosticRightLimit : UINT := 15;
    c_uiDiagnosticTimeout : UINT := 16;
    c_uiDiagnosticSafety : UINT := 17;
    c_uiDiagnosticStopped : UINT := 18;
    c_uiDiagnosticFeedback : UINT := 19;
END_VAR

xMoveLeftRequest := FALSE;
xMoveRightRequest := FALSE;
xReady := FALSE;
xMoving := FALSE;
xInPosition := FALSE;

xConfigValid := (stConfig.uiOutletCount >= 1) AND
                (stConfig.uiOutletCount <= 12) AND
                (stConfig.diPositionTolerance > 0) AND
                (stConfig.diAnalogMinimum < stConfig.diAnalogMaximum) AND
                (stConfig.udiSettleTimeMs > 0) AND
                (stConfig.udiMoveTimeoutMs > 0) AND
                stConfig.axOutletCalibrated[1];

IF NOT xEnable THEN
    eState := SelectorDisabled;
    uiCurrentOutlet := 0;
    uiDiagnosticCode := c_uiDiagnosticNone;
ELSIF NOT xSafetyOK THEN
    eState := SelectorFault;
    uiCurrentOutlet := 0;
    uiDiagnosticCode := c_uiDiagnosticSafety;
ELSIF xMotorFault THEN
    eState := SelectorFault;
    uiCurrentOutlet := 0;
    uiDiagnosticCode := c_uiDiagnosticMotorFault;
ELSIF NOT xConfigValid THEN
    eState := SelectorFault;
    uiCurrentOutlet := 0;
    uiDiagnosticCode := c_uiDiagnosticConfig;
ELSIF xStopRequest AND (eState <> SelectorFault) THEN
    eState := SelectorInitializing;
    uiCurrentOutlet := 0;
    uiDiagnosticCode := c_uiDiagnosticStopped;
ELSE
    CASE eState OF
        SelectorDisabled:
            eState := SelectorInitializing;
            uiDiagnosticCode := c_uiDiagnosticNone;

        SelectorInitializing:
            uiCurrentOutlet := 0;

            IF NOT xPositionValid OR
               (diPosition < stConfig.diAnalogMinimum) OR
               (diPosition > stConfig.diAnalogMaximum) THEN
                uiDiagnosticCode := c_uiDiagnosticPosition;
            ELSE
                uiPositionMatchCount := 0;

                FOR iOutlet := 1 TO 12 DO
                    IF (iOutlet <= UINT_TO_INT(stConfig.uiOutletCount)) AND
                       stConfig.axOutletCalibrated[iOutlet] AND
                       (ABS(diPosition - stConfig.adiOutletPosition[iOutlet]) <=
                        stConfig.diPositionTolerance) THEN
                        uiCurrentOutlet := INT_TO_UINT(iOutlet);
                        uiPositionMatchCount := uiPositionMatchCount + 1;
                    END_IF;
                END_FOR;

                IF uiPositionMatchCount > 1 THEN
                    uiCurrentOutlet := 0;
                    eState := SelectorFault;
                    uiDiagnosticCode := c_uiDiagnosticConfig;
                ELSIF uiCurrentOutlet > 0 THEN
                    eState := SelectorReady;
                    uiDiagnosticCode := c_uiDiagnosticNone;
                ELSIF xHomeRequest AND
                      (NOT xHasAcceptedCommand OR
                       (udiCommandSequence <> udiLastAcceptedSequence)) THEN
                    udiLastAcceptedSequence := udiCommandSequence;
                    xHasAcceptedCommand := TRUE;
                    udiMoveStartTickMs := udiMonotonicTickMs;
                    eState := SelectorHoming;
                    uiDiagnosticCode := c_uiDiagnosticNone;
                END_IF;
            END_IF;

        SelectorHoming:
            xMoving := TRUE;

            IF NOT xPositionValid THEN
                eState := SelectorFault;
                uiDiagnosticCode := c_uiDiagnosticPosition;
            ELSIF xLeftLimit THEN
                diLatchedTargetPosition := stConfig.adiOutletPosition[1];
                uiLatchedTargetOutlet := 1;
                udiSettleStartTickMs := udiMonotonicTickMs;
                eState := SelectorSettling;
            ELSIF F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                             udiStartTickMs := udiMoveStartTickMs) >=
                  stConfig.udiMoveTimeoutMs THEN
                eState := SelectorFault;
                uiDiagnosticCode := c_uiDiagnosticTimeout;
            ELSE
                xMoveLeftRequest := NOT stConfig.xReverseDirection;
                xMoveRightRequest := stConfig.xReverseDirection;
            END_IF;

        SelectorReady:
            xReady := TRUE;
            xInPosition := TRUE;

            IF xMotorRunning THEN
                eState := SelectorFault;
                uiDiagnosticCode := c_uiDiagnosticFeedback;
            ELSIF xMoveRequest AND
                  (NOT xHasAcceptedCommand OR
                   (udiCommandSequence <> udiLastAcceptedSequence)) THEN
                udiLastAcceptedSequence := udiCommandSequence;
                xHasAcceptedCommand := TRUE;
                xTargetValid := (uiTargetOutlet >= 1) AND
                                (uiTargetOutlet <= stConfig.uiOutletCount);

                IF xTargetValid THEN
                    iTargetOutlet := UINT_TO_INT(uiTargetOutlet);
                    xTargetValid := stConfig.axOutletCalibrated[iTargetOutlet];
                END_IF;

                IF NOT xTargetValid THEN
                    uiDiagnosticCode := c_uiDiagnosticInvalidTarget;
                ELSE
                    uiLatchedTargetOutlet := uiTargetOutlet;
                    diLatchedTargetPosition :=
                        stConfig.adiOutletPosition[iTargetOutlet];
                    uiCurrentOutlet := 0;
                    udiMoveStartTickMs := udiMonotonicTickMs;
                    eState := SelectorMoving;
                    uiDiagnosticCode := c_uiDiagnosticNone;
                END_IF;
            END_IF;

        SelectorMoving:
            xMoving := TRUE;

            IF NOT xPositionValid OR
               (diPosition < stConfig.diAnalogMinimum) OR
               (diPosition > stConfig.diAnalogMaximum) THEN
                eState := SelectorFault;
                uiDiagnosticCode := c_uiDiagnosticPosition;
            ELSE
                diPositionError := diLatchedTargetPosition - diPosition;

                IF ABS(diPositionError) <= stConfig.diPositionTolerance THEN
                    udiSettleStartTickMs := udiMonotonicTickMs;
                    eState := SelectorSettling;
                ELSIF F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                                 udiStartTickMs := udiMoveStartTickMs) >=
                      stConfig.udiMoveTimeoutMs THEN
                    eState := SelectorFault;
                    uiDiagnosticCode := c_uiDiagnosticTimeout;
                ELSE
                    xLogicalLeft := diPositionError < 0;

                    IF xLogicalLeft AND xLeftLimit THEN
                        eState := SelectorFault;
                        uiDiagnosticCode := c_uiDiagnosticLeftLimit;
                    ELSIF NOT xLogicalLeft AND xRightLimit THEN
                        eState := SelectorFault;
                        uiDiagnosticCode := c_uiDiagnosticRightLimit;
                    ELSIF xLogicalLeft THEN
                        xMoveLeftRequest := NOT stConfig.xReverseDirection;
                        xMoveRightRequest := stConfig.xReverseDirection;
                    ELSE
                        xMoveLeftRequest := stConfig.xReverseDirection;
                        xMoveRightRequest := NOT stConfig.xReverseDirection;
                    END_IF;
                END_IF;
            END_IF;

        SelectorSettling:
            IF xMotorRunning THEN
                eState := SelectorFault;
                uiDiagnosticCode := c_uiDiagnosticFeedback;
            ELSIF NOT xPositionValid THEN
                eState := SelectorFault;
                uiDiagnosticCode := c_uiDiagnosticPosition;
            ELSIF ABS(diPosition - diLatchedTargetPosition) >
                  stConfig.diPositionTolerance THEN
                udiMoveStartTickMs := udiMonotonicTickMs;
                eState := SelectorMoving;
            ELSIF F_ElapsedMs(udiCurrentTickMs := udiMonotonicTickMs,
                             udiStartTickMs := udiSettleStartTickMs) >=
                  stConfig.udiSettleTimeMs THEN
                uiCurrentOutlet := uiLatchedTargetOutlet;
                eState := SelectorReady;
                uiDiagnosticCode := c_uiDiagnosticNone;
            END_IF;

        SelectorFault:
            IF (NOT xHasAcceptedReset OR
                (udiResetSequence <> udiLastResetSequence)) AND
               xSafetyOK AND
               NOT xMotorFault AND
               NOT xMotorRunning AND
               xPositionValid THEN
                udiLastResetSequence := udiResetSequence;
                xHasAcceptedReset := TRUE;
                eState := SelectorInitializing;
                uiDiagnosticCode := c_uiDiagnosticNone;
            END_IF;

    ELSE
        eState := SelectorFault;
        uiCurrentOutlet := 0;
        uiDiagnosticCode := c_uiDiagnosticConfig;
    END_CASE;
END_IF;

(* Logical outputs are always mutually exclusive. *)
IF xMoveLeftRequest AND xMoveRightRequest THEN
    xMoveLeftRequest := FALSE;
    xMoveRightRequest := FALSE;
    eState := SelectorFault;
    uiDiagnosticCode := c_uiDiagnosticFeedback;
END_IF;

END_FUNCTION_BLOCK
