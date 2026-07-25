# PLC–Integration/Edge Boundary

| Field | Value |
|---|---|
| Status | Authoritative |
| Owners | PLC Runtime and Integration / Edge |
| Version | 1.0 |

## Data Direction

- PLC publishes bounded state, alarms, diagnostics, counters, and accepted-command results.
- Integration/Edge buffers, translates, routes, persists, and forwards this data.
- Integration/Edge submits commands only through versioned PLC interfaces.
- PLC validates every command independently.

## Failure Rules

- cloud, AI, remote gateway, or Edge service failure never directly changes PLC outputs
- communication loss blocks new remote transfers
- an already accepted healthy job continues under PLC ownership
- stale, duplicate, out-of-order, oversized, or identity-mismatched commands are rejected
- reconnection uses sequence-aware synchronization without replaying commands

## Prohibited Coupling

- database, REST, MQTT broker, cloud SDK, VPN, container, model, digital-twin, or firmware repository logic inside PLC Function Blocks
- direct remote writes to physical outputs
- AI decisions that bypass Desktop authorization or PLC validation
