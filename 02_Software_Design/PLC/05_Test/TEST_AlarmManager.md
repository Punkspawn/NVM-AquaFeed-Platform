# TEST_AlarmManager

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_AlarmManager v1.0 and alarm contract v2.0 |
| Version | 2.0 |

## Test Cases

| ID | Test | Expected result |
|---|---|---|
| ALM-001 | Raise one valid condition | One active record and one activation event |
| ALM-002 | Hold same condition for 60 seconds | No duplicate active record; activation sequence unchanged |
| ALM-003 | Raise same code from two devices | Two distinct active keys |
| ALM-004 | Raise Warning, Fault, Critical | All retained; highest severity Critical |
| ALM-005 | Raise Information with Blocking input | Configuration rejected or Blocking forced false |
| ALM-006 | Acknowledge active alarm | State acknowledged; condition remains active |
| ALM-007 | Repeat same command sequence | Idempotent; no duplicate lifecycle event |
| ALM-008 | Reset while condition active | Reset rejected |
| ALM-009 | Clear manual-reset condition | State becomes Cleared Wait Reset |
| ALM-010 | Valid manual reset | State becomes Inactive; reset event emitted |
| ALM-011 | Clear automatic alarm | State becomes Inactive; clear event emitted |
| ALM-012 | Emergency plus lower alarms | Emergency published highest; lower alarms remain visible |
| ALM-013 | Desktop communication loss | Alarm processing continues; bounded events retained |
| ALM-014 | Reconnect Desktop | Buffered events synchronize idempotently |
| ALM-015 | Fill active table | Overflow diagnostic asserted; no memory corruption |
| ALM-016 | Fill event buffer | Overflow visible; deterministic execution continues |
| ALM-017 | Reset alarm | No equipment start command generated |
| ALM-018 | Power cycle | Active physical conditions are rediscovered safely; Desktop history remains authoritative |
| ALM-019 | Line 1 blocking fault | Correct line summary blocks only affected scope unless shared safety applies |
| ALM-020 | Alarm text request | PLC publishes numeric key only; Desktop resolves localized content |

## Acceptance Criteria

- all lifecycle transitions match E_AlarmState
- no duplicate active key
- no reset while condition remains
- acknowledgement never clears fault
- no direct physical output from AlarmManager
- bounded tables do not corrupt memory
- event sequences are monotonic
- Desktop loss does not disable machine alarm protection
