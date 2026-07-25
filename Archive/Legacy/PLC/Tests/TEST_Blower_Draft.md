# TEST_Blower

---

# Purpose

Verify the correct operation of FB_Blower.

This test validates blower start/stop sequences, speed control, drive feedback, fault detection and safety interlocks.

---

# Preconditions

- PLC powered on
- System Ready
- Blower drive operational
- Modbus communication active
- Emergency Stop released
- No active alarms

---

# Test Cases

## TC-001 Blower Start

### Procedure

1. Enable blower.
2. Press Start.

### Expected Result

- Running = TRUE
- Drive Run Command = TRUE
- No alarms generated

Result

□ PASS

□ FAIL

---

## TC-002 Speed Reference

### Procedure

1. Start blower.
2. Set speed reference to 60%.

### Expected Result

- Drive receives 60% reference.
- ActualSpeed reaches setpoint.
- AtSpeed = TRUE.

Result

□ PASS

□ FAIL

---

## TC-003 Speed Change During Operation

### Procedure

1. Blower running at 40%.
2. Change reference to 80%.

### Expected Result

- Speed changes smoothly.
- No communication errors.
- No unexpected stop.

Result

□ PASS

□ FAIL

---

## TC-004 Stop Blower

### Procedure

1. While running, press Stop.

### Expected Result

- Run command removed.
- ActualSpeed decreases to zero.
- Running = FALSE.
- Ready = TRUE.

Result

□ PASS

□ FAIL

---

## TC-005 Drive Communication Loss

### Procedure

1. Disconnect Modbus communication.
2. Observe system response.

### Expected Result

- Fault = TRUE.
- Blower stopped safely.
- Communication alarm generated.

Result

□ PASS

□ FAIL

---

## TC-006 Drive Fault

### Procedure

1. Simulate a VFD fault.

### Expected Result

- Fault = TRUE.
- Blower stopped immediately.
- Alarm generated.
- Feeding sequence aborted.

Result

□ PASS

□ FAIL

---

## TC-007 Emergency Stop

### Procedure

1. Start blower.
2. Activate Emergency Stop.

### Expected Result

- Run command removed immediately.
- Running = FALSE.
- Emergency alarm generated.

Result

□ PASS

□ FAIL

---

## TC-008 Reset Fault

### Procedure

1. Remove drive fault.
2. Press Reset.

### Expected Result

- Fault cleared.
- Ready = TRUE.
- Blower can be started again.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Blower shall only operate when enabled.
- Speed reference shall accurately follow the commanded value.
- Drive communication failures shall stop the blower safely.
- Emergency Stop shall override every operating state.
- No unexpected alarms shall occur during normal operation.
- All test cases shall pass successfully.

---

# Tested Module

FB_Blower

---

# Related Modules

- FB_FeedingControlManager
- FB_ModbusMaster
- FB_IOManager
- FB_RuntimeManager
- FB_AlarmManager

---

# Revision

Version 1.0