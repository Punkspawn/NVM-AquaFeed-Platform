# ST_ModbusMap

---

# Purpose

Defines the shared Modbus memory map used between the PLC and AquaFeed Manager.

This structure provides a standardized interface for data exchange.

The PLC is the owner of this structure.

Desktop applications shall access it only through the communication layer.

---

# Structure

```iecst
TYPE ST_ModbusMap :
STRUCT

    //--------------------------------------------------
    // System
    //--------------------------------------------------

    SystemStatus        : ST_SystemStatus;

    //--------------------------------------------------
    // Lines
    //--------------------------------------------------

    Lines               : ARRAY[1..6] OF ST_Line;

    //--------------------------------------------------
    // Recipes
    //--------------------------------------------------

    ActiveRecipe        : ST_Recipe;

    //--------------------------------------------------
    // Current Job
    //--------------------------------------------------

    ActiveJob           : ST_JobOrder;

    //--------------------------------------------------
    // Runtime
    //--------------------------------------------------

    Runtime             : ST_Runtime;

    //--------------------------------------------------
    // Diagnostics
    //--------------------------------------------------

    Diagnostics         : ST_Diagnostics;

    //--------------------------------------------------
    // Maintenance
    //--------------------------------------------------

    Maintenance         : ARRAY[1..20] OF ST_Maintenance;

    //--------------------------------------------------
    // Active User
    //--------------------------------------------------

    CurrentUser         : ST_User;

    //--------------------------------------------------
    // Alarm List
    //--------------------------------------------------

    ActiveAlarms        : ARRAY[1..50] OF ST_Alarm;

END_STRUCT
END_TYPE
```

---

# Updated By

FB_SystemManager

Communication Manager

---

# Read By

Desktop Application

HMI

SCADA (Future)

Remote Services (Future)

---

# Communication Ownership

PLC owns the data.

Desktop reads status.

Desktop writes commands only.

The Desktop shall never overwrite PLC runtime information.

---

# Memory Layout

Communication follows fixed register blocks.

| Register Range | Description |
|----------------|-------------|
| 1000–1999 | System |
| 2000–2999 | Commands |
| 3000–3999 | Status |
| 4000–4999 | Recipes |
| 5000–5999 | Runtime |
| 6000–6999 | Alarms |
| 7000–7999 | Diagnostics |
| 8000–8999 | Maintenance |
| 9000–9999 | Reserved |

---

# Rules

The Modbus address map is fixed after release.

Never change register meanings in future versions.

Only append new registers.

Do not reuse removed registers.

Maintain backward compatibility whenever possible.

---

# Synchronization

PLC updates runtime values continuously.

Desktop polls data periodically.

Commands are written as one-shot values.

PLC clears command bits after successful execution.

---

# Error Handling

Invalid register values shall be ignored.

Out-of-range values shall generate a communication error.

Communication failures shall not stop the machine.

---

# Lifetime

Global.

Always allocated.

Available during the entire PLC runtime.

---

# Used By

- Communication Layer
- AquaFeed Manager
- HMI
- Future SCADA Integration
- Future Cloud Gateway