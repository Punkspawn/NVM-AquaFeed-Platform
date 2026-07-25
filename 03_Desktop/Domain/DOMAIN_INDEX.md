# Desktop Domain Index

| Field | Value |
|---|---|
| Status | Authoritative scope index |
| Owner | AquaFeed Manager / Desktop |
| Version | 1.0 |

## Platform Services

- database synchronization and persistence
- reports and exports
- database/configuration backup and restore
- users, roles, authorization, and audit attribution
- licensing and entitlement
- historical analytics

## Farm and Production Domains

- biomass and cage master data
- growth models and observations
- FCR calculation and historical analysis
- mortality and harvest records
- recipe, job, feeding-program, and maintenance master data

## Commercial and Quality Domains

- inventory, purchasing, warehouse, and suppliers
- cost accounting
- quality inspections, laboratory records, CAPA, and traceability

## PLC Boundary

Desktop may configure and observe the PLC only through versioned interfaces. It does not own realtime equipment state machines.

PLC continues operating an already accepted healthy feeding job during Desktop communication loss. New remote transfers are blocked until communication and validation recover.

## Legacy Sources

Former PLC-style specifications are preserved in `03_Desktop/Legacy_Design`. They are non-authoritative input material and must not be implemented as PLC Function Blocks.
