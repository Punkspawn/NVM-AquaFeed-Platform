# Structure

ST_OperationData

---

# Purpose

Stores the complete data of a single feeding operation.

This structure is used to exchange operation information between Function Blocks and to provide operation data to the Modbus server.

---

# Members

| Name | Type | Description |
|------|------|-------------|
| OperationID | DINT | Unique operation identifier |
| LineNumber | INT | Feeding line number |
| OperationState | E_OperationState | Current operation state |
| FeedAmount | REAL | Delivered feed amount (kg) |
| OperationDuration | TIME | Total operation duration |
| StartRequest | BOOL | Operation start request |
| StopRequest | BOOL | Operation stop request |
| Completed | BOOL | Operation completed flag |
| FaultActive | BOOL | Operation fault flag |

---

# Description

Each feeding line owns one instance of ST_OperationData.

The structure represents the current state of one feeding operation.

---

# Used By

- FB_OperationManager
- FB_LineController
- FB_ModbusServer
- FB_StatisticsManager

---

# Notes

This structure only stores runtime operation information.

It does not:

- Store operation history
- Store statistical data
- Generate reports
- Handle Modbus communication

---

# Related Documents

- E_OperationState.md
- FB_OperationManager.md
- FB_ModbusServer.md

---

# Revision

Version 1.0