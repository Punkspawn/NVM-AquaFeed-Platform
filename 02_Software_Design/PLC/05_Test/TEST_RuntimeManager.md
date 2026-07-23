# TEST_RuntimeManager

---

# Purpose

Verify the correct operation of FB_RuntimeManager.

This test validates runtime accumulation, production statistics, pause handling, idle time calculation, fault runtime tracking and data retention.

---

# Preconditions

- PLC powered on
- System initialized
- System clock synchronized
- Runtime counters reset (optional)
- No active alarms

---

# Test Cases

## TC-001 Total Runtime

### Procedure

1. Power on the PLC.
2. Leave the system powered for 10 minutes.

### Expected Result

- TotalRuntime increases continuously.
- Runtime value is accurate within PLC scan tolerance.

Result

□ PASS

□ FAIL

---

## TC-002 Production Runtime

### Procedure

1. Start automatic feeding.
2. Operate for 5 minutes.

### Expected Result

- ProductionRuntime increases.
- IdleRuntime does not increase.
- PauseRuntime remains unchanged.

Result

□ PASS

□ FAIL

---

## TC-003 Idle Runtime

### Procedure

1. Leave the system in Ready state.
2. Wait for 5 minutes.

### Expected Result

- IdleRuntime increases.
- ProductionRuntime remains unchanged.

Result

□ PASS

□ FAIL

---

## TC-004 Pause Runtime

### Procedure

1. Start production.
2. Press Pause.
3. Wait for 2 minutes.

### Expected Result

- PauseRuntime increases.
- ProductionRuntime stops increasing.
- Runtime remains synchronized.

Result

□ PASS

□ FAIL

---

## TC-005 Fault Runtime

### Procedure

1. Simulate a blower fault.
2. Leave the system in Fault state for 3 minutes.

### Expected Result

- FaultRuntime increases.
- ProductionRuntime stops.

Result

□ PASS

□ FAIL

---

## TC-006 Counter Retention

### Procedure

1. Record runtime values.
2. Power cycle the PLC.

### Expected Result

- Retentive counters restored correctly.
- No data loss.

Result

□ PASS

□ FAIL

---

## TC-007 Daily Statistics

### Procedure

1. Complete several feeding jobs.
2. Review daily statistics.

### Expected Result

- Runtime totals match completed production.
- Statistics are internally consistent.

Result

□ PASS

□ FAIL

---

## TC-008 Counter Overflow

### Procedure

1. Simulate runtime values near maximum limits.

### Expected Result

- No overflow.
- No negative values.
- System continues normal operation.

Result

□ PASS

□ FAIL

---

## TC-009 Reset Statistics

### Procedure

1. Execute runtime reset command.

### Expected Result

- Resettable counters cleared.
- Lifetime counters remain unchanged.

Result

□ PASS

□ FAIL

---

## TC-010 Scan Time Verification

### Procedure

1. Compare accumulated runtime with external stopwatch.

### Expected Result

- Runtime accuracy remains within acceptable engineering tolerance.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Runtime counters shall never decrease unexpectedly.
- Runtime calculations shall remain deterministic.
- Retentive values shall survive power interruptions.
- Counter accuracy shall comply with PLC scan timing.
- All statistics shall remain internally consistent.
- All test cases shall pass successfully.

---

# Tested Module

FB_RuntimeManager

---

# Related Modules

- FB_SystemManager
- FB_FeedingControlManager
- FB_JobManager
- FB_MaintenanceManager
- FB_ReportManager
- AquaFeed Manager

---

# Revision

Version 1.0