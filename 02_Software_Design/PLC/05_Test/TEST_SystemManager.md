# TEST_SystemManager

---

# Purpose

Verify the correct operation of FB_SystemManager.

This test validates all primary operating states, state transitions and safety functions.

---

# Preconditions

- PLC powered on
- No active alarms
- Emergency Stop released
- All communication operational

---

# Test Cases

## TC-001 Power Up

### Procedure

1. Power on PLC.
2. Wait for initialization.

### Expected Result

- Ready = TRUE
- Running = FALSE
- Fault = FALSE
- Emergency = FALSE

Result

□ PASS

□ FAIL

---

## TC-002 Automatic Start

### Procedure

1. System Ready
2. Press Start

### Expected Result

- Running = TRUE
- Ready = FALSE
- AlarmCode = 0

Result

□ PASS

□ FAIL

---

## TC-003 Stop

### Procedure

1. System Running
2. Press Stop

### Expected Result

- Running = FALSE
- Stopped = TRUE

Result

□ PASS

□ FAIL

---

## TC-004 Pause

### Procedure

1. System Running
2. Press Pause

### Expected Result

- Paused = TRUE
- Production suspended

Result

□ PASS

□ FAIL

---

## TC-005 Resume

### Procedure

1. System Paused
2. Press Start

### Expected Result

- Running = TRUE
- Paused = FALSE

Result

□ PASS

□ FAIL

---

## TC-006 Emergency Stop

### Procedure

1. System Running
2. Activate Emergency Stop

### Expected Result

- Emergency = TRUE
- Running = FALSE
- All outputs OFF
- Alarm generated

Result

□ PASS

□ FAIL

---

## TC-007 Fault Recovery

### Procedure

1. Simulate fault
2. Remove fault
3. Press Reset

### Expected Result

- Fault cleared
- Ready = TRUE
- Alarm reset

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

All test cases shall pass successfully.

No unexpected state transitions shall occur.

No watchdog or communication errors shall be generated.

---

# Tested Module

FB_SystemManager

---

# Revision

Version 1.0