# Site Acceptance Test (SAT)

---

# Purpose

Verify that the complete feeding system operates correctly after installation at the customer site under real operating conditions.

The SAT confirms that the installed hardware, PLC software, HMI, communication network and mechanical equipment function together safely and reliably.

---

# Test Environment

- Installed Delta PLC
- Installed Delta HMI
- Installed VFDs
- Actual Selector Mechanism
- Actual Blower
- Actual Dosing Units
- Installed Modbus Network
- AquaFeed Manager
- Customer Power Supply

---

# Preconditions

- FAT successfully completed
- Mechanical installation completed
- Electrical installation completed
- Network connections verified
- Emergency Stop tested
- Operator training completed
- All alarms cleared

---

# SAT Test Cases

## SAT-001 Power-Up Verification

### Procedure

1. Energize the complete system.
2. Observe startup sequence.

### Expected Result

- PLC initializes correctly.
- HMI starts normally.
- No unexpected alarms.
- System enters Ready state.

Result

□ PASS

□ FAIL

---

## SAT-002 Field Device Verification

### Procedure

Operate each installed device individually.

### Expected Result

- Selector moves correctly.
- Blower operates correctly.
- Dosing unit operates correctly.
- Feedback signals are accurate.

Result

□ PASS

□ FAIL

---

## SAT-003 Automatic Feeding Cycle

### Procedure

1. Load a production recipe.
2. Start automatic feeding.

### Expected Result

- Complete feeding cycle executes successfully.
- Delivered quantity matches recipe.
- No unexpected alarms.

Result

□ PASS

□ FAIL

---

## SAT-004 Communication Verification

### Procedure

Verify communication with all field devices.

### Expected Result

- Stable Modbus communication.
- No communication timeouts.
- Correct process values received.

Result

□ PASS

□ FAIL

---

## SAT-005 Emergency Stop Verification

### Procedure

Activate Emergency Stop during automatic operation.

### Expected Result

- All equipment stops immediately.
- Outputs de-energized.
- Emergency alarm displayed.
- Restart requires operator acknowledgement.

Result

□ PASS

□ FAIL

---

## SAT-006 Alarm Verification

### Procedure

Simulate representative field faults.

### Expected Result

- Correct alarms displayed.
- Alarm history updated.
- Fault recovery functions correctly.

Result

□ PASS

□ FAIL

---

## SAT-007 Production Verification

### Procedure

Run multiple production jobs using different recipes.

### Expected Result

- Every job completes successfully.
- Production records stored correctly.
- Runtime statistics updated.

Result

□ PASS

□ FAIL

---

## SAT-008 Maintenance Verification

### Procedure

Verify maintenance reminders and service reset functions.

### Expected Result

- Maintenance notifications generated correctly.
- Service reset operates correctly.
- Maintenance history updated.

Result

□ PASS

□ FAIL

---

## SAT-009 Continuous Production Test

### Procedure

Operate the complete system continuously for one production shift.

### Expected Result

- Stable production.
- No unexpected shutdowns.
- No communication instability.
- No software faults.

Result

□ PASS

□ FAIL

---

## SAT-010 Customer Acceptance

### Procedure

Customer representatives observe full system operation.

### Expected Result

- Functional requirements satisfied.
- Customer approves system operation.
- System accepted for production use.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- System operates correctly under actual site conditions.
- Mechanical and electrical installation verified.
- Safety functions fully operational.
- Communication stable throughout testing.
- Customer confirms contractual functionality.
- All SAT test cases successfully completed.

---

# Approval

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Customer Representative | | | |
| Project Manager | | | |
| Automation Engineer | | | |
| Commissioning Engineer | | | |

---

# Revision

Version 1.0