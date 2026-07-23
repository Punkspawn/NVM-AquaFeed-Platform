# TEST_AlarmManager

---

# Purpose

Verify the correct operation of FB_AlarmManager.

This test validates alarm generation, prioritization, acknowledgement, reset, logging and alarm history management.

---

# Preconditions

- PLC powered on
- System Ready
- Alarm history empty (optional)
- HMI communication active
- AquaFeed Manager communication active

---

# Test Cases

## TC-001 Generate Alarm

### Procedure

1. Simulate a blower fault.

### Expected Result

- Alarm becomes Active.
- Correct AlarmCode assigned.
- Alarm displayed on HMI.
- Alarm written to history.

Result

□ PASS

□ FAIL

---

## TC-002 Multiple Alarms

### Procedure

1. Simulate blower fault.
2. Simulate dosing fault.

### Expected Result

- Both alarms recorded.
- Priority handled correctly.
- No alarm lost.

Result

□ PASS

□ FAIL

---

## TC-003 Alarm Acknowledge

### Procedure

1. Select active alarm.
2. Press Acknowledge.

### Expected Result

- Alarm marked as acknowledged.
- Fault condition remains active.
- Alarm remains visible until fault disappears.

Result

□ PASS

□ FAIL

---

## TC-004 Alarm Reset

### Procedure

1. Remove fault condition.
2. Press Reset.

### Expected Result

- Alarm cleared.
- Active alarm list updated.
- History retained.

Result

□ PASS

□ FAIL

---

## TC-005 Alarm Persistence

### Procedure

1. Generate alarm.
2. Restart HMI.

### Expected Result

- Active alarm still displayed.
- No duplicate alarms.
- Alarm history preserved.

Result

□ PASS

□ FAIL

---

## TC-006 Power Cycle

### Procedure

1. Generate alarm.
2. Power cycle PLC.

### Expected Result

- Alarm restored according to retention policy.
- Alarm history intact.
- System starts safely.

Result

□ PASS

□ FAIL

---

## TC-007 Emergency Alarm

### Procedure

1. Activate Emergency Stop.

### Expected Result

- Emergency alarm has highest priority.
- All outputs disabled.
- Alarm cannot be reset until Emergency Stop is released.

Result

□ PASS

□ FAIL

---

## TC-008 Communication Alarm

### Procedure

1. Disconnect Modbus communication.

### Expected Result

- Communication alarm generated.
- Error counter incremented.
- Alarm logged.

Result

□ PASS

□ FAIL

---

## TC-009 Duplicate Alarm Prevention

### Procedure

1. Hold the same fault active for 60 seconds.

### Expected Result

- Only one active alarm entry exists.
- Alarm timestamp unchanged until cleared.
- History contains a single occurrence.

Result

□ PASS

□ FAIL

---

## TC-010 Alarm History

### Procedure

1. Generate five different alarms.
2. Clear all alarms.
3. Open Alarm History.

### Expected Result

- All alarms listed chronologically.
- AlarmCode, Timestamp and Acknowledge status recorded.
- No missing entries.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Every alarm shall receive a unique AlarmCode.
- Alarm acknowledgement shall not clear the fault.
- Alarm reset shall only succeed after the fault is removed.
- Alarm history shall never lose records during normal operation.
- Emergency alarms shall always have the highest priority.
- All test cases shall pass successfully.

---

# Tested Module

FB_AlarmManager

---

# Related Modules

- FB_SystemManager
- FB_LineManager
- FB_Selector
- FB_Blower
- FB_Dosing
- FB_ModbusMaster
- FB_RuntimeManager
- HMI
- AquaFeed Manager

---

# Revision

Version 1.0