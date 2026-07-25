# Function

FN_GetCurrentOperationData

---

# Purpose

Collects the current operation data and prepares it for transfer to external systems.

This function gathers all operation values required by the Modbus server.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperationID | DINT | Current operation identifier |
| LineNumber | INT | Active feeding line |
| FeedAmount | REAL | Delivered feed amount (kg) |
| OperationDuration | TIME | Current operation duration |
| OperationState | E_OperationState | Current operation state |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | ST_OperationData | Current operation data structure |

---

# Logic

```text
Copy current operation values into
ST_OperationData.

Return completed structure.
```

---

# Rules

- The function shall only read data.
- The function shall not modify PLC variables.
- The function shall not communicate via Modbus.
- The function shall execute within a single PLC scan.

---

# Return Value

Current operation data structure.

---

# Typical Usage

- FB_ModbusServer
- FB_OperationManager

---

# Used By

- FB_ModbusServer

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function prepares the current operation data.

It does not:

- Send Modbus messages
- Store history
- Generate reports
- Calculate statistics

These responsibilities belong to other Function Blocks.

---

# Related Documents

- ST_OperationData.md
- FB_ModbusServer.md
- FB_OperationManager.md

---

# Revision

Version 1.0