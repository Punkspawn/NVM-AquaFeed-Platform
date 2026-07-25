# ST_AlarmEvent

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC AlarmManager / Desktop persistence boundary |
| Version | 1.0 |

## Purpose

Publishes one immutable numeric alarm lifecycle event for idempotent Desktop persistence.

## Event Type

```iecst
TYPE E_AlarmEventType :
(
    ALARM_EVENT_ACTIVATED,
    ALARM_EVENT_ACKNOWLEDGED,
    ALARM_EVENT_CLEARED,
    ALARM_EVENT_RESET
);
END_TYPE
```

## Definition

```iecst
TYPE ST_AlarmEvent :
STRUCT
    EventSequence : UDINT;
    EventType      : E_AlarmEventType;
    AlarmCode     : UINT;
    Source        : E_AlarmSource;
    Severity      : E_AlarmSeverity;
    State         : E_AlarmState;
    LineId        : USINT;
    DeviceId      : UINT;
END_STRUCT
END_TYPE
```

## Rules

- AlarmManager retains at most 128 unsynchronized events in a fixed ring buffer.
- Only the oldest pending event is exposed through `IF_Alarm`.
- Desktop acknowledges persistence by returning that exact `EventSequence`.
- A mismatched or replayed event acknowledgement removes nothing.
- The next event is exposed only after the oldest event is acknowledged.
- Buffer overflow is latched and visible; existing pending events are never overwritten silently.
- Sequence exhaustion is fail-visible and shall not wrap silently.
- Desktop adds wall-clock time, user, localized text, recommended action, and permanent event identity.
