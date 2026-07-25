# E_AlarmSource

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Version | 1.0 |

## Definition

```iecst
TYPE E_AlarmSource :
(
    ALARM_SOURCE_SYSTEM,
    ALARM_SOURCE_SAFETY,
    ALARM_SOURCE_IO,
    ALARM_SOURCE_COMMUNICATION,
    ALARM_SOURCE_LINE,
    ALARM_SOURCE_SELECTOR,
    ALARM_SOURCE_BLOWER,
    ALARM_SOURCE_DOSING,
    ALARM_SOURCE_POWER,
    ALARM_SOURCE_AUXILIARY
);
END_TYPE
```

Source identifies the realtime PLC origin. Desktop may enrich it with site, machine, human-readable module, and business context.
