# TEST_ModbusMaster

---

# Purpose

Verify the correct operation of FB_ModbusMaster.

This test validates Modbus RTU communication, polling sequence, timeout handling, CRC verification, retry mechanism, communication recovery and data integrity.

---

# Preconditions

- PLC powered on
- Modbus network connected
- All slave devices powered
- Communication parameters configured
- No active communication faults

---

# Test Cases

## TC-001 Establish Communication

### Procedure

1. Start the PLC.
2. Initialize Modbus Master.

### Expected Result

- Communication established.
- All configured slaves detected.
- CommunicationHealthy = TRUE.

Result

□ PASS

□ FAIL

---

## TC-002 Read Holding Registers

### Procedure

1. Read configured Holding Registers from a slave device.

### Expected Result

- Requested values received.
- Data stored correctly.
- No communication errors.

Result

□ PASS

□ FAIL

---

## TC-003 Write Holding Registers

### Procedure

1. Write a valid parameter to a slave.

### Expected Result

- Write successful.
- Slave confirms update.
- Readback value matches written value.

Result

□ PASS

□ FAIL

---

## TC-004 Communication Timeout

### Procedure

1. Disconnect one slave device.
2. Continue polling.

### Expected Result

- Timeout detected.
- Retry counter incremented.
- Communication alarm generated.

Result

□ PASS

□ FAIL

---

## TC-005 CRC Error Detection

### Procedure

1. Inject an invalid Modbus frame.

### Expected Result

- CRC error detected.
- Invalid packet discarded.
- Communication continues normally.

Result

□ PASS

□ FAIL

---

## TC-006 Automatic Retry

### Procedure

1. Disconnect communication briefly.
2. Restore communication.

### Expected Result

- Retry attempts executed.
- Communication automatically restored.
- Alarm cleared after recovery.

Result

□ PASS

□ FAIL

---

## TC-007 Slave Offline

### Procedure

1. Power off one slave device.

### Expected Result

- Offline slave detected.
- Remaining slaves continue normal communication.
- System remains operational where possible.

Result

□ PASS

□ FAIL

---

## TC-008 Communication Recovery

### Procedure

1. Restore power to the offline slave.

### Expected Result

- Slave automatically detected.
- Polling resumes.
- No PLC restart required.

Result

□ PASS

□ FAIL

---

## TC-009 Heavy Communication Load

### Procedure

1. Poll all configured devices continuously under maximum load.

### Expected Result

- Communication cycle remains stable.
- No frame loss.
- Scan time remains within acceptable limits.

Result

□ PASS

□ FAIL

---

## TC-010 Long-Term Stability

### Procedure

1. Run Modbus communication continuously for 24 hours.

### Expected Result

- No communication lockups.
- No memory leaks.
- Error counters remain within acceptable limits.
- Stable communication throughout the test.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Communication shall automatically recover after temporary failures.
- CRC errors shall never corrupt application data.
- Communication failures shall be detected within the configured timeout.
- Slave failures shall not interrupt communication with other devices.
- Polling order shall remain deterministic.
- All test cases shall pass successfully.

---

# Tested Module

FB_ModbusMaster

---

# Related Modules

- FB_SystemManager
- FB_Blower
- FB_Dosing
- FB_Selector
- FB_AlarmManager
- FB_RuntimeManager
- AquaFeed Manager

---

# Revision

Version 1.0