# AquaFeed Communication Protocol

| Field | Value |
|---|---|
| Status | Authoritative |
| Version | 3.1 |

## Topology

```text
AquaFeed Manager / HMI
        │ Modbus TCP client/master
        ▼
Delta PLC server/slave
        │ Modbus RTU sole master
        ▼
Approved VFDs / field devices
```

Desktop–PLC and PLC–field-device communication are separate channels with separate roles, maps, timeout policies, and failure effects.

## Desktop–PLC Modbus TCP

- application data uses the versioned 4000-WORD Holding Register map
- commands use identity, sequence, bounded payload, validation result, and acknowledgement
- changed heartbeat counter proves freshness; socket state or static nonzero value does not
- Desktop loss blocks new remote commands/transfers
- a healthy already accepted PLC-controlled job continues
- unsupported major map version permits diagnostic reads only

## PLC–Field Modbus RTU

- PLC is the only master on each configured RS-485 bus
- one transaction may be active per bus
- each approved device profile owns slave address, register map, poll class, timeout, retry limit, byte/word order, and safe failure behavior
- control-critical feedback receives bounded polling priority
- VFD registers never share meaning with the Desktop application map

## Default Blower VFD Profile

- current hardware baseline: panel-mounted Delta C2000 Plus, 22 kW, 380–480 V class
- final drive order code is selected by motor nameplate current and the C2000 Plus heavy-duty rating
- the device profile translates vendor-specific registers into the normalized `IF_Blower` boundary
- `FB_Blower` never contains C2000 register addresses, control words, byte order, or vendor fault decoding
- replacing the drive requires another approved static profile and commissioning test, not another blower state machine
- exact register addresses and parameter values are frozen only against the purchased drive manual revision

## Scheduling and Bounds

- maximum 16 statically configured channel records
- fixed queues/buffers only
- finite retry and timeout values
- no dynamic node discovery
- communication work never blocks the cyclic PLC task
- all counters saturate

## Time and Freshness

Timeouts use `FB_TimeService` monotonic ticks or IEC timers. Desktop remains wall-clock authority. Wall-clock adjustment cannot change channel freshness, retry deadlines, runtime, or equipment timers.

## Reconnection

1. establish transport
2. validate channel/profile or map identity
3. validate major version
4. synchronize heartbeat and last accepted sequences
5. reconcile event/transfer acknowledgements idempotently
6. enable writes only after validation

No PLC restart is required.

## Ownership Boundary

PLC owns bounded protocol handling, map validation, channel freshness, and field-device polling. Integration/Edge owns VPN, routing, cloud, MQTT, OPC UA, external APIs, fleet transport, persistent message queues, and remote-session security.

## Related Documents

- [Modbus Register Map](../06_Documentation/Modbus_Register_Map.md)
- [ST_ModbusMap](../02_Structures/ST_ModbusMap.md)
- [ST_CommunicationChannel](../02_Structures/ST_CommunicationChannel.md)
- [IF_Communication](../04_Interfaces/IF_Communication.md)
- [IF_Time](../04_Interfaces/IF_Time.md)
