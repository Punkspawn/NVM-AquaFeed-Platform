# Current Physical Module Scope

| Field | Value |
|---|---|
| Status | Authoritative |
| Governing decision | AD-004 |
| Version | 1.0 |

## Current Release

| Module | Decision | Reason |
|---|---|---|
| Selector | IN SCOPE | Physical feed routing equipment |
| Blower | IN SCOPE | Pneumatic feed transport |
| Dosing | IN SCOPE | Feed quantity delivery |
| Generic Motion | EXCLUDED | Responsibilities already owned by concrete equipment blocks |
| CIP | FUTURE OPTION | No approved cleaning station, valves, chemicals, or instrumentation |
| Water | FUTURE OPTION | No approved intake/storage/filtration equipment or P&ID |
| Aeration | FUTURE OPTION | No approved aeration blower/manifold/valve scope |
| Oxygen | FUTURE OPTION | No approved DO sensor/control scope |

## Admission Gate for a Future Option

All of the following are required before a PLC module becomes active:

1. approved project requirement and owner
2. equipment schedule and process/control narrative
3. P&ID or mechanical flow definition where applicable
4. IO list, electrical drawings, power/control architecture, and fail-safe states
5. risk assessment and safety boundary
6. deterministic state machine and bounded integer units
7. versioned structures and interfaces
8. alarm/diagnostic catalog
9. FAT, SAT, commissioning, and recovery tests
10. Modbus allocation only when external publication is required

Until every gate is approved, optional documents remain archived and must not influence implementation.
