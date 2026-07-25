# Integration and Edge Scope Index

| Field | Value |
|---|---|
| Status | Authoritative scope index |
| Owner | Integration / Edge |
| Version | 1.0 |

## Owned Services

- protocol adapters, message mapping, queues, retries, and external-system integration
- secure remote gateway, VPN/session brokering, authorization handoff, and audit transport
- cloud connectivity, telemetry forwarding, store-and-forward, and fleet synchronization
- Edge host runtime, local services, containers, resource supervision, and offline buffering
- AI inference/recommendation services and model lifecycle
- digital-twin models, simulation, scenario analysis, and virtual commissioning
- software/firmware package repository, signature verification, distribution, rollout, and rollback coordination

## PLC Boundary

PLC exposes only bounded, versioned realtime contracts. Integration/Edge cannot bypass PLC safety, mode, interlock, identity, sequence, or bounds checks.

Remote or AI output is advisory until Desktop policy and the PLC command contract accept it. Loss of cloud, Edge, AI, or remote access does not stop an already accepted healthy PLC-controlled feeding job.

## Update Boundary

Integration/Edge owns package acquisition, cryptographic verification, inventory, rollout policy, and audit history. PLC owns only safe activation permission and status through `IF_UpdateActivation.md`.
