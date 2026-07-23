# Factory Acceptance Test (FAT)

---

# Purpose

Verify that the complete PLC software, HMI and communication system satisfy all functional, safety and performance requirements before shipment and site installation.

---

# Test Environment

- Delta PLC
- Delta HMI
- Delta VFDs
- Modbus RTU Network
- Selector Mechanism
- Blower
- Dosing Unit
- AquaFeed Manager
- Engineering Laptop

---

# Preconditions

- Latest PLC software installed
- Latest HMI project installed
- Hardware wiring verified
- All field devices connected
- Emergency Stop operational
- Safety circuits verified

---

# FAT Test Cases

## FAT-001 PLC Startup

### Procedure

1. Apply power.
2. Observe PLC startup.

### Expected Result

- PLC enters Ready state.
- No unexpected alarms.
- Initialization completed successfully.

Result

□ PASS

□ FAIL

---

## FAT-002 Manual Operation

### Procedure

Operate each machine manually.

### Expected Result

- Selector operates correctly.
- Blower starts and stops correctly.
- Dosing operates correctly.

Result

□ PASS

□ FAIL

---

## FAT-003 Automatic Feeding

### Procedure

Execute one complete feeding cycle.

### Expected Result

- Full sequence completed.
- Feed quantity correct.
- No unexpected alarms.

Result

□ PASS

□ FAIL

---

## FAT-004 Alarm Verification

### Procedure

Simulate all major faults.

### Expected Result

- Correct alarm generated.
- Correct priority assigned.
- Alarm history updated.

Result

□ PASS

□ FAIL

---

## FAT-005 Emergency Stop

### Procedure

Activate Emergency Stop during production.

### Expected Result

- All motion stops immediately.
- Outputs disabled.
- Emergency alarm generated.

Result

□ PASS

□ FAIL

---

## FAT-006 Communication Verification

### Procedure

Verify communication with every Modbus slave.

### Expected Result

- Stable communication.
- No CRC errors.
- Correct data exchange.

Result

□ PASS

□ FAIL

---

## FAT-007 Runtime Verification

### Procedure

Run production for one hour.

### Expected Result

- Runtime counters accurate.
- Production statistics updated.

Result

□ PASS

□ FAIL

---

## FAT-008 Recipe Verification

### Procedure

Execute multiple recipes.

### Expected Result

- Correct parameters loaded.
- Correct feed quantities delivered.

Result

□ PASS

□ FAIL

---

## FAT-009 Maintenance Verification

### Procedure

Adjust maintenance thresholds and exceed the configured limit.

### Expected Result

- Maintenance reminder generated.
- Reset procedure functions correctly.

Result

□ PASS

□ FAIL

---

## FAT-010 Report Verification

### Procedure

Generate all available reports.

### Expected Result

- Production Report correct.
- Runtime Report correct.
- Alarm Report correct.
- Maintenance Report correct.

Result

□ PASS

□ FAIL

---

## FAT-011 Continuous Operation

### Procedure

Operate the complete system continuously for 8 hours.

### Expected Result

- No unexpected faults.
- Stable communication.
- Stable PLC scan time.
- Stable production.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- All Function Blocks operate correctly.
- No Critical or High severity defects remain.
- All safety functions verified.
- Communication stable.
- HMI fully operational.
- Reports generated correctly.
- All FAT test cases successfully completed.

---

# Approval

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Customer | | | |
| Project Engineer | | | |
| Software Engineer | | | |
| Commissioning Engineer | | | |

---

# Revision

Version 1.0