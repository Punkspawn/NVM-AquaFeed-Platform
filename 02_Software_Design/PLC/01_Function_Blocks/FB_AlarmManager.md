# FB_AlarmManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Bounded active-alarm lifecycle, priority summary, and Desktop event handshake |
| Version | 1.0 |
| Governing boundary | [System Boundary](../../../00_Project_Management/SYSTEM_BOUNDARY.md) |

## Purpose

`FB_AlarmManager` receives standardized alarm conditions from PLC modules, maintains a bounded active-alarm table, applies acknowledgement/reset lifecycle rules, calculates global summaries, and publishes alarm events for Desktop persistence.

It does not detect equipment faults itself and never controls physical outputs.

## Ownership

- Source Function Block owns the physical or logical alarm condition.
- Alarm Catalog owns code, severity, blocking behavior, reset policy, and text key.
- AlarmManager owns the bounded active lifecycle record and event sequence.
- Desktop owns timestamps for persistent history, users, translations, descriptions, recommended actions, analytics, and reports.
- SystemManager, LineManager, and equipment blocks own operational response using blocking summaries and their approved safety logic.

## Responsibilities

- validate alarm code/source combinations
- prevent duplicate active records for the same code/source/line/device key
- create one active record on rising condition
- increment occurrence counter without flooding
- process acknowledgement separately from reset
- permit reset only when the condition is removed
- apply catalog automatic/manual clear policy
- calculate highest active severity
- calculate any-active, any-blocking, any-critical, and any-emergency summaries
- emit monotonic activation, acknowledgement, clear, and reset event sequences
- retain a bounded unsynchronized event buffer if required by the communication contract

## Exclusions

- unbounded alarm history
- alarm statistics and frequency analysis
- user/session storage
- localized text or recommended action strings
- database, report, email, SMS, or cloud notification
- direct machine stop or reset
- clearing a physical fault
- dynamically changing severity or blocking policy from HMI

## Alarm Identity

One active alarm key is:

```text
AlarmCode + Source + LineId + DeviceId
```

Repeated scans with the same active key update one record and shall not create duplicates.

## Priority

```text
Emergency
Critical
Fault
Warning
Information
```

Higher severity is published first but lower alarms remain visible and active.

## Acknowledge and Reset

- Acknowledge means the operator or Desktop has observed an active alarm.
- Acknowledge never clears the condition and never restarts equipment.
- Reset is accepted only after the source condition is inactive.
- Reset does not command equipment start.
- Emergency and safety reset remain subject to approved physical reset requirements.
- Desktop stores the acknowledging user; PLC stores only acknowledgement state and sequence.

## Desktop Communication Loss

Active alarms and machine protection remain fully functional without Desktop.

During communication loss:

- new alarm conditions are processed normally
- active table and summaries remain available
- a bounded event buffer may retain unsynchronized events
- no history is discarded intentionally, but PLC retention is finite and shall expose overflow
- equipment response remains independent of Desktop

## Invariants

```text
Acknowledged -> Active OR ClearedWaitReset
ResetAccepted -> NOT ConditionActive
Information -> NOT Blocking
Emergency -> HighestSeverity = Emergency
Same active key -> one active record
AlarmManager -> no direct physical output
```

## Minimum Tests

1. Rising condition creates exactly one active record.
2. Held condition does not create duplicates.
3. Repeated occurrence increments bounded counter.
4. Multiple sources are retained simultaneously.
5. Highest severity is calculated correctly.
6. Information does not create blocking summary.
7. Acknowledge changes state but not condition.
8. Reset is rejected while condition is active.
9. Manual-reset alarm waits after condition clears.
10. Automatic-clear alarm closes after condition clears.
11. Emergency has highest priority.
12. Desktop loss does not disable alarm processing.
13. Event sequences are monotonic and idempotent.
14. Full active table and event-buffer overflow are reported.
15. Reset never restarts equipment.

## Dependencies

- `ST_Alarm`
- `E_AlarmSeverity`
- `E_AlarmSource`
- `E_AlarmState`
- `IF_Alarm`
- `Alarm_Catalog.md`

## Legacy Sources

- [AQ-FB-061](../../../../Archive/Legacy/PLC/Function_Blocks/61_FB_AlarmManager.md)
- [AQ-ALM-006](../../../../Archive/Legacy/System_Engineering/06_Alarm_System.md)
- [Alarm Manager Draft](../../../../Archive/Legacy/System_Engineering/62_FB_Alarm_Manager.md)
