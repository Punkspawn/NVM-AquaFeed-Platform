# FB_MaintenanceCounter

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Runtime-based service threshold and reset baseline |
| Version | 1.0 |

## Purpose

Calculates due and overdue state for one maintained device using its retentive lifetime runtime.

## Reset Acceptance

A reset is accepted only when:

- reset sequence is new
- device/scope identity matches
- maintenance monitoring is enabled
- approved Service mode or commissioning permission is active
- equipment is stopped and safe
- configured interval is valid

On acceptance:

- RuntimeAtLastServiceSec := LifetimeRuntimeSec
- LastAcceptedResetSequence := request sequence
- ResetCount increments with saturation
- one reset-accepted event is published

It never clears LifetimeRuntimeSec and never stores the technician/user.
