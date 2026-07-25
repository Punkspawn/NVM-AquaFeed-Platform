# AquaFeed Communication Protocol

| Field | Value |
|---|---|
| Status | Authoritative |
| Version | 2.0 |

## Topology

```text
AquaFeed Manager / HMI
        │ Modbus TCP client/master
        ▼
Delta PLC
        │ Modbus RTU master
        ▼
VFDs and approved field devices
```

Desktop–PLC and PLC–field-device communication are separate channels with different roles and maps.

## Desktop–PLC Modbus TCP

- Desktop/HMI: client/master
- PLC: server/slave
- TCP port: 502
- application data: versioned Holding Register map
- commands: sequence + payload + acknowledgement
- machine authority: PLC
- Desktop loss: no automatic stop of a healthy active feeding sequence
- new execution transfer: prohibited while Desktop communication is unavailable

## PLC–VFD Modbus RTU

- PLC: sole master
- each VFD/device: unique slave address
- physical layer: RS-485
- timeout and retry: bounded and configurable
- drive register definitions: separate device profiles
- VFD map shall never be confused with the Desktop–PLC application map

## Heartbeat

- PLC increments PLC heartbeat once per second.
- Desktop increments Desktop heartbeat once per second.
- PLC echoes the last accepted Desktop heartbeat.
- A changed counter proves freshness; a static nonzero value does not.
- Timeout raises a communication alarm and prevents new remote transactions.
- Active healthy PLC-controlled production continues.

## Time

Desktop is the wall-clock authority for persistent history. PLC may receive validated time synchronization for display/diagnostics, but safety and sequence timers use monotonic PLC timers and never depend on wall-clock time.

## Control Boundary

Desktop may request commands and transfer validated snapshots. PLC validates every request and decides whether it is accepted.

Desktop never writes:

- physical outputs
- safety state
- SystemState or LineState
- active alarm lifecycle state
- delivered quantity
- internal timers or state-machine steps

## Reconnection

1. establish TCP connection
2. read magic and map version
3. enter read-only mode if major version is unsupported
4. synchronize heartbeat and last processed sequences
5. reconcile execution-transfer and alarm-event sequences idempotently
6. resume new writes only after validation

No PLC restart is required.

## Related Documents

- [Modbus Register Map](../06_Documentation/Modbus_Register_Map.md)
- [ST_ModbusMap](../02_Structures/ST_ModbusMap.md)
- [IF_ExecutionTransfer](../04_Interfaces/IF_ExecutionTransfer.md)
