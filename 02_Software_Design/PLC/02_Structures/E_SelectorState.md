# E_SelectorState

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime |
| Version | 1.0 |

```iecst
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
```

Undefined values transition to Fault with motion outputs off.
