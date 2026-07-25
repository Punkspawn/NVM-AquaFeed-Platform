# E_DosingState

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime |
| Version | 1.0 |

```iecst
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
```

Undefined values transition to Fault with motor request removed and no completion event.
