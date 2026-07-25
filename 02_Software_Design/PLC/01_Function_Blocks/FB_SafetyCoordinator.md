# FB_SafetyCoordinator

| Field | Value |
|---|---|
| Status | Authoritative standard-PLC coordination |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Mirror validated safety-circuit status and inhibit standard PLC commands |
| Version | 1.0 |

## Safety Boundary

This block is not a safety function, safety PLC, safety relay, STO controller, or substitute for risk assessment and validated hardwired safety architecture.

Emergency stop, STO, contactor removal, and other safety-rated actions are performed by approved safety hardware. The standard PLC observes feedback only.

## Behavior

- consume validated safety relay/E-stop/STO/contactor feedback
- default all standard-control permits false at startup or invalid feedback
- remove motion, blower, dosing, and automatic-start permissions immediately when the observed safety chain is unhealthy
- latch `xResetRequired` after a safety trip
- require physical circuit restoration, local acknowledgement, stopped equipment, and a new reset sequence
- reset never energizes equipment and never restarts a job
- contradictory or stale safety feedback is treated as unsafe
- bypass, force, simulation, remote reset, and software masking of safety inputs are prohibited

## Outputs

Publishes `ST_SafetyStatus` and permission bits consumed by SystemManager, LineManager, equipment blocks, IO Manager, and RecoveryManager.
