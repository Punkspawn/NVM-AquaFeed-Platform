# Alarm Catalog

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | Engineering configuration |
| PLC content | Code, source, severity, blocking/reset policy, text key |
| Desktop content | Localized text, cause, recommended action, history and analytics |
| Version | 2.0 |

## Philosophy

An alarm shall answer, through Desktop presentation:

- What happened?
- Where did it happen?
- What should the operator check?
- Is acknowledgement or manual reset required?
- Which scope is operationally blocked?

PLC uses numeric definitions only. Human-readable multilingual content remains Desktop-owned.

## Code Ranges

| Range | PLC source |
|---|---|
| 1000–1099 | System |
| 1100–1199 | Communication |
| 1200–1299 | Selector |
| 1300–1399 | Blower |
| 1400–1499 | Dosing |
| 1500–1599 | Line Manager / feeding process |
| 1600–1699 | Safety and IO |
| 1700–1799 | Power and energy |
| 1800–1899 | Approved auxiliary equipment |
| 1900–1999 | General configuration and diagnostics |

Recipe, job, user, database, report, inventory, and business-service alarms are Desktop-domain events unless a bounded PLC execution condition has its own PLC code.

## Required Catalog Fields

| Field | Owner |
|---|---|
| AlarmCode | Engineering |
| Source | Engineering |
| Severity | Engineering |
| Blocking | Engineering |
| ResetRequired | Engineering |
| AutomaticClear | Engineering |
| TextKey | Engineering/Desktop contract |
| Localized title/description | Desktop |
| Possible cause | Desktop |
| Recommended action | Desktop |

## Severity Policy

| Severity | Normal production effect |
|---|---|
| Information | No blocking |
| Warning | Continue; operator attention |
| Fault | Block affected device/line as configured |
| Critical | Controlled stop of affected scope |
| Emergency | Approved emergency/safety response |

Severity does not directly write outputs. Operational modules and hardwired safety apply the response.

## Lifecycle

```text
Condition rises
  ↓
Active Unacknowledged
  ↓ optional acknowledge
Active Acknowledged
  ↓ condition removed
Automatic clear OR Cleared Wait Reset
  ↓ valid manual reset
Inactive
```

## Acknowledge and Reset

- Acknowledge confirms observation only.
- Reset requires the source condition to be inactive.
- Reset never starts equipment.
- Safety and emergency reset follow approved physical reset design.
- Desktop records user and time.
- PLC records bounded state and event sequence.

## Duplicate and Flood Control

- Same active key creates one active record.
- Continued condition does not refresh activation sequence.
- Reoccurrence after closing creates a new activation sequence.
- Occurrence counters are bounded.
- Table or event-buffer overflow is latched without overwriting existing records; the source aggregation layer raises the dedicated diagnostic condition.

## History

PLC does not provide permanent alarm history.

Desktop persists activation, acknowledgement, clear, reset, communication-gap, and overflow events idempotently. PLC may retain only a bounded unsynchronized buffer.

## Related Documents

- [FB_AlarmManager](../01_Function_Blocks/FB_AlarmManager.md)
- [ST_Alarm](../02_Structures/ST_Alarm.md)
- [IF_Alarm](../04_Interfaces/IF_Alarm.md)
- [TEST_AlarmManager](../05_Test/TEST_AlarmManager.md)
