# ST_Device

---

# Purpose

Represents a physical device within the AquaFeed Platform.

Every controllable equipment in the system shall be represented by one instance of this structure.

---

# Structure

```iecst
TYPE ST_Device :
STRUCT

    DeviceId            : UINT;

    DeviceType          : E_DeviceType;

    LineId              : USINT;

    Enabled             : BOOL;

    Available           : BOOL;

    Running             : BOOL;

    Fault               : BOOL;

    AutoMode            : BOOL;

    ManualMode          : BOOL;

END_STRUCT
END_TYPE
```

---

# Updated By

- FB_DeviceManager

---

# Read By

- FB_SystemManager
- FB_LineManager
- HMI
- Desktop Application
- Diagnostics

---

# Description

## DeviceId

Unique identifier of the device.

Each physical device shall have a unique DeviceId.

---

## DeviceType

Defines the equipment type.

Examples:

- Blower
- Dosing
- Selector
- Air Lock
- Conveyor

---

## LineId

Identifies the feeding line to which the device belongs.

---

## Enabled

Indicates whether the device is enabled by configuration.

A disabled device cannot participate in automatic operation.

---

## Available

Indicates whether the device is currently available for operation.

A device may be enabled but unavailable due to maintenance, interlocks, communication loss, or other operational restrictions.

---

## Running

Indicates that the device is currently operating.

---

## Fault

Indicates that the device has an active fault condition.

---

## AutoMode

Indicates that the device is operating in Automatic Mode.

---

## ManualMode

Indicates that the device is operating in Manual Mode.

---

# Rules

A device cannot be Running when Enabled is FALSE.

AutoMode and ManualMode shall never both be TRUE.

A faulted device shall not start until the fault has been cleared.

Only FB_DeviceManager is allowed to modify this structure.

Other modules shall access this structure as read-only whenever possible.

---

# Lifetime

Device information remains allocated during PLC runtime.

Configuration parameters may be synchronized with the Desktop Application.

---

# Example

```iecst
g_Devices[1]    // Blower

g_Devices[2]    // Selector

g_Devices[3]    // Dosing Motor
```