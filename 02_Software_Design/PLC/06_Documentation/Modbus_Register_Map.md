# AquaFeed Modbus TCP Register Map

| Field | Value |
|---|---|
| Status | Authoritative |
| Interface | AquaFeed Manager / HMI ↔ PLC |
| Protocol | Modbus TCP |
| PLC role | Server / Slave |
| Desktop and HMI role | Client / Master |
| Transport | TCP port 502 |
| Map version | 2.0 |
| Address notation | Zero-based PDU offset is authoritative |

## Address Notation

Every table uses zero-based Holding Register offsets.

Human-facing 4xxxx notation is:

```text
Display address = 40001 + zero-based offset
```

Example: offset 100 is display address 40101.

Client libraries that already expect zero-based offsets shall use the offset directly. Mixing the two conventions is prohibited.

## Supported Operations

- Function 03: Read Holding Registers
- Function 06: Write Single Register where explicitly allowed
- Function 16: Write Multiple Registers for atomic command/snapshot blocks

All undefined or read-only writes are rejected.

## Encoding Profile

| Type | Encoding |
|---|---|
| BOOL | one WORD: 0 or 1 |
| UINT / WORD / enum | one 16-bit register |
| UDINT | two registers, low word at lower offset |
| REAL | IEEE-754 32-bit, low word at lower offset |
| BYTE / USINT | one WORD; upper bits zero |
| Strings | prohibited in PLC realtime map |

Each register uses standard Modbus big-endian byte transmission. AquaFeed v1 uses **low 16-bit word first** for 32-bit PLC values. This Delta PLC word profile must be verified by an automated interoperability test before release.

## Stable Allocation

| Offset range | Size | Access | Purpose |
|---:|---:|---|---|
| 0–31 | 32 | R | Protocol header and PLC heartbeat |
| 32–47 | 16 | W | Desktop heartbeat and system command request |
| 48–63 | 16 | R | System command acknowledgement |
| 64–99 | 36 | — | Reserved |
| 100–159 | 60 | R | System status |
| 160–199 | 40 | — | Reserved |
| 200–219 | 20 | RW split | Execution transfer control/ack |
| 220–251 | 32 | W | ST_JobExecution candidate |
| 252–283 | 32 | W | ST_RecipeExecution candidate |
| 284–399 | 116 | — | Reserved |
| 400–431 | 32 | R | Alarm summary |
| 432–463 | 32 | W | Alarm acknowledge/reset command |
| 464–499 | 36 | R | Alarm command/event acknowledgement |
| 500–883 | 384 | R | 32 active alarm records × 12 words |
| 884–999 | 116 | — | Reserved |
| 1000–2023 | 1024 | R | 16 line blocks × 64 words |
| 2024–2199 | 176 | — | Reserved |
| 2200–2399 | 200 | R | Communication and PLC diagnostics |
| 2400–2463 | 64 | R | Global ST_Runtime lifetime counters |
| 2464–3103 | 640 | R | 32 maintenance counters × 20 words |
| 3104–3999 | 896 | — | Reserved for append-only expansion |

The current project uses lines 1–6. Blocks 7–16 remain reserved with identical layout.

## Protocol Header — Offset 0

| Offset | Type | Description |
|---:|---|---|
| 0 | WORD | Magic: 0x4E56 ("NV") |
| 1 | UINT | Map major version |
| 2 | UINT | Map minor version |
| 3 | UINT | Published map word count |
| 4–5 | UDINT | PLC heartbeat counter |
| 6–7 | UDINT | Last accepted Desktop heartbeat |
| 8 | WORD | Protocol status flags |
| 9 | UINT | Last protocol result/exception code |
| 10–15 | WORD[] | PLC software/build numeric identifiers |
| 16–31 | — | Reserved |

## Desktop Heartbeat and System Command — Offset 32

| Offset | Type | Description |
|---:|---|---|
| 32–33 | UDINT | Desktop heartbeat counter |
| 34–35 | UDINT | System command sequence |
| 36 | WORD | Command bit mask |
| 37 | USINT | Target line; zero means global |
| 38 | UINT | Command argument |
| 39 | UINT | Command payload CRC16 |
| 40–47 | — | Reserved |

Command-mask bits:

| Bit | Command |
|---:|---|
| 0 | Enable |
| 1 | Start |
| 2 | Stop |
| 3 | Pause |
| 4 | Reset |
| 5 | Automatic mode request |
| 6 | Manual mode request |
| 7 | Service mode request |
| 8 | Simulation mode request |
| 9 | Cancel active line job |

PLC never clears Desktop-owned request registers. Desktop changes the sequence for each new command; PLC echoes the accepted/rejected sequence in offsets 48–50.

## System Command Acknowledgement — Offset 48

| Offset | Type | Description |
|---:|---|---|
| 48–49 | UDINT | Last processed system command sequence |
| 50 | UINT | Result code |
| 51 | WORD | Accepted command mask |
| 52 | WORD | Rejected command mask |
| 53–63 | — | Reserved |

## System Status — Offset 100

| Offset | Type | ST_SystemStatus field |
|---:|---|---|
| 100 | E_SystemState | SystemState |
| 101 | WORD | Ready/Running/Paused/Stopped flags |
| 102 | WORD | Auto/Manual/Service/Simulation/ModeConflict flags |
| 103 | WORD | SafetyOK/Emergency/BlockingFault/AlarmActive flags |
| 104 | WORD | DesktopCommunicationOK/LinesReady/AnyLineRunning/Feeding flags |
| 105 | USINT | CurrentLine |
| 106 | UINT | ActiveRecipeId |
| 107–108 | UDINT | CurrentJobId |
| 109 | UINT | Active alarm count |
| 110 | E_AlarmSeverity | Highest active alarm severity |
| 111–159 | — | Reserved |

## Execution Transfer — Offset 200

Control and acknowledgement:

| Offset | Access | Type | Description |
|---:|---|---|---|
| 200–201 | W | UDINT | TransferSequence |
| 202 | W | BOOL | TransferRequest |
| 203 | W | UINT | Combined payload CRC16 |
| 204–205 | R | UDINT | Last processed sequence |
| 206 | R | UINT | Transfer result code |
| 207 | R | BOOL | Accepted event |
| 208 | R | BOOL | Rejected event |
| 209 | R | BOOL | PLC ready for new transfer |
| 210–219 | — | — | Reserved |

`ST_JobExecution` occupies offsets 220–251.  
`ST_RecipeExecution` occupies offsets 252–283.

The exact field offsets follow their document order. Unused words in each 32-word block are reserved and written as zero. Job and Recipe are accepted atomically through `IF_ExecutionTransfer`.

## Alarm Area

### Summary — Offset 400

| Offset | Type | Description |
|---:|---|---|
| 400 | UINT | Active alarm count |
| 401 | E_AlarmSeverity | Highest severity |
| 402 | WORD | AnyActive/AnyBlocking/AnyCritical/AnyEmergency flags |
| 403 | BOOL | Active table overflow |
| 404 | BOOL | Event buffer overflow |
| 405–406 | UDINT | Latest alarm event sequence |
| 407–431 | — | Reserved |

### Lifecycle command — Offset 432

| Offset | Type | Description |
|---:|---|---|
| 432–433 | UDINT | Command sequence |
| 434 | WORD | Command: 1=Acknowledge, 2=Reset |
| 435 | UINT | AlarmCode |
| 436 | E_AlarmSource | Source |
| 437 | USINT | LineId |
| 438 | UINT | DeviceId |
| 439 | UINT | Payload CRC16 |
| 440–463 | — | Reserved |

### Active alarm table — Offset 500

- 32 fixed records
- 12 words per record
- record base = 500 + (index × 12), index 0–31
- field order follows `ST_Alarm`
- empty record has AlarmCode = 0
- table is read-only to Desktop

Permanent history is not mapped; Desktop persists lifecycle events.

## Line Blocks — Offset 1000

- 16 fixed blocks
- 64 words per line
- line base = 1000 + ((LineId - 1) × 64)

| Relative offset | Type | ST_Line field |
|---:|---|---|
| 0 | USINT | LineId |
| 1 | E_LineState | LineState |
| 2 | WORD | Enabled/Ready/Busy/Running/Paused/Completed/Fault/Emergency |
| 3 | WORD | Auto/Manual/Service/Simulation |
| 4 | BOOL | ActiveJobValid |
| 5–6 | UDINT | ActiveJobId |
| 7 | UINT | ActiveRecipeId |
| 8 | USINT | TargetSelectorPosition |
| 9 | USINT | CurrentSelectorPosition |
| 10 | BOOL | SelectorAtTarget |
| 11–12 | UDINT | TargetFeedCentiKg; 0.01 kg/count |
| 13–14 | UDINT | DeliveredFeedCentiKg; 0.01 kg/count |
| 15–16 | UDINT | RemainingFeedCentiKg; 0.01 kg/count |
| 17 | UINT | ProgressPermille; 0–1000 |
| 18 | — | Reserved |
| 19–20 | UDINT | ElapsedTimeSec |
| 21–22 | UDINT | RemainingTimeSec |
| 23 | WORD | Blower/Dosing1/Dosing2 running flags |
| 24 | UINT | ActiveAlarmId |
| 25–63 | — | Reserved |

## Runtime — Offset 2400

| Offset | Type | ST_Runtime field |
|---:|---|---|
| 2400–2401 | UDINT | TotalPoweredSec |
| 2402–2403 | UDINT | TotalReadyIdleSec |
| 2404–2405 | UDINT | TotalFeedingSec |
| 2406–2407 | UDINT | TotalPausedSec |
| 2408–2409 | UDINT | TotalFaultSec |
| 2410–2411 | UDINT | TotalServiceSec |
| 2412–2413 | UDINT | TotalFeedCentiKg |
| 2414–2415 | UDINT | CompletedJobCount |
| 2416–2417 | UDINT | MachineStartCount |
| 2418–2419 | UDINT | EmergencyStopCount |
| 2420–2421 | UDINT | AlarmOccurrenceCount |
| 2422–2463 | — | Reserved |

## Maintenance Counters — Offset 2464

- 32 fixed device/scope blocks
- 20 words per block
- base = 2464 + (index × 20), index 0–31
- field order follows ST_MaintenanceCounter
- unused record has DeviceId = 0
- records are read-only; reset/configuration uses IF_MaintenanceCounter command/ack mapping added in reserved command space during implementation review

## Diagnostics — Offset 2200

| Offset | Type | Field |
|---:|---|---|
| 2200 | WORD bitfield | Ready, Degraded, Fault, WatchdogHealthy, ConfigurationValid |
| 2201 | UINT | HighestSeverity |
| 2202 | UINT | ActiveDiagnosticCount |
| 2203 | UINT | ActiveAlarmCount |
| 2204 | UINT | InvalidDigitalCount |
| 2205 | UINT | InvalidAnalogCount |
| 2206 | UINT | OutputMismatchCount |
| 2207 | UINT | OfflineChannelCount |
| 2208 | UINT | LastDiagnosticCode |
| 2209 | — | Reserved |
| 2210–2211 | UDINT | ScanTimeUs |
| 2212–2213 | UDINT | MaxScanTimeUs |
| 2214–2215 | UDINT | ScanOverrunCount |
| 2216–2217 | UDINT | DiagnosticOccurrenceCount |

## Communication Channel Summaries — Offset 2218

- 16 fixed channel slots
- 11 words per slot
- base = 2218 + (index × 11), index 0–15
- unused slot has ChannelId = 0

| Relative word | Type | Field |
|---:|---|---|
| 0 | WORD bitfield | Enabled, RequiredForControl, Ready, Fresh, Fault |
| 1 | UINT | ChannelId |
| 2 | UINT | ProfileId |
| 3 | WORD | ChannelType and State |
| 4–5 | UDINT | LastAcceptedSequence |
| 6–7 | UDINT | RxCount |
| 8–9 | UDINT | ErrorCount |
| 10 | UINT | DiagnosticCode |

| Offset | Use |
|---:|---|
| 2218–2393 | 16 communication channel summaries |
| 2394–2399 | Reserved |

These are explicit wire layouts; they are not implicit compiler serializations of `ST_Diagnostics` or `ST_CommunicationChannel`.

## Write Validation

Every Desktop write is validated for:

- supported map and snapshot version
- allowed address and access direction
- monotonic sequence
- valid CRC
- complete multi-register payload
- numeric bounds and enum membership
- target scope compatibility
- current machine state and permission
- idempotent replay behavior

Invalid writes change no active PLC state and return a bounded result code.

## Version 2 Migration

Map major version 2 replaces the former REAL line quantity/progress fields with bounded integer units matching Selector, Blower, and Dosing contracts. Version 1 clients remain read-only and must not reinterpret these words. Execution snapshot fields also use centi-kilograms, permille, and centi-Hz.

## Compatibility Rules

- never change meaning or encoding of an allocated offset within a major version
- append using Reserved words
- never reuse removed offsets
- increment major version for incompatible change
- Desktop checks magic and version before enabling writes
- unsupported major version is read-only diagnostic mode
