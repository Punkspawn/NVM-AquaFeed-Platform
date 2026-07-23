# TEST_FeedingControlManager

---

# Purpose

Verify the complete automatic feeding sequence controlled by FB_FeedingControlManager.

This test validates the interaction between all major Function Blocks, ensuring the feeding process executes safely, correctly and according to the selected recipe.

---

# Preconditions

- PLC powered on
- System Ready
- No active alarms
- Selector homed
- Blower Ready
- Dosing Ready
- Valid recipe loaded
- Valid Job Order loaded
- Feed available
- All communication operational

---

# Test Cases

## TC-001 Complete Automatic Feeding Cycle

### Procedure

1. Select Line 2.
2. Load Recipe 01.
3. Press Start.

### Expected Result

- Selector moves to Line 2.
- Selector confirms InPosition.
- Blower starts.
- Blower reaches AtSpeed.
- Dosing starts.
- Feed quantity reaches recipe target.
- Dosing stops.
- Blower stops.
- Job completed successfully.

Result

□ PASS

□ FAIL

---

## TC-002 Selector Failure During Positioning

### Procedure

1. Start automatic cycle.
2. Prevent selector from reaching target position.

### Expected Result

- Blower does not start.
- Dosing does not start.
- Alarm generated.
- Job cancelled safely.

Result

□ PASS

□ FAIL

---

## TC-003 Blower Failure Before Dosing

### Procedure

1. Start feeding cycle.
2. Simulate blower fault before AtSpeed.

### Expected Result

- Dosing never starts.
- Alarm generated.
- Job aborted safely.

Result

□ PASS

□ FAIL

---

## TC-004 Blower Failure During Feeding

### Procedure

1. Start feeding.
2. Simulate blower fault during dosing.

### Expected Result

- Dosing stops immediately.
- Blower stops.
- Alarm generated.
- Job terminated.

Result

□ PASS

□ FAIL

---

## TC-005 Dosing Failure

### Procedure

1. Start feeding.
2. Simulate dosing drive fault.

### Expected Result

- Feed delivery stops immediately.
- Blower stops.
- Fault recorded.
- Job terminated safely.

Result

□ PASS

□ FAIL

---

## TC-006 Emergency Stop

### Procedure

1. Start automatic feeding.
2. Activate Emergency Stop.

### Expected Result

- All outputs OFF immediately.
- Blower stopped.
- Dosing stopped.
- Selector motion stopped.
- Emergency alarm generated.

Result

□ PASS

□ FAIL

---

## TC-007 Pause And Resume

### Procedure

1. Start feeding.
2. Press Pause.
3. Wait 30 seconds.
4. Press Resume.

### Expected Result

- Production pauses safely.
- Runtime pauses.
- Feeding resumes from the current job.
- No product loss.

Result

□ PASS

□ FAIL

---

## TC-008 Invalid Recipe

### Procedure

1. Load an invalid recipe.
2. Press Start.

### Expected Result

- Feeding not permitted.
- Recipe validation fails.
- Alarm generated.

Result

□ PASS

□ FAIL

---

## TC-009 Communication Loss

### Procedure

1. Start feeding.
2. Disconnect Modbus communication.

### Expected Result

- Communication fault detected.
- Equipment enters safe state.
- Alarm generated.
- Job terminated.

Result

□ PASS

□ FAIL

---

## TC-010 Power Recovery

### Procedure

1. Start feeding.
2. Remove PLC power.
3. Restore power.

### Expected Result

- System initializes correctly.
- Retentive data restored.
- Safe operating state maintained.
- Operator intervention required before restart.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Every sequence shall follow the defined operating order.
- Safety interlocks shall never be bypassed.
- Equipment shall always transition to a safe state after any fault.
- Runtime, alarms and production statistics shall remain consistent.
- No unexpected state transitions shall occur.
- All test cases shall pass successfully.

---

# Tested Module

FB_FeedingControlManager

---

# Related Modules

- FB_SystemManager
- FB_LineManager
- FB_Selector
- FB_Blower
- FB_Dosing
- FB_RecipeManager
- FB_JobManager
- FB_RuntimeManager
- FB_AlarmManager
- FB_ModbusMaster

---

# Revision

Version 1.0