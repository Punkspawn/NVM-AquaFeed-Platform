# TEST_JobManager

---

# Purpose

Verify the correct operation of FB_JobManager.

This test validates job creation, scheduling, execution, pause, resume, cancellation and completion.

---

# Preconditions

- PLC powered on
- System Ready
- Valid recipe available
- Valid feeding line available
- User authorized
- No active alarms

---

# Test Cases

## TC-001 Create Job

### Procedure

1. Select Recipe 01.
2. Select Line 1.
3. Create a new Job.

### Expected Result

- JobCreated = TRUE
- Job ID assigned.
- Job stored successfully.

Result

□ PASS

□ FAIL

---

## TC-002 Start Job

### Procedure

1. Select created Job.
2. Press Start.

### Expected Result

- Running = TRUE
- ActiveJobID updated.
- Feeding sequence starts.

Result

□ PASS

□ FAIL

---

## TC-003 Pause Job

### Procedure

1. While feeding is active, press Pause.

### Expected Result

- Paused = TRUE
- Feed delivery suspended.
- Runtime paused.

Result

□ PASS

□ FAIL

---

## TC-004 Resume Job

### Procedure

1. Resume paused Job.

### Expected Result

- Running = TRUE
- Feeding continues from current progress.

Result

□ PASS

□ FAIL

---

## TC-005 Cancel Job

### Procedure

1. While job is active, press Cancel.

### Expected Result

- Feeding stops.
- Cancelled = TRUE
- Equipment enters Ready state.

Result

□ PASS

□ FAIL

---

## TC-006 Job Completion

### Procedure

1. Execute the complete feeding cycle.

### Expected Result

- Completed = TRUE
- Job removed from Active state.
- Production statistics updated.

Result

□ PASS

□ FAIL

---

## TC-007 Invalid Recipe Reference

### Procedure

1. Create a Job using an invalid Recipe ID.

### Expected Result

- Job creation rejected.
- Alarm generated.
- Job not stored.

Result

□ PASS

□ FAIL

---

## TC-008 Invalid Line Reference

### Procedure

1. Create a Job using an unavailable line.

### Expected Result

- Job rejected.
- Alarm generated.
- No active job created.

Result

□ PASS

□ FAIL

---

## TC-009 Power Failure Recovery

### Procedure

1. Start a Job.
2. Simulate PLC power loss.
3. Restore power.

### Expected Result

- Job status restored according to system policy.
- No corrupted job data.
- Safe restart required before execution continues.

Result

□ PASS

□ FAIL

---

## TC-010 Queue Execution

### Procedure

1. Create three jobs.
2. Start automatic execution.

### Expected Result

- Jobs execute sequentially.
- Only one Active Job at a time.
- Queue updates after each completion.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Only one job shall execute simultaneously.
- Every job shall reference a valid recipe and feeding line.
- Job data shall remain consistent during power interruptions.
- Queue processing shall preserve execution order.
- All alarms shall be logged correctly.
- All test cases shall pass successfully.

---

# Tested Module

FB_JobManager

---

# Related Modules

- FB_FeedingControlManager
- FB_LineManager
- FB_RecipeManager
- FB_RuntimeManager
- FB_AlarmManager
- AquaFeed Manager

---

# Revision

Version 1.0