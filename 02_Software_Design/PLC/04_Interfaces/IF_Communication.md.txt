# IF_Communication

---

# Purpose

Defines the standard software interface for communication between PLC modules and external devices.

This interface provides a unified communication layer for internal PLC data exchange, HMI communication, AquaFeed Manager connectivity and third-party devices.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables the communication interface. |
| Connect | BOOL | Starts the communication session. |
| Disconnect | BOOL | Terminates the communication session. |
| Reset | BOOL | Clears communication faults. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | Communication interface is initialized. |
| Connected | BOOL | Communication link is active. |
| Busy | BOOL | Data transmission is in progress. |
| TxCount | UDINT | Total transmitted packets. |
| RxCount | UDINT | Total received packets. |
| ErrorCount | UDINT | Total communication errors. |
| Fault | BOOL | Communication interface fault. |
| AlarmCode | UINT | Active communication alarm code. |

---

# Supported Communication

- PLC Internal Data Exchange
- HMI Communication
- AquaFeed Manager
- Modbus RTU
- Modbus TCP
- Ethernet

---

# State Flow

```text
Disabled
    │
Enable
    │
Ready
    │
Connect
    │
Connected
    │
Transmit / Receive
```

Disconnect sequence

```text
Connected
     │
Disconnect
     │
Ready
```

Fault sequence

```text
Any State
    │
Communication Error
    │
Fault
    │
Reset
    │
Ready
```

---

# Rules

- Only one active communication session shall exist per interface.
- Communication errors shall increment `ErrorCount`.
- Communication faults shall not affect the PLC scan cycle.
- Automatic reconnection may be attempted after a recoverable fault.
- `AlarmCode` shall be zero when communication is healthy.

---

# Used By

- FB_CommunicationManager
- FB_ModbusMaster
- FB_ModbusSlave
- FB_SystemManager
- HMI
- AquaFeed Manager
- External SCADA Systems