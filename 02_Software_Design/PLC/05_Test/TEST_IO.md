# TEST_IO

---

# Purpose

Verify the correct operation of all PLC digital and analog inputs and outputs, including signal validation, fail-safe behavior and hardware feedback.

---

# Test Environment

- Delta PLC
- Installed I/O Modules
- HMI
- Field Devices
- Multimeter / Signal Generator

---

# Preconditions

- PLC powered on
- I/O modules detected
- Wiring verified
- No active alarms

---

# Test Cases

## TC-001 Digital Input Verification

### Procedure

1. Activate each digital input individually.

### Expected Result

- Corresponding PLC input changes state.
- HMI status updates immediately.
- No false triggering occurs.

Result

□ PASS

□ FAIL

---

## TC-002 Digital Output Verification

### Procedure

1. Activate each digital output from Manual Mode.

### Expected Result

- Correct output energizes.
- Corresponding field device responds.
- Feedback signal confirms operation.

Result

□ PASS

□ FAIL

---

## TC-003 Analog Input Verification

### Procedure

1. Inject known analog signals into each analog input.

### Expected Result

- PLC displays the correct engineering value.
- Signal scaling is accurate.

Result

□ PASS

□ FAIL

---

## TC-004 Analog Output Verification

### Procedure

1. Command several analog output values.

### Expected Result

- Output voltage/current matches the commanded value.
- Field device responds correctly.

Result

□ PASS

□ FAIL

---

## TC-005 Sensor Failure

### Procedure

1. Disconnect a field sensor.

### Expected Result

- Sensor fault detected.
- Alarm generated.
- Unsafe operation prevented.

Result

□ PASS

□ FAIL

---

## TC-006 Output Feedback Verification

### Procedure

1. Activate an output.
2. Prevent the actuator from operating.

### Expected Result

- Output command remains active.
- Missing feedback detected.
- Fault alarm generated.

Result

□ PASS

□ FAIL

---

## TC-007 Emergency Input Verification

### Procedure

1. Activate the Emergency Stop input.

### Expected Result

- Safety logic executed immediately.
- Outputs disabled.
- Emergency alarm generated.

Result

□ PASS

□ FAIL

---

## TC-008 Power Cycle Verification

### Procedure

1. Record all I/O states.
2. Restart the PLC.

### Expected Result

- Inputs refreshed correctly.
- Outputs remain in their defined startup state.
- No invalid output activation occurs.

Result

□ PASS

□ FAIL

---

## TC-009 Noise Immunity

### Procedure

1. Simulate electrical noise on selected inputs.

### Expected Result

- Signal filtering prevents false transitions.
- No unintended machine actions occur.

Result

□ PASS

□ FAIL

---

## TC-010 Complete I/O Verification

### Procedure

1. Execute a full I/O test covering every configured channel.

### Expected Result

- All channels verified.
- No address conflicts.
- No wiring inconsistencies detected.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Every configured I/O channel shall operate correctly.
- Input filtering shall prevent false triggering.
- Output feedback shall confirm successful actuation where implemented.
- Sensor failures shall be detected reliably.
- Safety-related inputs shall always have priority.
- All test cases shall pass successfully.

---

# Tested Modules

- FB_IOManager
- FB_SystemManager
- FB_AlarmManager
- FB_Diagnostics

---

# Related Hardware

- Digital Inputs
- Digital Outputs
- Analog Inputs
- Analog Outputs
- Field Sensors
- Actuators

---

# Revision

Version 1.0