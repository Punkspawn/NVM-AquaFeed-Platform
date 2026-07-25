# FB_CommunicationManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Communication Layer |
| Responsibility | Deterministic supervision of one statically configured PLC communication channel |
| Version | 1.1 |

## Scope

- one instance per approved Desktop/HMI or field-device channel
- bounded freshness, timeout, error, recovery, sequence, and counter supervision
- stable status for equipment and transfer owners

Excluded: protocol framing, serial-bus arbitration, socket handling, dynamic discovery, DHCP, routing, VPN, MQTT, OPC UA, cloud services, and physical output control. Vendor adapters own actual Modbus TCP/RTU transactions.

## Execution

- configuration is valid only with non-zero channel/profile/type, freshness timeout, and failure threshold
- a valid receive refreshes the channel even when its application sequence is a replay
- only a new application sequence advances LastAcceptedSequence
- protocol and timeout events increase a saturating consecutive-failure count
- the configured finite threshold latches the channel fault
- one valid receive clears the active communication fault and emits one recovery event
- wrap-safe monotonic elapsed time determines freshness
- counter reset is sequence-controlled and requires local Service permission

## Failure Behavior

- failure publishes status and a one-scan event; it never writes outputs
- VFD feedback loss is consumed by the owning equipment block
- Desktop/HMI loss blocks new remote transfers but does not stop a healthy accepted PLC job
- disabled or invalidly configured channels fail closed

## Contracts

- structure: `ST_CommunicationChannel.md`
- interface: `IF_Communication.md`
- topology: `COMMUNICATION_PROTOCOL.md`
- test: `TEST_Communication.md`

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-25 | Normalized bounded communication ownership. |
| 1.1 | 2026-07-26 | Closed per-channel configuration, freshness, failure, recovery, and reset semantics. |
