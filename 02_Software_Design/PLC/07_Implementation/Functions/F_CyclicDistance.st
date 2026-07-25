FUNCTION F_CyclicDistance : DINT
VAR_INPUT
    diCurrentPosition : DINT;
    diTargetPosition : DINT;
    diCycleLength : DINT;
END_VAR
VAR
    diForwardDistance : DINT;
    diReverseDistance : DINT;
END_VAR

diForwardDistance := diTargetPosition - diCurrentPosition;
IF diForwardDistance < 0 THEN
    diForwardDistance := diForwardDistance + diCycleLength;
END_IF;

diReverseDistance := diCurrentPosition - diTargetPosition;
IF diReverseDistance < 0 THEN
    diReverseDistance := diReverseDistance + diCycleLength;
END_IF;

IF diForwardDistance <= diReverseDistance THEN
    F_CyclicDistance := diForwardDistance;
ELSE
    F_CyclicDistance := diReverseDistance;
END_IF;

END_FUNCTION
