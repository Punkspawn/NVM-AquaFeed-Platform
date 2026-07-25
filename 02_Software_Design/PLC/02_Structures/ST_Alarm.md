# ST_Alarm

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Lifetime | Bounded active alarm lifecycle only |
| Version | 2.0 |

## Definition

```iecst
TYPE ST_Alarm :
STRUCT
    AlarmCode          : UINT;
    Source             : E_AlarmSource;
    Severity           : E_AlarmSeverity;
    State              : E_AlarmState;

    LineId             : USINT;
    DeviceId           : UINT;

    ConditionActive    : BOOL;
    Acknowledged       : BOOL;
    ResetRequired      : BOOL;
    Blocking           : BOOL;

    ActivationSequence : UDINT;
    EventSequence      : UDINT;
    OccurrenceCount    : UINT;
END_STRUCT
END_TYPE
```

## Rules

- Active identity is AlarmCode + Source + LineId + DeviceId.
- Structure contains no text, user, database identifier, or permanent timestamp.
- Desktop assigns persistent event IDs, wall-clock timestamps, users, language, descriptions, and recommended actions.
- OccurrenceCount saturates at its maximum and never wraps silently.
- EventSequence increases on activation, acknowledgement, clear, and reset lifecycle events.
- Only AlarmManager modifies lifecycle fields.
- Source Function Block remains owner of ConditionActive.

## Removed Legacy Fields

- AlarmId: persistent database identity belongs to Desktop.
- ActivatedTime and ClearedTime: Desktop event persistence owns wall-clock history.
- UserId: Desktop owns authenticated user attribution.
- Cleared boolean: represented unambiguously by E_AlarmState.
- AlarmLevel and AlarmSource: renamed Severity and Source with authoritative enums.

## Related Documents

- [ST_AlarmCondition](ST_AlarmCondition.md)
- [ST_AlarmEvent](ST_AlarmEvent.md)
- [FB_AlarmManager](../01_Function_Blocks/FB_AlarmManager.md)
- [IF_Alarm](../04_Interfaces/IF_Alarm.md)
- [Alarm Catalog](../06_Documentation/Alarm_Catalog.md)
