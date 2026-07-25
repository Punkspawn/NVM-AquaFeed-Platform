# IF_Communication

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Communication Layer |
| Version | 2.0 |

## Purpose

Publishes bounded channel health and counters without combining application data maps, Desktop sessions, and field-device drivers into one ambiguous interface.

One instance exists per communication channel.

## Inputs

| Name | Type | Description |
|---|---|---|
| `xEnable` | BOOL | Enables channel supervision. |
| `xRxActivity` | BOOL | Valid receive activity event. |
| `xTxActivity` | BOOL | Valid transmit activity event. |
| `xProtocolError` | BOOL | Bounded protocol error event. |
| `xTimeout` | BOOL | Timeout event. |
| `xResetCounters` | BOOL | Accepted service command to reset diagnostic counters. |

## Outputs

| Name | Type | Description |
|---|---|---|
| `xReady` | BOOL | Channel initialized. |
| `xCommunicationOK` | BOOL | Fresh validated activity within configured timeout. |
| `xFault` | BOOL | Channel fault threshold reached. |
| `udiTxCount` | UDINT | Saturating transmit count. |
| `udiRxCount` | UDINT | Saturating receive count. |
| `udiErrorCount` | UDINT | Saturating protocol-error count. |
| `udiTimeoutCount` | UDINT | Saturating timeout count. |
| `uiAlarmCode` | UINT | Active bounded communication alarm code. |

## Channel Profiles

### Desktop Modbus TCP

- Desktop/HMI is client/master.
- PLC is server/slave.
- Freshness uses heartbeat counter change, not TCP connection alone.
- Loss blocks new remote transactions but does not stop healthy active production.

### VFD Modbus RTU

- PLC is master.
- VFDs are addressed slaves.
- Retry and polling are bounded.
- Each drive profile owns its register definitions.

## Rules

- Counters saturate instead of wrapping silently.
- Communication processing never blocks the PLC scan.
- Channel fault does not directly write machine outputs.
- Alarm conditions use IF_Alarm.
- Application data uses the authoritative Modbus TCP register map.
