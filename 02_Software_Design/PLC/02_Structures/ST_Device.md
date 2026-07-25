# ST_Device

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | FB_DeviceManager |
| Persistence | Current non-retentive snapshot |
| Version | 2.0 |

```iecst
TYPE ST_Device :
STRUCT
    uiDeviceId : UINT;
    uiDeviceType : UINT;
    usiLineId : USINT;
    xConfigurationValid : BOOL;
    xEnabled : BOOL;
    xAvailable : BOOL;
    xRunning : BOOL;
    xFault : BOOL;
    xAutoMode : BOOL;
    xManualMode : BOOL;
    xInterlockOK : BOOL;
    xCommunicationOK : BOOL;
    xUnexpectedRunFeedback : BOOL;
    uiDiagnosticCode : UINT;
END_STRUCT;
END_TYPE
```

DeviceType is a non-zero static profile identifier owned by approved configuration. The PLC does not dynamically discover device types or maintain an asset registry.

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-24 | Initial common device snapshot. |
| 2.0 | 2026-07-26 | Added explicit configuration, interlock, communication, unexpected-run, and diagnostic fields; normalized field naming. |
