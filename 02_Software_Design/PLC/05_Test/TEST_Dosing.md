# TEST_Dosing

---

# Purpose

Verify the correct operation of FB_Dosing.

This test validates feed dosing accuracy, speed control, interlocks, recipe compliance and fault handling.

---

# Preconditions

- PLC powered on
- System Ready
- Selector in position
- Blower AtSpeed = TRUE
- Valid recipe loaded
- Feed available
- No active alarms

---

# Test Cases

## TC-001 Start Dosing

### Procedure

1. Load a valid recipe.
2. Start the dosing unit.

### Expected Result

- Running = TRUE
- Feed delivery begins.
- No alarms generated.

Result

□ PASS

□ FAIL

---

## TC-002 Speed Reference

### Procedure

1. Start dosing.
2. Set dosing speed to 50%.

### Expected Result

- Dosing drive receives 50% reference.
- ActualSpeed reaches setpoint.
- Stable operation.

Result

□ PASS

□ FAIL

---

## TC-003 Feed Quantity Verification

### Procedure

1. Set target feed quantity to 100 kg.
2. Execute the feeding cycle.

### Expected Result

- FeedDeliveredKg reaches 100 kg ± configured tolerance.
- Completed = TRUE.
- Feeding stops automatically.

Result

□ PASS

□ FAIL

---

## TC-004 Blower Interlock

### Procedure

1. Stop the blower during dosing.

### Expected Result

- Dosing stops immediately.
- Running = FALSE.
- Alarm generated.
- Feeding sequence aborted safely.

Result

□ PASS

□ FAIL

---

## TC-005 Selector Interlock

### Procedure

1. Remove selector position confirmation while dosing.

### Expected Result

- Dosing stops immediately.
- Fault = TRUE.
- Alarm generated.

Result

□ PASS

□ FAIL

---

## TC-006 Empty Feed Condition

### Procedure

1. Simulate an empty feed hopper.

### Expected Result

- Feed delivery stops.
- Fault = TRUE.
- Empty feed alarm generated.

Result

□ PASS

□ FAIL

---

## TC-007 Dosing Drive Fault

### Procedure

1. Simulate a VFD fault during operation.

### Expected Result

- Dosing stops immediately.
- Fault = TRUE.
- Alarm generated.
- Job terminated safely.

Result

□ PASS

□ FAIL

---

## TC-008 Stop Command

### Procedure

1. While dosing is active, press Stop.

### Expected Result

- Feed delivery stops.
- Running = FALSE.
- Ready = TRUE.

Result

□ PASS

□ FAIL

---

## TC-009 Reset Fault

### Procedure

1. Remove the fault condition.
2. Press Reset.

### Expected Result

- Fault cleared.
- Ready = TRUE.
- Dosing can be started again.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Dosing shall never start unless all interlocks are satisfied.
- Delivered feed quantity shall remain within the configured tolerance.
- Any safety or communication fault shall immediately stop feed delivery.
- Automatic stop shall occur when the recipe target is reached.
- All test cases shall pass successfully.

---

# Tested Module

FB_Dosing

---

# Related Modules

- FB_FeedingControlManager
- FB_Blower
- FB_Selector
- FB_RecipeManager
- FB_RuntimeManager
- FB_AlarmManager

---

# Revision

Version 1.0