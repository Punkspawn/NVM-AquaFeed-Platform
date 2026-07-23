# TEST_ReportManager

---

# Purpose

Verify the correct operation of FB_ReportManager.

This test validates production reporting, maintenance reporting, alarm reporting, runtime reporting, report generation, export functions and data integrity.

---

# Preconditions

- PLC powered on
- System Ready
- Historical production data available
- Alarm history available
- Runtime statistics available
- Maintenance history available
- AquaFeed Manager connected

---

# Test Cases

## TC-001 Generate Production Report

### Procedure

1. Complete several feeding jobs.
2. Generate a production report.

### Expected Result

- Report generated successfully.
- Job count displayed correctly.
- Total feed quantity displayed.
- Production duration calculated correctly.

Result

□ PASS

□ FAIL

---

## TC-002 Runtime Report

### Procedure

1. Generate runtime report.

### Expected Result

- Production Runtime displayed.
- Idle Runtime displayed.
- Fault Runtime displayed.
- Total Runtime displayed.

Result

□ PASS

□ FAIL

---

## TC-003 Alarm Report

### Procedure

1. Generate multiple alarms.
2. Create Alarm Report.

### Expected Result

- Alarm codes listed.
- Alarm timestamps listed.
- Acknowledge status displayed.
- Alarm durations calculated correctly.

Result

□ PASS

□ FAIL

---

## TC-004 Maintenance Report

### Procedure

1. Complete maintenance reset.
2. Generate maintenance report.

### Expected Result

- Equipment listed.
- Runtime hours listed.
- Maintenance date recorded.
- Next maintenance interval displayed.

Result

□ PASS

□ FAIL

---

## TC-005 Daily Report

### Procedure

1. Execute daily production.
2. Generate Daily Report.

### Expected Result

- Daily production totals correct.
- Daily runtime correct.
- Daily alarm statistics correct.

Result

□ PASS

□ FAIL

---

## TC-006 Export Report

### Procedure

1. Export report to AquaFeed Manager.

### Expected Result

- Export successful.
- Report data unchanged.
- No communication errors.

Result

□ PASS

□ FAIL

---

## TC-007 Empty Database

### Procedure

1. Remove historical data.
2. Generate report.

### Expected Result

- Empty report generated successfully.
- No software exception.
- Appropriate message displayed.

Result

□ PASS

□ FAIL

---

## TC-008 Large Database

### Procedure

1. Populate report database with maximum expected records.
2. Generate report.

### Expected Result

- Report generated successfully.
- Acceptable generation time.
- No missing records.

Result

□ PASS

□ FAIL

---

## TC-009 Report Consistency

### Procedure

1. Compare report values with RuntimeManager and JobManager data.

### Expected Result

- All calculated values match source data.
- No inconsistencies.

Result

□ PASS

□ FAIL

---

## TC-010 Long-Term Reporting

### Procedure

1. Generate reports covering one year of historical data.

### Expected Result

- Reports generated successfully.
- No overflow or memory issues.
- Data remains accurate.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Reports shall accurately reflect recorded production data.
- Report generation shall not affect PLC operation.
- Exported data shall match internal records.
- Large historical datasets shall be processed without errors.
- All calculations shall remain internally consistent.
- All test cases shall pass successfully.

---

# Tested Module

FB_ReportManager

---

# Related Modules

- FB_RuntimeManager
- FB_AlarmManager
- FB_MaintenanceManager
- FB_JobManager
- FB_SystemManager
- AquaFeed Manager

---

# Revision

Version 1.0