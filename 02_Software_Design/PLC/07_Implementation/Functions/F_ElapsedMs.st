FUNCTION F_ElapsedMs : UDINT
VAR_INPUT
    udiCurrentTickMs : UDINT;
    udiStartTickMs : UDINT;
END_VAR

IF udiCurrentTickMs >= udiStartTickMs THEN
    F_ElapsedMs := udiCurrentTickMs - udiStartTickMs;
ELSE
    F_ElapsedMs := (c_udiCounterMaximum - udiStartTickMs) +
                   udiCurrentTickMs + 1;
END_IF;

END_FUNCTION
