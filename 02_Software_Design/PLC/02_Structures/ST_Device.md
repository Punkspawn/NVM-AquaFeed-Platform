# ST_Device

---

# Purpose

Represents a physical or logical device used in the AquaFeed Platform.

Every controllable equipment shall be represented using this structure.

---

# Structure

```iecst
TYPE ST_Device :
STRUCT

    DeviceId            : UINT;

    DeviceType          : E_DeviceType;

    LineId              : USINT;

    Name                : STRING[30];

    Enabled             : BOOL;

    Available           : BOOL;

    Healthy             : BOOL;

    Running             : BOOL;

    Fault               : BOOL;

    AutoMode            : BOOL;

    ManualMode          : BOOL;

END_STRUCT
END_TYPE
```

---

# Updated By

FB_DeviceManager

---

# Read By

FB_SystemManager

HMI

Desktop Application

Diagnostics

---

# Description

## DeviceId

Unique device identifier.

---

## DeviceType

Device classification.

Examples

- Blower
- Dosing
- Selector
- Air Lock
- Conveyor

---

## LineId

Associated feeding line.

---

## Name

Device display name.

---

## Enabled

Device is enabled by configuration.

---

## Available

Device is available for operation.

---

## Healthy

Device reports healthy status.

---

## Running

Device is currently operating.

---

## Fault

Device has an active fault.

---

## AutoMode

Device is operating automatically.

---

## ManualMode

Device is operating manually.

---

# Rules

A device cannot be Running if Enabled is FALSE.

A Faulted device shall never report Healthy.

AutoMode and ManualMode cannot both be TRUE.

---

# Lifetime

Device information remains in PLC memory.

Configuration values are synchronized with the Desktop Application.

---

# Example

```iecst
Devices[50]
```