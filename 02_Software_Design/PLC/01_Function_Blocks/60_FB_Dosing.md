# FB_Dosing

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Deliver one bounded target quantity from the accepted recipe snapshot |
| Version | 3.1 |

## State Machine

`Disabled → Ready → Starting → WaitFirstPulse → Dosing → Stopping → Complete → Ready`; any blocking condition enters `Fault`.

## Quantity Model

- target and delivered quantities use centi-kilograms
- calibration uses integer centi-kilograms per 1000 validated pulses
- pulse accumulation and multiplication use guarded wide intermediate arithmetic
- completion uses the approved stop threshold and tolerance without floating-point equality
- delivered quantity is monotonic within one accepted dosing transaction

## Behavior

- start only with valid recipe snapshot, selector confirmed at the latched outlet, blower AtSpeed, feed available, valid calibration, and safety permission
- latch target, rate, calibration version, outlet, job identity, and command sequence at acceptance
- reject parameter changes during execution
- require motor/drive feedback and first pulse within configured time
- detect no-flow, unexpected pulses while stopped, excessive rate, target timeout, counter saturation, interlock loss, and feedback mismatch
- remove dosing output immediately on selector, blower, safety, drive, or feed-availability loss
- emit Complete as a one-scan event only after output is stopped and final delivered quantity is frozen
- normal stop or fault never reports successful completion
- publish validated delivered increments to the runtime counter; Desktop owns history and analytics

## Implementation Inputs

The importable implementation uses `ST_DosingConfig` and the monotonic millisecond tick for bounded quantity, calibration, speed, tolerance, rate, and timeout checks. Fault reset uses an idempotent reset sequence and cannot start a transaction.

Pulse conversion avoids a wide multiplication by accumulating the integer quotient and remainder of centi-kilograms per 1000 pulses. Overflow is checked before addition; delivered quantity never wraps.

## Contracts

- state: `E_DosingState.md`
- interface: `IF_Dosing.md`
- verification: `TEST_Dosing.md`
