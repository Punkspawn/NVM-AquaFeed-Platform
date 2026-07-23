# TEST_LineManager

---

# Purpose

Verify the correct operation of FB_LineManager.

This test validates line selection, line availability, busy handling, fault handling and completion logic.

---

# Preconditions

- PLC powered on
- System Ready
- Selector operational
- Blower operational
- Dosing operational
- No active alarms

---

# Test Cases

## TC-001 Enable Line

### Procedure

1. Select Line 1.
2. Enable the line.

### Expected Result

- Line Enabled = TRUE
- Ready = TRUE
- Busy = FALSE
- Fault = FALSE

Result

□ PASS

□ FAIL

---

## TC-002 Invalid Line Selection

### Procedure

1. Request a line outside the configured range.

### Expected Result

- Line selection rejected
- Alarm generated
- Previous line remains active

Result

□ PASS

□ FAIL

---

## TC-003 Start Feeding

### Procedure

1. Select a valid line.
2. Load a valid recipe.
3. Start production.

### Expected Result

- Busy = TRUE
- Running = TRUE
- Selected line locked
- Feeding sequence started

Result

□ PASS

□ FAIL

---

## TC-004 Line Busy Protection

### Procedure

1. Start feeding.
2. Attempt to select another line.

### Expected Result

- Request rejected
- Active line unchanged
- Busy remains TRUE

Result

□ PASS

□ FAIL

---

## TC-005 Feeding Completed

### Procedure

1. Allow feeding cycle to finish normally.

### Expected Result

- Completed = TRUE
- Busy = FALSE
- Ready = TRUE

Result

□ PASS

□ FAIL

---

## TC-006 Line Fault

### Procedure

1. Simulate a selector or dosing failure.

### Expected Result

- Fault = TRUE
- Feeding stopped
- Alarm generated
- Busy = FALSE

Result

□ PASS

□ FAIL

---

## TC-007 Reset Fault

### Procedure

1. Remove fault condition.
2. Press Reset.

### Expected Result

- Fault cleared
- Ready = TRUE
- Alarm cleared

Result

□ PASS

□ FAIL

---

## TC-008 Simultaneous Line Request

### Procedure

1. While Line 1 is running, request Line 2.

### Expected Result

- Second request denied
- Active production uninterrupted
- No unexpected state transition

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Only one feeding line shall be active at any time.
- Line selection shall be deterministic.
- Busy state shall prevent conflicting commands.
- All fault conditions shall safely stop production.
- All test cases shall pass successfully.

---

# Tested Module

FB_LineManager

---

# Related Modules

- FB_Selector
- FB_Blower
- FB_Dosing
- FB_FeedingControlManager
- FB_AlarmManager

---

# Revision

Version 1.0