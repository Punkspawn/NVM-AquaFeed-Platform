# Modbus Register Map

---

# Purpose

This document defines the Modbus communication architecture used by the AquaFeed PLC software.

It standardizes the register allocation, data formats, access permissions and communication rules between the PLC, HMI and external systems.

---

# Communication Protocol

| Property | Value |
|----------|-------|
| Protocol | Modbus TCP / RTU |
| Master | PLC |
| Slaves | VFDs, Remote I/O, HMI, External Devices |
| Byte Order | Big Endian |
| Word Size | 16 Bit |
| Data Encoding | Signed / Unsigned Integer, IEEE754 Float |

---

# Register Areas

| Address Range | Purpose |
|---------------|---------|
| 00001–09999 | Coils (Digital Outputs) |
| 10001–19999 | Discrete Inputs |
| 30001–39999 | Input Registers |
| 40001–49999 | Holding Registers |

Only Holding Registers shall be used for writable parameters.

---

# Data Types

| Type | Registers | Description |
|------|-----------|-------------|
| BOOL | 1 Bit | Boolean value |
| UINT16 | 1 Register | Unsigned Integer |
| INT16 | 1 Register | Signed Integer |
| UINT32 | 2 Registers | Unsigned Long Integer |
| INT32 | 2 Registers | Signed Long Integer |
| REAL | 2 Registers | IEEE754 Floating Point |

---

# Register Allocation

## System Information

| Register | Access | Description |
|----------|--------|-------------|
| 40001 | R | Software Version |
| 40002 | R | PLC Status |
| 40003 | R | Active Alarm Count |
| 40004 | R | System State |
| 40005 | R | Current Job ID |
| 40006 | R | Active Recipe |

---

## Line Status

Each production line occupies a fixed register block.

Example:

| Register | Description |
|----------|-------------|
| 40100 | Line State |
| 40101 | Job State |
| 40102 | Selector Position |
| 40103 | Blower Status |
| 40104 | Dosing Status |
| 40105 | Runtime (Hours) |
| 40106 | Alarm Status |
| 40107 | Current Recipe |

Additional lines shall continue using identical offsets.

---

## Commands

Commands shall be written by the HMI or supervisory system.

| Register | Access | Description |
|----------|--------|-------------|
| 41000 | W | Start Command |
| 41001 | W | Stop Command |
| 41002 | W | Reset Fault |
| 41003 | W | Pause |
| 41004 | W | Resume |
| 41005 | W | Maintenance Mode |

Commands shall be pulse-based where applicable.

---

## Recipe Management

| Register | Description |
|----------|-------------|
| 42000 | Recipe Number |
| 42001 | Feed Amount |
| 42002 | Feeding Duration |
| 42003 | Blower Speed |
| 42004 | Dosing Speed |
| 42005 | Recipe Validation Result |

---

## Runtime Statistics

| Register | Description |
|----------|-------------|
| 43000 | Total Runtime |
| 43002 | Feed Cycles |
| 43004 | Total Feed Quantity |
| 43006 | Today's Runtime |
| 43008 | Maintenance Counter |

32-bit values occupy two consecutive registers.

---

## Alarm Information

| Register | Description |
|----------|-------------|
| 44000 | Active Alarm ID |
| 44001 | Alarm Severity |
| 44002 | Alarm Module |
| 44003 | Alarm Timestamp (Low Word) |
| 44004 | Alarm Timestamp (High Word) |

---

# Access Permissions

| Access | Description |
|---------|-------------|
| R | Read Only |
| W | Write Only |
| RW | Read / Write |

Critical system parameters shall never be writable without authorization.

---

# Communication Rules

- Every write request shall be validated.
- Invalid register addresses shall be rejected.
- Out-of-range values shall not be accepted.
- Communication errors shall generate alarms.
- All writes shall be confirmed before execution.

---

# Timeout Handling

Default communication timeout:

- 1000 ms

After timeout:

- Retry communication
- Increment retry counter
- Generate communication alarm after retry limit
- Maintain last valid process state if safe

---

# Exception Handling

Supported Modbus exceptions include:

- Illegal Function
- Illegal Data Address
- Illegal Data Value
- Slave Device Failure

Each exception shall be logged for diagnostics.

---

# Register Expansion

Future register additions shall:

- Preserve existing addresses
- Avoid overlapping allocations
- Follow the established block structure
- Be documented before implementation

Unused register ranges should remain reserved for future expansion.

---

# Related Documents

- IF_Modbus.md
- PLC_Programming_Guideline.md
- Alarm_Catalog.md
- TEST_ModbusMaster.md

---

# Revision

Version 1.0