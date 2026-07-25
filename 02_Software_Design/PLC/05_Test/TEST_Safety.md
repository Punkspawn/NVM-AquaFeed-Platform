# TEST_Safety

| Field | Value |
|---|---|
| Status | Authoritative coordination test specification |
| Target | FB_SafetyCoordinator v1.1, E_SafetyCoordinationState, ST_SafetyStatus, IF_Safety v1.1 |

> Safety validation of E-stop, safety relay, STO, contactors, stopping time, PL/SIL, wiring, and fault exclusions requires the approved electrical safety plan and competent-person validation. These PLC tests do not certify a safety function.

| ID | Test | Expected result |
|---|---|---|
| SAF-001 | PLC startup with unknown feedback | all standard-control permits false |
| SAF-002 | Healthy validated feedback | permits follow mode/state policy |
| SAF-003 | E-stop circuit activates | permits false immediately; ResetRequired latched |
| SAF-004 | Safety relay unhealthy | permits false |
| SAF-005 | STO feedback contradiction | feedback fault; permits false |
| SAF-006 | Contactor feedback contradiction | feedback fault; permits false |
| SAF-007 | Physical circuit restored without reset | permits remain false |
| SAF-008 | Remote reset attempt | no command path; unchanged |
| SAF-009 | Local reset while equipment running | rejected |
| SAF-010 | Local reset with new sequence and stopped equipment | accepted; no output/start command |
| SAF-011 | Replay reset sequence | idempotent |
| SAF-012 | Communication/Desktop loss | cannot create safety permission |
| SAF-013 | Simulation/force request | prohibited; permits unchanged |
| SAF-014 | Power recovery | no automatic restart |
| SAF-015 | Simultaneous feedback faults | fail closed with deterministic code |
| SAF-016 | Healthy feedback after startup without local reset | ResetRequired; all permits false |
| SAF-017 | Valid reset while permit request high | rejected; all permits false |
| SAF-018 | Valid reset with permit request low | accepted one scan; HealthyStopped; every permit including Recovery false in the reset scan |
| SAF-019 | New permit request after accepted reset | HealthyPermitted; standard production permits true |
| SAF-020 | Permit request removed | HealthyStopped; production permits false |
| SAF-021 | Recovery permission | true only with clear safety gate and stopped equipment |
| SAF-022 | Missing/invalid feedback after prior healthy state | permits false immediately; ResetRequired latched |

## Separate Hardware Validation

Verify emergency-stop category, safety relay behavior, STO channels, contactor feedback, reset placement, restart prevention, fault insertion, stopping time, and required PL/SIL against the electrical design and risk assessment.
