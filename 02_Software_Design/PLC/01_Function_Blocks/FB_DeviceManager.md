# FB_DeviceManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Common runtime state of one statically configured physical device |
| Version | 2.0 |

## Purpose

Converts one device's approved identity, mode requests, equipment feedback, common interlocks, and required communication state into one deterministic `ST_Device` snapshot.

Equipment-specific Function Blocks remain responsible for motion, VFD, dosing, timing, and physical outputs.

## Rules

- one instance owns one statically configured device snapshot
- DeviceId and DeviceType must be non-zero
- disabled or invalidly configured devices expose no operating mode and are unavailable
- simultaneous Auto and Manual requests select neither mode
- availability requires valid configuration, Enabled, InterlockOK, CommunicationOK, and no fault
- Running is accepted only while configuration, enable, interlock, communication, and fault conditions permit it
- incompatible running feedback publishes UnexpectedRunFeedback and fails the device closed
- Ready requires Available and exactly one selected mode
- the block has no reset, retained command, output command, asset registry, discovery, history, or firmware responsibility

## Diagnostic Priority

1. invalid configuration
2. disabled
3. mode conflict
4. equipment fault
5. interlock open
6. required communication lost
7. none

## Contracts

- structure: `ST_Device.md`
- interface: `IF_Device.md`
- tests: `TEST_Device.md`

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-24 | Initial device manager design. |
| 1.1 | 2026-07-25 | Excluded platform asset-registry responsibilities. |
| 2.0 | 2026-07-26 | Replaced draft/reset ambiguity with explicit deterministic common-device contract. |
