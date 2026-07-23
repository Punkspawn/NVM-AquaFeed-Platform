# Troubleshooting Guide

---

# Purpose

This document provides a structured procedure for diagnosing and resolving faults within the AquaFeed PLC system.

The objective is to minimize downtime while ensuring safe maintenance practices.

---

# Troubleshooting Philosophy

Fault diagnosis shall follow a systematic approach.

Never replace components before identifying the root cause.

Always verify the effectiveness of corrective actions before returning the system to production.

---

# General Troubleshooting Procedure

1. Record the alarm information.
2. Identify the affected subsystem.
3. Verify safety conditions.
4. Check power supply.
5. Verify communication.
6. Inspect field devices.
7. Verify PLC diagnostics.
8. Correct the fault.
9. Test system functionality.
10. Return the system to service.

---

# Safety Before Troubleshooting

Before any intervention:

- Stop automatic operation.
- Inform operators.
- Isolate hazardous energy if required.
- Follow Lock-Out / Tag-Out procedures.
- Verify Emergency Stop functionality.

---

# Fault Classification

| Category | Typical Cause |
|-----------|---------------|
| Safety | Emergency Stop, Safety Relay |
| Electrical | Drive Fault, Power Failure |
| Communication | Modbus Timeout |
| Mechanical | Jammed Equipment |
| Sensor | Limit Switch Failure |
| Configuration | Invalid Parameters |
| Software | Logic Error |

---

# PLC Not Running

Possible Causes

- No power
- Power supply failure
- PLC hardware fault
- Corrupted application
- CPU fault

Checks

- PLC LEDs
- Input voltage
- Diagnostic buffer
- CPU status
- Ethernet connection

Corrective Actions

- Restore power
- Replace faulty power supply
- Reload application
- Replace PLC if required

---

# HMI Offline

Possible Causes

- Ethernet disconnected
- Incorrect IP configuration
- PLC offline
- HMI application stopped

Checks

- Ethernet cable
- Switch LEDs
- IP address
- Ping PLC
- HMI diagnostics

Corrective Actions

- Restore network
- Correct IP configuration
- Restart HMI
- Restore communication

---

# Modbus Communication Failure

Possible Causes

- Cable disconnected
- Device powered off
- Wrong address
- Incorrect baud rate
- Timeout

Checks

- Device status
- Communication LEDs
- Register response
- Error counters

Corrective Actions

- Verify addressing
- Restore communication
- Replace damaged cable
- Restart communication devices

---

# Selector Fault

Possible Causes

- Position sensor failure
- Mechanical obstruction
- Motor overload
- Timeout

Checks

- Position sensors
- Motor current
- Mechanical movement
- Drive diagnostics

Corrective Actions

- Remove obstruction
- Replace faulty sensor
- Reset drive
- Verify positioning

---

# Blower Fault

Possible Causes

- Overload
- Thermal protection
- Drive fault
- Communication fault

Checks

- Motor current
- Cooling fan
- Drive diagnostics
- Output command

Corrective Actions

- Reset drive
- Repair motor
- Verify cooling
- Replace damaged components

---

# Dosing Unit Fault

Possible Causes

- Motor overload
- Feed blockage
- Encoder fault
- Mechanical jam

Checks

- Motor operation
- Gearbox
- Shaft movement
- Sensor feedback

Corrective Actions

- Remove blockage
- Repair gearbox
- Replace sensor
- Verify operation

---

# Emergency Stop Active

Possible Causes

- Emergency button pressed
- Safety relay opened
- Broken wiring

Checks

- Emergency pushbuttons
- Safety relay indicators
- Wiring continuity

Corrective Actions

- Release Emergency Stop
- Reset safety relay
- Repair wiring
- Perform safety verification

---

# Sensor Failure

Possible Causes

- Damaged sensor
- Misalignment
- Broken cable
- Power loss

Checks

- Sensor LED
- Supply voltage
- Signal wiring
- Mounting position

Corrective Actions

- Align sensor
- Replace sensor
- Repair cable

---

# Drive Fault

Possible Causes

- Overcurrent
- Overtemperature
- Motor overload
- Parameter error

Checks

- Drive display
- Fault history
- Motor current
- Parameter settings

Corrective Actions

- Clear fault
- Correct parameters
- Repair motor
- Replace drive if necessary

---

# Repeated Alarms

If the same alarm occurs repeatedly:

- Review alarm history.
- Check runtime statistics.
- Inspect related equipment.
- Verify environmental conditions.
- Perform root cause analysis.

Do not repeatedly reset alarms without identifying the cause.

---

# Diagnostic Information

During troubleshooting, collect:

- Alarm ID
- Time of occurrence
- PLC state
- Equipment state
- Communication status
- Runtime counters
- Operator actions
- Recent software changes

---

# Fault Resolution Verification

After corrective action:

- Verify alarm cleared.
- Verify equipment starts correctly.
- Execute functional test.
- Verify communication.
- Verify automatic sequence.
- Update maintenance records.

---

# Escalation Criteria

Escalate the issue if:

- Safety systems fail.
- PLC hardware is damaged.
- Software corruption is suspected.
- Repeated faults remain unresolved.
- Root cause cannot be determined.

---

# Related Documents

- Alarm_Catalog.md
- Commissioning_Guide.md
- Maintenance_Guide.md
- TEST_Diagnostics.md
- TEST_Communication.md

---

# Revision

Version 1.0