# TEST_SystemIntegration

| Field | Value |
|---|---|
| Status | Authoritative integration gate |
| Target | Fail-closed one-line cyclic shell, then approved one-line bench |
| Version | 2.0 |

## Stage A — Compile-Safe Shell

The repository shell uses zero configuration, invalid safety feedback, Emergency active, disabled equipment, and hard FALSE physical-output permission.

| ID | Test | Expected result |
|---|---|---|
| INT-001 | Import all 19 sources | zero vendor compile errors |
| INT-002 | Execute shell after cold start | no physical output request applied |
| INT-003 | Execute shell after warm start | no physical output request applied |
| INT-004 | Scan sequence increments | saturates; never wraps |
| INT-005 | Safety feedback unmapped | all standard-control permissions false |
| INT-006 | IO configuration unmapped | IO not ready; applied image remains safe |
| INT-007 | Communication transport unmapped | channel disabled/not fresh |
| INT-008 | Line configuration zero | line cannot accept/start a job |
| INT-009 | Selector configuration zero | no movement request |
| INT-010 | Blower configuration zero | no VFD run request |
| INT-011 | Dosing configuration zero | no motor run request |
| INT-012 | System shell | disabled/emergency-safe lifecycle |
| INT-013 | Recovery checkpoint absent | no resume acceptance |
| INT-014 | Repeated 10,000 scans | deterministic state; no counter wrap |

## Stage B — Approved One-Line Bench

Begin only after vendor compilation passes and line-1 IO, polarity, safe values, timebase, safety observations, Selector, Blower, Dosing, and communication profiles are approved.

| ID | Test | Expected result |
|---|---|---|
| INT-101 | Safe input acquisition | immutable validated input snapshot |
| INT-102 | Hardwired safety open | output permission removed immediately |
| INT-103 | Local safety reset sequence | no restart on reset scan |
| INT-104 | One valid immutable job | accepted once |
| INT-105 | Selector positioning | target reached within bounded timeout |
| INT-106 | Blower start/stable speed | dosing permission only after stable feedback |
| INT-107 | Selected Dosing transaction | bounded delivered quantity and completion |
| INT-108 | Controlled stop | dosing stops before bounded blower post-run |
| INT-109 | Required feedback loss | owning equipment and line fail closed |
| INT-110 | Desktop heartbeat loss during accepted healthy job | new transfers blocked; policy-controlled current execution |
| INT-111 | Emergency during feeding | all standard-control requests removed |
| INT-112 | Power-return checkpoint | no automatic resume |
| INT-113 | Operator-approved recovery | explicit reinitialization and Line acceptance required |
| INT-114 | One-line endurance | stable scan time and no unbounded queue growth |

## Stop Conditions

Stop bench work on any unexpected output, contradictory feedback, unsigned narrowing, vendor warning not classified, safety bypass, automatic restart, or scan-time budget violation.

Desktop history, reports, users, scheduling, cloud, and business workflow are outside this PLC integration gate.

## Revision History

| Version | Date | Description |
|---|---|
| 1.0 | Legacy broad platform integration draft. |
| 2.0 | 2026-07-26 fail-closed shell and approved one-line bench gates. |
