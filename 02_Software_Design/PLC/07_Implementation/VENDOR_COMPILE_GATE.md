# Vendor Compile Gate

| Field | Value |
|---|---|
| Status | Required before cyclic instance wiring |
| Target baseline | Delta DVP-SV3 / ISPSoft |
| Language | IEC 61131-3 Structured Text |
| Scope | Current reviewed PLC implementation only |
| Version | 1.0 |

## Purpose

This gate converts the reviewed vendor-neutral sources into evidence from the target PLC toolchain without inventing physical IO, timing, or equipment parameters.

Passing this document permits one-line bench composition. It does not authorize field energization.

## Exact Import Order

| Order | Source | Requires |
|---:|---|---|
| 1 | `Types/AquaFeed_CoreTypes.st` | standard IEC scalar types |
| 2 | `Globals/GVL_AquaFeed.st` | imported core types |
| 3 | `Functions/F_ElapsedMs.st` | UDINT arithmetic |
| 4 | `Functions/F_CyclicDistance.st` | UDINT arithmetic |
| 5 | `Function_Blocks/FB_TimeService.st` | `ST_TimeService` |
| 6 | `Function_Blocks/FB_IOManager.st` | `ST_IO` |
| 7 | `Function_Blocks/FB_SafetyCoordinator.st` | safety coordination state and status types |
| 8 | `Function_Blocks/FB_AlarmManager.st` | Alarm types and fixed alarm capacities |
| 9 | `Function_Blocks/FB_DiagnosticsManager.st` | `ST_Diagnostics`, `ST_IO` |
| 10 | `Function_Blocks/FB_DeviceManager.st` | `ST_Device` |
| 11 | `Function_Blocks/FB_CommunicationManager.st` | communication channel type and `F_ElapsedMs` |
| 12 | `Function_Blocks/FB_HealthMonitor.st` | `ST_HealthStatus` |
| 13 | `Function_Blocks/FB_Selector.st` | Selector types, `F_ElapsedMs`, `F_CyclicDistance` |
| 14 | `Function_Blocks/FB_Blower.st` | Blower types, `F_ElapsedMs` |
| 15 | `Function_Blocks/FB_Dosing.st` | Dosing types, `F_ElapsedMs` |
| 16 | `Function_Blocks/FB_LineManager.st` | Line/job/recipe types, `F_ElapsedMs` |
| 17 | `Function_Blocks/FB_RecoveryManager.st` | recovery checkpoint/status, job, recipe, and recovery state types |
| 18 | `Function_Blocks/FB_SystemManager.st` | `E_SystemState`, `ST_SystemStatus` |
| 19 | `Programs/PRG_AquaFeedMain.st` | imported globals |

Do not import archived or documentation-only PLC drafts into the vendor project.

## Gate A — Source Import

Pass only when:

- all nineteen sources import in the listed order
- no duplicate type, Function, Function Block, Program, or global symbol exists
- the vendor project retains the intended unsigned widths (`USINT`, `UINT`, `UDINT`)
- no automatic conversion introduces `REAL`
- no source is silently rewritten without review

Record every vendor diagnostic exactly as shown; do not guess a correction from the error number alone.

## Gate B — Isolated Compile

Compile in this order:

1. Types, globals, and both Functions
2. `FB_TimeService`
3. `FB_IOManager`
4. `FB_SafetyCoordinator`
5. `FB_AlarmManager`
6. `FB_DiagnosticsManager`
7. `FB_DeviceManager`
8. `FB_CommunicationManager`
9. `FB_HealthMonitor`
10. `FB_Selector`
11. `FB_Blower`
12. `FB_Dosing`
13. `FB_LineManager`
14. `FB_RecoveryManager`
15. `FB_SystemManager`
16. `PRG_AquaFeedMain`

Acceptance:

- zero compile errors
- every warning reviewed and classified
- no narrowed integer conversion without an explicit proven bound
- no replacement of wrap-safe UDINT timing with signed or wall-clock timing

## Vendor Syntax Points to Verify

These are checks, not assumed incompatibilities:

- explicit enum numeric values
- structure and array declarations
- declaration initializers using `:=`
- `VAR_IN_OUT` structure parameters
- named Function arguments
- `ABS` with `DINT`
- `UDINT_TO_UINT` and `UINT_TO_DINT`
- unsigned subtraction and multiplication behavior
- `DT` support used by observational UTC status

If ISPSoft requires a syntax-only adaptation, preserve behavior and update the repository source through a focused PR. Do not maintain a separate untracked vendor copy.

## Gate C — One-Line Bench Composition

The repository now contains a compile-safe one-line shell in `PRG_AquaFeedMain.st`. Its configuration remains zero, safety feedback invalid, Emergency active, equipment disabled, and physical-output permission hard FALSE.

First prove the shell imports, executes repeatedly, and applies no output. Begin parameterized bench work only after Gates A and B pass.

Required approved inputs:

- PLC task period and monotonic millisecond tick source
- one line's physical IO channel map, polarity, validity, and safe value
- Selector travel mode, outlet count, limits, home behavior, and timeouts
- Blower C2000 Plus communication profile, frequency limits, feedback, and stop policy
- Dosing pulse scale, target bounds, first-pulse/no-flow/rate limits, and interlocks
- Line target/timing bounds and equipment assignment

Compose one disabled line first. Enable logic only after the safe output image is verified at the terminal level.

## Gate D — Six-Line Composition

Begin only after the one-line bench sequence passes its authoritative tests.

Verify:

- six LineManager instances
- six Selector instances
- six Blower instances
- twelve Dosing instances
- unique IO channels and Modbus addresses
- no shared mutable job or recipe buffer
- bounded scan time with all instances active
- one line fault does not stop another unless an approved shared condition requires it

## Gate E — Hardware Commissioning

Requires approved electrical safety and commissioning documents. Software compilation alone never authorizes motor, valve, selector, blower, or dosing energization.

Minimum evidence:

- hardwired emergency and safety-chain validation
- output-by-output terminal check with loads isolated
- motor/VFD direction and frequency-limit verification
- Selector position verification
- Dosing pulse and quantity calibration
- controlled stop, fault, emergency, power-cycle, and communication-loss tests

## Evidence Record

| Item | Result / reference |
|---|---|
| ISPSoft version | |
| PLC CPU and firmware | |
| Imported commit SHA | |
| Gate A result | |
| Gate B result | |
| Warning list | |
| Syntax adaptation PR | |
| One-line bench test record | |
| Six-line scan-time record | |
| Commissioning approval | |

## Stop Conditions

Stop the integration and return to a focused repository change when:

- the vendor compiler changes a data width or arithmetic meaning
- an IO channel, polarity, safe state, time base, scale, or equipment assignment is unknown
- a requested workaround bypasses safety, replay protection, bounds, or immutable accepted snapshots
- the compiled vendor project differs from the tracked source without an auditable PR
