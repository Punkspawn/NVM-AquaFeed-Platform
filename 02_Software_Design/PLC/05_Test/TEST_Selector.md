# TEST_Selector

---

# Purpose

Verify the correct operation of FB_Selector.

This test validates selector homing, positioning, movement accuracy, interlocks and fault handling.

---

# Preconditions

- PLC powered on
- System Ready
- Selector drive operational
- Position sensors operational
- Home sensor operational
- No active alarms

---

# Test Cases

## TC-001 Homing

### Procedure

1. Enable the selector.
2. Execute Home command.

### Expected Result

- Homing sequence starts.
- Home sensor detected.
- Homed = TRUE.
- Ready = TRUE.

Result

□ PASS

□ FAIL

---

## TC-002 Move To Valid Line

### Procedure

1. Home selector.
2. Command selector to Line 3.

### Expected Result

- Selector moves.
- Stops at Line 3.
- InPosition = TRUE.
- CurrentLine = 3.

Result

□ PASS

□ FAIL

---

## TC-003 Invalid Position

### Procedure

1. Request a position outside the configured line range.

### Expected Result

- No movement.
- Alarm generated.
- Current position unchanged.

Result

□ PASS

□ FAIL

---

## TC-004 Position Timeout

### Procedure

1. Block selector movement.
2. Command movement.

### Expected Result

- Timeout detected.
- Fault = TRUE.
- Motion stopped.
- Alarm generated.

Result

□ PASS

□ FAIL

---

## TC-005 Home Sensor Failure

### Procedure

1. Disable Home sensor.
2. Execute Home command.

### Expected Result

- Homing fails.
- Fault = TRUE.
- Alarm generated.

Result

□ PASS

□ FAIL

---

## TC-006 Position Sensor Failure

### Procedure

1. Disable target position sensor.
2. Move selector.

### Expected Result

- Selector stops safely.
- InPosition = FALSE.
- Fault = TRUE.

Result

□ PASS

□ FAIL

---

## TC-007 Reset Fault

### Procedure

1. Restore sensor.
2. Press Reset.

### Expected Result

- Fault cleared.
- Ready = TRUE.
- Homing available.

Result

□ PASS

□ FAIL

---

## TC-008 Rapid Position Changes

### Procedure

1. Command multiple different line positions rapidly.

### Expected Result

- Only the active command is executed.
- No unstable movement.
- No unexpected alarms.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Homing shall complete successfully.
- Position accuracy shall be within machine tolerance.
- Only one target position shall be active.
- Fault conditions shall immediately stop motion.
- All safety interlocks shall function correctly.
- All test cases shall pass successfully.

---

# Tested Module

FB_Selector

---

# Related Modules

- FB_LineManager
- FB_FeedingControlManager
- FB_IOManager
- FB_AlarmManager

---

# Revision

Version 1.0