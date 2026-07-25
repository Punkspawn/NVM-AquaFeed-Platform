# System Boundary

## Status

Authoritative

## Governing Decision

This document implements `AD-001 - Platform Architecture`.

## PLC — AquaCore

The PLC owns only deterministic, realtime machine operation:

- physical IO
- safety and operational interlocks
- equipment state machines
- selector, blower, and dosing control
- line coordination
- active mission execution
- bounded runtime counters
- active alarm conditions and alarm IDs
- recovery sequences
- Modbus TCP/RTU communication
- operation without the Desktop application

The PLC is not a database, historian, report engine, user-management service, ERP, or cloud platform.

## Desktop — AquaFeed Manager

The Desktop application owns:

- database persistence
- users, roles, permissions, and sessions
- job-order creation and scheduling
- recipes and business configuration
- cages, fish lots, feed lots, biomass, mortality, growth, and FCR
- historical alarms, events, missions, parameters, and calibration records
- reports, statistics, analytics, and cost calculations
- inventory, warehouse, purchasing, and suppliers
- backup and long-term archive
- user interface and service workflow

Desktop communication loss shall not stop a healthy feeding operation already controlled by the PLC.

## Integration / Edge

This optional layer owns:

- protocol translation
- store-and-forward buffering
- remote access gateway
- update delivery
- cloud synchronization
- external API and ERP integration

## Data Ownership

| Data | Authoritative owner |
|---|---|
| Physical input/output state | PLC |
| Active equipment and line state | PLC |
| Active mission execution state | PLC |
| Runtime counters exposed for synchronization | PLC |
| Current alarm condition and ID | PLC |
| Users and permissions | Desktop |
| Job-order master data | Desktop |
| Recipe master data | Desktop |
| Historical missions and alarms | Desktop |
| Reports and statistics | Desktop |
| Inventory and commercial records | Desktop |
| Cloud synchronization state | Integration / Edge |

## Enforcement Rule

Any document that assigns Desktop or Integration responsibilities to a PLC Function Block is classified as **MERGE** or **ARCHIVE**, even if its filename is located under a PLC directory.
