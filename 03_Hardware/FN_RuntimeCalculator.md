# FN_RuntimeCalculator

---

# Purpose

Calculates and updates machine runtime statistics.

This function is responsible for accumulating production time, idle time, pause time, equipment runtime and production counters.

It shall be executed once every PLC scan.

---

# Function

```iecst
FUNCTION FN_RuntimeCalculator : ST_Runtime

VAR_INPUT

    Runtime         : ST_Runtime;

    SystemStatus    : ST_SystemStatus;

    CycleTimeMs     : UINT;

END_VAR

VAR

    Result : ST_Runtime;

END_VAR

Result := Runtime;

(* Total Runtime *)

Result.TotalRuntimeSec :=
Result.TotalRuntimeSec + (CycleTimeMs / 1000);

(* Production Runtime *)

IF SystemStatus.SystemRunning THEN

    Result.TotalProductionTimeSec :=
    Result.TotalProductionTimeSec + (CycleTimeMs / 1000);

END_IF;

(* Idle Runtime *)

IF SystemStatus.SystemReady
AND NOT SystemStatus.SystemRunning THEN

    Result.TotalIdleTimeSec :=
    Result.TotalIdleTimeSec + (CycleTimeMs / 1000);

END_IF;

(* Pause Runtime *)

IF SystemStatus.SystemPaused THEN

    Result.TotalPauseTimeSec :=
    Result.TotalPauseTimeSec + (CycleTimeMs / 1000);

END_IF;

FN_RuntimeCalculator := Result;
```

---

# Inputs

Runtime

Current runtime statistics.

---

SystemStatus

Current machine status.

---

CycleTimeMs

PLC scan time in milliseconds.

---

# Output

Returns updated runtime statistics.

---

# Updates

The function updates

- Total Runtime
- Production Runtime
- Idle Runtime
- Pause Runtime

---

# Example

```iecst
g_Runtime :=
FN_RuntimeCalculator(

    Runtime := g_Runtime,

    SystemStatus := g_SystemStatus,

    CycleTimeMs := 100

);
```

---

# Used By

- FB_RuntimeManager
- FB_SystemManager
- Dashboard
- Reports
- Maintenance Manager

---

# Rules

The function shall never decrease runtime values.

CycleTimeMs shall be greater than zero.

The function shall execute once every PLC scan.

The function contains no side effects.

---

# Future Extensions

Future versions may additionally calculate

- OEE
- Machine Availability
- Feeding Efficiency
- Average Cycle Time
- Average Feed Rate
- Daily Production
- Weekly Statistics
- Monthly Statistics

These additions shall preserve the existing function interface.