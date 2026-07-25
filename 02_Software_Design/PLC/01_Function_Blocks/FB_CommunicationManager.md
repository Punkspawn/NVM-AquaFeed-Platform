# FB_CommunicationManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Communication Layer |
| Responsibility | Bounded supervision and scheduling of configured PLC communication channels |
| Version | 1.0 |

## Scope

- Desktop/HMI Modbus TCP server publication and command validation
- PLC-master Modbus RTU polling of approved VFD/field-device profiles
- channel freshness, timeout, retry, sequence, and bounded counters
- communication diagnostic conditions

Excluded: DHCP/router/switch management, node discovery, VPN, MQTT, OPC UA, cloud, topology optimization, bandwidth analytics, and remote sessions.

## Execution

- fixed maximum 16 channel records
- no dynamic discovery or dynamic memory
- at most one RTU transaction active on one physical bus
- bounded round-robin polling with priority for required control feedback
- retry count and timeout are finite per profile
- cyclic work is limited by the approved scan-time budget
- TCP application publication uses the explicit `ST_ModbusMap` wire buffer

## Failure Behavior

- channel failure publishes status and alarm conditions; it does not directly write outputs
- VFD feedback loss is consumed by the owning equipment block, which applies its defined stop behavior
- Desktop/HMI loss blocks new remote transfers but does not stop a healthy accepted PLC-controlled job
- reconnection validates map version and sequences before writes resume
- stale or duplicate commands change no PLC state

## Contracts

- structure: `ST_CommunicationChannel.md`
- interface: `IF_Communication.md`
- topology: `COMMUNICATION_PROTOCOL.md`
- test: `TEST_Communication.md`
