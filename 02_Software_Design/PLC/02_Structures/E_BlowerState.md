# E_BlowerState

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime |
| Version | 1.0 |

```iecst
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
```

Undefined values transition to Fault with Run and frequency request removed.
