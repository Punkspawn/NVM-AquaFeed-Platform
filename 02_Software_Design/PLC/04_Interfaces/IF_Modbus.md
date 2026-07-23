# IF_Modbus

---

# Purpose

Defines the standard software interface for Modbus communication.

This interface standardizes data exchange between the PLC, VFDs, HMI and AquaFeed Manager through the Modbus protocol.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables Modbus communication. |
| Connect | BOOL | Starts the communication session. |
| Reset | BOOL | Clears communication faults and retries the connection. |
| SlaveAddress | BYTE | Modbus slave address. |
| TimeoutMs | UINT | Communication timeout in milliseconds. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Connected | BOOL | Communication established successfully. |
| Busy | BOOL | Read or write transaction in progress. |
| TxCounter | DINT | Number of transmitted messages. |
| RxCounter | DINT | Number of received messages. |
| ErrorCounter | DINT | Number of communication errors. |
| Timeout | BOOL | Communication timeout detected. |
| Fault | BOOL | Communication fault active. |
| AlarmCode | UINT | Active communication alarm code. |

---

# State Flow

```text
Disabled
    │
Enable
    │
Connect
    │
Connected
    │
Read / Write
```

Communication fault

```text
Connected
    │
Timeout
    │
Fault
    │
Reset
    │
Connect
```

---

# Rules

- Communication shall only begin when `Enable = TRUE`.
- Only one Modbus transaction shall be active at a time.
- Every successful transaction shall increment `TxCounter` and `RxCounter`.
- Communication failures shall increment `ErrorCounter`.
- `Reset` shall clear the fault state and initiate a new connection attempt.
- `AlarmCode` shall be zero when no communication alarm is active.

---

# Used By

- FB_ModbusMaster
- FB_ModbusSlave
- FB_VFDManager
- FB_IOManager
- HMI
- AquaFeed Manager