# Regression Test

---

# Purpose

Verify that software modifications, bug fixes and version updates do not introduce unintended changes to previously validated functionality.

---

# Test Environment

- Delta PLC
- Delta HMI
- Delta MS300 VFDs
- Modbus RTU Network
- AquaFeed Manager
- Complete field hardware

---

# Preconditions

- New PLC software version installed
- Previous release available for comparison
- Baseline test results available
- System initialized successfully

---

# Test Cases

## TC-001 System Startup

### Procedure

1. Power on the PLC.
2. Verify initialization.

### Expected Result

- Startup sequence unchanged.
- No new alarms.
- System enters Ready state.

Result

□ PASS

□ FAIL

---

## TC-002 Manual Functions

### Procedure

1. Operate Selector, Blower and Dosing in Manual Mode.

### Expected Result

- Manual operation identical to the previous approved version.
- No unexpected behavior.

Result

□ PASS

□ FAIL

---

## TC-003 Automatic Feeding

### Procedure

1. Execute a complete automatic feeding cycle.

### Expected Result

- Sequence identical to the validated baseline.
- Feed quantity correct.
- Production completed successfully.

Result

□ PASS

□ FAIL

---

## TC-004 Alarm Verification

### Procedure

1. Simulate representative equipment faults.

### Expected Result

- Alarm behavior unchanged.
- Priorities unchanged.
- Alarm history recorded correctly.

Result

□ PASS

□ FAIL

---

## TC-005 Communication Verification

### Procedure

1. Verify communication with all Modbus devices.

### Expected Result

- Stable communication.
- No increase in communication errors.
- Existing mappings remain valid.

Result

□ PASS

□ FAIL

---

## TC-006 Runtime Verification

### Procedure

1. Execute several production jobs.
2. Compare runtime statistics.

### Expected Result

- Runtime calculations remain unchanged.
- Production statistics remain accurate.

Result

□ PASS

□ FAIL

---

## TC-007 Recipe Verification

### Procedure

1. Load and execute several existing recipes.

### Expected Result

- Recipe behavior unchanged.
- Parameter validation unchanged.
- Production results identical.

Result

□ PASS

□ FAIL

---

## TC-008 Maintenance Verification

### Procedure

1. Verify maintenance counters and reset functions.

### Expected Result

- Counters accumulate correctly.
- Reset procedure unchanged.
- Maintenance history preserved.

Result

□ PASS

□ FAIL

---

## TC-009 Data Integrity

### Procedure

1. Compare production records before and after the software update.

### Expected Result

- No missing records.
- No duplicated records.
- Historical data preserved.

Result

□ PASS

□ FAIL

---

## TC-010 Full System Verification

### Procedure

1. Execute the complete standard acceptance test suite.

### Expected Result

- No previously approved functionality has regressed.
- New software behaves consistently with the approved baseline.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Previously validated functionality shall remain unchanged.
- Existing communication mappings shall remain compatible.
- Historical production data shall remain intact.
- No new critical defects shall be introduced.
- Regression testing shall be completed before software release.
- All test cases shall pass successfully.

---

# Tested Modules

- FB_SystemManager
- FB_LineManager
- FB_FeedingControlManager
- FB_Selector
- FB_Blower
- FB_Dosing
- FB_RecipeManager
- FB_JobManager
- FB_ModbusMaster
- FB_RuntimeManager
- FB_MaintenanceManager
- FB_AlarmManager
- FB_ReportManager
- FB_UserManager
- FB_Diagnostics

---

# Revision

Version 1.0