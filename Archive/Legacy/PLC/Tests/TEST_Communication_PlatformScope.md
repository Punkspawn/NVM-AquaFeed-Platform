# TEST_Communication

---

# Purpose

Verify the complete communication infrastructure between the PLC, HMI, VFDs and AquaFeed Manager.

This document validates communication reliability, synchronization, data integrity and recovery under normal and fault conditions.

---

# Test Environment

- Delta PLC
- Delta HMI
- Delta MS300 VFDs
- Modbus RTU Network
- AquaFeed Manager
- Engineering Laptop

---

# Preconditions

- PLC powered on
- HMI connected
- All Modbus devices online
- Communication parameters configured correctly
- No active alarms

---

# Test Cases

## TC-001 HMI Communication

### Procedure

1. Connect the HMI to the PLC.
2. Navigate through all screens.

### Expected Result

- Live data updates correctly.
- Commands execute successfully.
- No communication errors.

Result

□ PASS

□ FAIL

---

## TC-002 AquaFeed Manager Connection

### Procedure

1. Connect AquaFeed Manager to the PLC.
2. Read live production values.

### Expected Result

- Connection established.
- Live data synchronized.
- No missing variables.

Result

□ PASS

□ FAIL

---

## TC-003 Variable Synchronization

### Procedure

1. Modify process values from the PLC.
2. Observe HMI and AquaFeed Manager.

### Expected Result

- Updated values displayed correctly.
- Synchronization delay remains within project limits.

Result

□ PASS

□ FAIL

---

## TC-004 Command Transmission

### Procedure

1. Send Start, Stop and Reset commands from the HMI.

### Expected Result

- PLC receives each command once.
- Correct action executed.
- No duplicated commands.

Result

□ PASS

□ FAIL

---

## TC-005 Communication Loss

### Procedure

1. Disconnect the communication network.

### Expected Result

- Communication fault detected.
- Alarm generated.
- Equipment enters the defined safe state.

Result

□ PASS

□ FAIL

---

## TC-006 Automatic Reconnection

### Procedure

1. Restore communication.

### Expected Result

- Devices reconnect automatically.
- Data synchronization resumes.
- Communication alarms clear after recovery.

Result

□ PASS

□ FAIL

---

## TC-007 Invalid Data Handling

### Procedure

1. Simulate invalid communication data.

### Expected Result

- Invalid values rejected.
- Previous valid values retained.
- Diagnostic event recorded.

Result

□ PASS

□ FAIL

---

## TC-008 Simultaneous Communication

### Procedure

1. Exchange data simultaneously between PLC, HMI, AquaFeed Manager and all Modbus devices.

### Expected Result

- No communication conflicts.
- No data corruption.
- Stable response time.

Result

□ PASS

□ FAIL

---

## TC-009 Long-Term Communication

### Procedure

1. Operate all communication channels continuously for 24 hours.

### Expected Result

- No unexpected disconnects.
- Stable polling.
- No increasing communication error rate.

Result

□ PASS

□ FAIL

---

## TC-010 Communication Log Verification

### Procedure

1. Review communication logs after testing.

### Expected Result

- Connection events recorded.
- Communication faults recorded.
- Recovery events recorded.
- Timestamps accurate.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Communication shall remain stable during normal operation.
- Automatic recovery shall occur after temporary communication failures.
- Invalid communication data shall never affect machine safety.
- Communication logs shall remain complete and traceable.
- All connected systems shall remain synchronized.
- All test cases shall pass successfully.

---

# Tested Modules

- FB_ModbusMaster
- FB_Communication
- FB_SystemManager
- FB_Diagnostics
- FB_AlarmManager

---

# External Components

- Delta HMI
- AquaFeed Manager
- Delta VFDs
- Modbus RTU Network

---

# Revision

Version 1.0