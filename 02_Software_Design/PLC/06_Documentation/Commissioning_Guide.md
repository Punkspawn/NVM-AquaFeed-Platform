# Commissioning Guide

---

# Purpose

This document defines the standard commissioning procedure for the AquaFeed PLC system.

The objective is to ensure that every installation is commissioned safely, consistently and with complete verification before production begins.

---

# Commissioning Objectives

The commissioning process shall verify:

- Hardware installation
- Electrical wiring
- PLC software
- HMI functionality
- Modbus communication
- Safety circuits
- Equipment operation
- Alarm system
- Production sequence
- System performance

---

# Required Documents

Before commissioning, verify the availability of:

- Electrical drawings
- PLC software
- HMI project
- I/O list
- Network topology
- Modbus register map
- Test procedures
- FAT report
- SAT checklist

---

# Required Equipment

Prepare the following tools:

- Laptop with engineering software
- PLC programming cable
- Multimeter
- Network tester
- Insulation tester (if required)
- Phase rotation tester
- Basic hand tools

---

# Pre-Commissioning Checklist

Verify:

- PLC installed correctly
- Power supply available
- Protective grounding connected
- Emergency Stop circuit complete
- Network cables connected
- Field devices powered
- Motor protections installed
- Drives parameterized

Do not energize the system until all checks are complete.

---

# PLC Verification

Confirm:

- Correct PLC model
- Correct firmware version
- Correct application loaded
- No compiler errors
- No startup diagnostics
- System clock configured

---

# HMI Verification

Verify:

- Correct project version
- Screen navigation
- Alarm display
- User login
- Recipe screens
- Runtime statistics
- Communication indicators

---

# Modbus Communication Test

Verify communication with all configured devices.

Check:

- IP address / Node ID
- Baud rate (RTU)
- Communication timeout
- Device status
- Register values

No communication alarms shall remain active.

---

# Digital Input Test

Test every digital input individually.

Examples:

- Emergency Stop
- Start Push Button
- Stop Push Button
- Reset
- Selector Sensors
- Limit Switches
- Safety Contacts

Confirm correct PLC indication.

---

# Digital Output Test

Verify every digital output.

Examples:

- Selector Motor
- Blower Start
- Dosing Motor
- Alarm Buzzer
- Tower Light

Outputs shall respond correctly to manual commands.

---

# Analog Signal Test

Verify:

- Scaling
- Engineering units
- Sensor calibration
- Noise level
- Stable readings

All analog values shall remain within expected tolerances.

---

# Drive Verification

Confirm:

- Communication
- Motor direction
- Speed reference
- Acceleration
- Deceleration
- Fault reset
- Current feedback

Test both local and automatic operation if supported.

---

# Equipment Functional Tests

## Selector

Verify:

- Positioning accuracy
- Home position
- Sensor feedback
- Timeout detection

---

## Blower

Verify:

- Start
- Stop
- Speed control
- Runtime monitoring
- Fault handling

---

## Dosing Unit

Verify:

- Start
- Stop
- Speed reference
- Feed quantity
- Runtime accumulation

---

# Alarm Verification

Trigger representative alarms.

Examples:

- Emergency Stop
- Motor fault
- Communication loss
- Sensor failure
- Timeout

Verify:

- Alarm display
- Alarm logging
- Alarm acknowledgement
- Alarm reset

---

# Safety Verification

Confirm:

- Emergency Stop stops all hazardous motion
- Outputs become safe
- Fault state activated
- Restart requires manual reset
- Production cannot restart automatically

---

# Automatic Operation Test

Execute a complete feeding cycle.

Verify:

- Recipe loading
- Equipment startup
- Feeding sequence
- Runtime statistics
- Alarm monitoring
- Normal shutdown

Cycle shall complete without unexpected faults.

---

# Performance Verification

Measure:

- PLC scan time
- Communication latency
- Startup time
- Shutdown time
- Recipe loading time

All values shall meet project requirements.

---

# Acceptance Criteria

The system is accepted when:

- No critical alarms remain active
- Safety functions verified
- Communication stable
- All I/O tested
- Automatic operation successful
- FAT deviations resolved
- SAT completed

---

# Commissioning Report

The final report shall include:

- Project name
- PLC version
- HMI version
- Date
- Engineer
- Test results
- Deviations
- Corrective actions
- Customer approval

---

# Related Documents

- TEST_Commissioning.md
- TEST_FAT.md
- TEST_SAT.md
- Modbus_Register_Map.md
- Alarm_Catalog.md

---

# Revision

Version 1.0