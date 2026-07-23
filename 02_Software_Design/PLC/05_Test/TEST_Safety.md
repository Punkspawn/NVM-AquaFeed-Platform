# TEST_Safety

---

# Purpose

Verify that all machine safety functions operate correctly and always place the system into a defined Safe State whenever a hazardous condition occurs.

---

# Test Environment

- Delta PLC
- Delta HMI
- Emergency Stop Circuit
- Selector
- Blower
- Dosing Unit
- Modbus RTU Network
- AquaFeed Manager

---

# Preconditions

- PLC powered on
- System Ready
- Safety circuit verified
- No active alarms
- Automatic operation enabled

---

# Test Cases

## TC-001 Emergency Stop

### Procedure

1. Start automatic feeding.
2. Press the Emergency Stop button.

### Expected Result

- All outputs de-energized immediately.
- Selector motion stopped.
- Blower stopped.
- Dosing stopped.
- Emergency alarm generated.
- System enters Safe State.

Result

□ PASS

□ FAIL

---

## TC-002 Emergency Stop Reset

### Procedure

1. Release Emergency Stop.
2. Reset alarms.

### Expected Result

- System remains stopped.
- Automatic restart not permitted.
- Operator must issue a new Start command.

Result

□ PASS

□ FAIL

---

## TC-003 Communication Failure

### Procedure

1. Disconnect the Modbus network during production.

### Expected Result

- Communication fault detected.
- Equipment transitions to the defined Safe State.
- Alarm generated.

Result

□ PASS

□ FAIL

---

## TC-004 Drive Fault

### Procedure

1. Simulate a VFD fault during production.

### Expected Result

- Dosing stops.
- Blower stops.
- Fault alarm displayed.
- System enters Fault state safely.

Result

□ PASS

□ FAIL

---

## TC-005 Selector Position Failure

### Procedure

1. Prevent the selector from reaching the commanded position.

### Expected Result

- Feeding sequence aborted.
- Blower does not start.
- Alarm generated.

Result

□ PASS

□ FAIL

---

## TC-006 Sensor Failure

### Procedure

1. Disconnect a critical position sensor.

### Expected Result

- Sensor fault detected.
- Related motion inhibited.
- Diagnostic event recorded.

Result

□ PASS

□ FAIL

---

## TC-007 Safety During Startup

### Procedure

1. Power on the PLC while Emergency Stop remains active.

### Expected Result

- Startup completed safely.
- Outputs remain OFF.
- System waits for Emergency Stop release and operator acknowledgement.

Result

□ PASS

□ FAIL

---

## TC-008 Safety During Power Recovery

### Procedure

1. Interrupt PLC power during production.
2. Restore power.

### Expected Result

- Outputs remain OFF after restart.
- Previous motion does not resume automatically.
- Operator acknowledgement required.

Result

□ PASS

□ FAIL

---

## TC-009 Simultaneous Faults

### Procedure

1. Trigger a communication fault and a drive fault simultaneously.

### Expected Result

- Both faults detected.
- Highest-priority safety response executed.
- System remains in a deterministic Safe State.

Result

□ PASS

□ FAIL

---

## TC-010 Safe Restart Verification

### Procedure

1. Clear all simulated faults.
2. Reset alarms.
3. Restart production.

### Expected Result

- Safety conditions verified before restart.
- Production resumes only after successful validation.
- No residual fault conditions remain.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Every safety event shall place the machine in a defined Safe State.
- Automatic restart shall never occur after a safety-related shutdown.
- All safety-related alarms shall be logged.
- Safety functions shall take priority over production commands.
- No unsafe output activation shall occur under any tested condition.
- All test cases shall pass successfully.

---

# Tested Modules

- FB_SystemManager
- FB_FeedingControlManager
- FB_AlarmManager
- FB_ModbusMaster
- FB_Diagnostics

---

# Related Hardware

- Emergency Stop Circuit
- Selector
- Blower
- Dosing Unit
- Safety Inputs
- Safety Outputs

---

# Revision

Version 1.0