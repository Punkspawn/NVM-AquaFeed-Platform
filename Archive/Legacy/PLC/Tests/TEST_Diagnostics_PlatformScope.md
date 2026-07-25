# TEST_Diagnostics

---

# Purpose

Verify the correct operation of FB_Diagnostics.

This test validates system diagnostics, hardware monitoring, communication diagnostics, fault logging and diagnostic reporting.

---

# Test Environment

- Delta PLC
- Delta HMI
- Modbus RTU Network
- AquaFeed Manager
- Complete field hardware

---

# Preconditions

- PLC powered on
- System Ready
- Diagnostic monitoring enabled
- No active alarms

---

# Test Cases

## TC-001 CPU Diagnostics

### Procedure

1. Start the PLC.
2. Open the Diagnostics page.

### Expected Result

- CPU status reported as Healthy.
- No internal faults detected.
- PLC operating normally.

Result

□ PASS

□ FAIL

---

## TC-002 Memory Diagnostics

### Procedure

1. Monitor PLC memory usage during operation.

### Expected Result

- Memory utilization remains within acceptable limits.
- No abnormal allocation detected.

Result

□ PASS

□ FAIL

---

## TC-003 I/O Diagnostics

### Procedure

1. Disconnect one I/O module.
2. Observe diagnostics.

### Expected Result

- Missing module detected.
- Diagnostic event logged.
- Appropriate alarm generated.

Result

□ PASS

□ FAIL

---

## TC-004 Communication Diagnostics

### Procedure

1. Disconnect the Modbus network.

### Expected Result

- Communication status changes to Fault.
- Offline devices identified.
- Diagnostic counters updated.

Result

□ PASS

□ FAIL

---

## TC-005 Drive Diagnostics

### Procedure

1. Simulate a VFD fault.

### Expected Result

- Drive fault code captured.
- Diagnostic information available on HMI.
- Event stored in history.

Result

□ PASS

□ FAIL

---

## TC-006 Sensor Diagnostics

### Procedure

1. Disconnect a position sensor.

### Expected Result

- Sensor fault detected.
- Diagnostic message generated.
- Related equipment prevented from operating.

Result

□ PASS

□ FAIL

---

## TC-007 Event Logging

### Procedure

1. Trigger several diagnostic events.
2. Review Diagnostic History.

### Expected Result

- Events stored chronologically.
- Timestamp recorded.
- Source device identified.

Result

□ PASS

□ FAIL

---

## TC-008 Recovery Verification

### Procedure

1. Restore all simulated faults.

### Expected Result

- Diagnostic status returns to Healthy.
- Historical records remain available.
- Active faults cleared after reset.

Result

□ PASS

□ FAIL

---

## TC-009 Long-Term Monitoring

### Procedure

1. Operate the system continuously for 24 hours.

### Expected Result

- Diagnostic counters remain accurate.
- No unexpected internal errors reported.

Result

□ PASS

□ FAIL

---

## TC-010 Diagnostic Report

### Procedure

1. Generate a complete diagnostic report.

### Expected Result

- Current system status included.
- Hardware status included.
- Communication status included.
- Active and historical diagnostic events listed.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- All monitored hardware shall report accurate diagnostic information.
- Communication failures shall be identified correctly.
- Diagnostic history shall remain complete and traceable.
- Diagnostic functions shall not affect normal machine operation.
- All test cases shall pass successfully.

---

# Tested Module

FB_Diagnostics

---

# Related Modules

- FB_SystemManager
- FB_IOManager
- FB_ModbusMaster
- FB_AlarmManager
- FB_ReportManager
- AquaFeed Manager

---

# Revision

Version 1.0