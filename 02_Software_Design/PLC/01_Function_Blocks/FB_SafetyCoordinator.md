# FB_SafetyCoordinator

| Field | Value |
|---|---|
| Status | Authoritative standard-PLC coordination |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Mirror validated safety-circuit status and inhibit standard PLC commands |
| Version | 1.1 |

## Safety Boundary

This block is not a safety function, safety PLC, safety relay, STO controller, or substitute for risk assessment and validated hardwired safety architecture.

Emergency stop, STO, contactor removal, and other safety-rated actions are performed by approved safety hardware. The standard PLC observes feedback only.

## Behavior

- consume validated safety relay/E-stop/STO/contactor feedback
- default all standard-control permits false at startup or invalid feedback
- remove motion, blower, dosing, and automatic-start permissions immediately when the observed safety chain is unhealthy
- latch `xResetRequired` after a safety trip
- require physical circuit restoration, local acknowledgement, stopped equipment, a new reset sequence, and a false standard-control permit request
- reset never energizes equipment and never restarts a job; a later permit request is required
- contradictory or stale safety feedback is treated as unsafe
- bypass, force, simulation, remote reset, and software masking of safety inputs are prohibited

## Outputs

Publishes `ST_SafetyStatus` and permission bits consumed by SystemManager, LineManager, equipment blocks, IO Manager, and RecoveryManager.

## Deterministic State Policy

| Condition | State | Permits |
|---|---|---|
| feedback invalid/stale | SafetyUnknown | all false |
| emergency active or safety relay unhealthy | SafetyTripActive | all false |
| STO or contactor plausibility unhealthy | SafetyFeedbackFault | all false |
| physical feedback restored, reset still required | SafetyResetRequired | all false |
| reset cleared, no standard-control request | SafetyHealthyStopped | Recovery only, while equipment stopped |
| reset cleared and standard-control request active | SafetyHealthyPermitted | Automatic/Motion/Blower/Dosing true; Recovery false unless equipment stopped |

## Current Implementation Baseline

The current release implements the fail-closed standard-PLC coordinator in `07_Implementation/Function_Blocks/FB_SafetyCoordinator.st`.

- ResetRequired is true at startup and latches on unknown, trip, or implausible feedback.
- reset commands are idempotent by sequence; replay emits no second result
- rejected reset diagnostics are bounded and never change hardware state
- every permit is recalculated false-first each scan
- reset acceptance keeps every permit false for that scan
- production permits require a later explicit standard-control request
- Recovery permission additionally requires stopped equipment
- no remote reset, bypass, force, simulation, safety relay command, STO command, or contactor command exists

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-25 | Defined standard-PLC safety observation and inhibit ownership. |
| 1.1 | 2026-07-26 | Closed the permit-request boundary and prohibited reset-to-permit in the same scan. |
