# TEST_MaintenanceManager

---

# Purpose

Verify the correct operation of FB_MaintenanceManager.

This test validates maintenance hour accumulation, service reminders, maintenance acknowledgement, reset procedures and maintenance history.

---

# Preconditions

- PLC powered on
- System Ready
- Runtime counters operational
- Maintenance limits configured
- No active alarms

---

# Test Cases

## TC-001 Runtime Accumulation

### Procedure

1. Operate the system for a known period.

### Expected Result

- Equipment runtime counters increase correctly.
- Individual equipment hours recorded independently.

Result

□ PASS

□ FAIL

---

## TC-002 Preventive Maintenance Warning

### Procedure

1. Set maintenance limit close to current runtime.
2. Continue operation until the limit is reached.

### Expected Result

- MaintenanceDue becomes TRUE.
- Warning displayed on HMI.
- Warning logged.

Result

□ PASS

□ FAIL

---

## TC-003 Maintenance Overdue

### Procedure

1. Continue operation beyond the maintenance interval.

### Expected Result

- MaintenanceOverdue becomes TRUE.
- Critical maintenance notification generated.

Result

□ PASS

□ FAIL

---

## TC-004 Maintenance Reset

### Procedure

1. Perform maintenance.
2. Execute Reset Maintenance command.

### Expected Result

- Equipment runtime counter resets.
- MaintenanceDue cleared.
- Next service interval recalculated.

Result

□ PASS

□ FAIL

---

## TC-005 Maintenance History

### Procedure

1. Complete maintenance reset.
2. Open maintenance history.

### Expected Result

- Date recorded.
- Runtime recorded.
- Equipment ID stored.
- User ID recorded.

Result

□ PASS

□ FAIL

---

## TC-006 Unauthorized Reset

### Procedure

1. Login as Operator.
2. Attempt maintenance reset.

### Expected Result

- Reset denied.
- Alarm generated.
- Runtime unchanged.

Result

□ PASS

□ FAIL

---

## TC-007 Multiple Equipment Tracking

### Procedure

1. Operate Selector, Blower and Dosing independently.

### Expected Result

- Each device maintains independent maintenance counters.
- No counter interference.

Result

□ PASS

□ FAIL

---

## TC-008 Power Cycle

### Procedure

1. Record maintenance counters.
2. Restart PLC.

### Expected Result

- Counters restored correctly.
- No maintenance data lost.

Result

□ PASS

□ FAIL

---

## TC-009 Counter Overflow

### Procedure

1. Simulate runtime near maximum value.

### Expected Result

- No overflow.
- Maintenance calculations remain valid.

Result

□ PASS

□ FAIL

---

## TC-010 Maintenance Notification Clearance

### Procedure

1. Complete maintenance reset.

### Expected Result

- Maintenance notifications disappear.
- Event recorded in history.
- System returns to normal state.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Runtime shall accumulate accurately for each equipment.
- Maintenance reminders shall trigger only at configured thresholds.
- Only authorized users may reset maintenance counters.
- Maintenance history shall remain permanent.
- No maintenance data shall be lost after PLC restart.
- All test cases shall pass successfully.

---

# Tested Module

FB_MaintenanceManager

---

# Related Modules

- FB_RuntimeManager
- FB_UserManager
- FB_ReportManager
- FB_AlarmManager
- FB_SystemManager
- AquaFeed Manager

---

# Revision

Version 1.0