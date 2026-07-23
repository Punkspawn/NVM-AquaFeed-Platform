# IF_Runtime

---

# Purpose

Defines the standard software interface for runtime monitoring and production statistics.

All runtime calculations, operating hours and production counters shall be exposed through this interface for use by the PLC, HMI and AquaFeed Manager.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables runtime monitoring. |
| Running | BOOL | Machine is currently running. |
| Paused | BOOL | Machine is paused. |
| Fault | BOOL | Machine is in fault state. |
| CycleTimeMs | UINT | PLC scan time in milliseconds. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| TotalRuntimeSec | DINT | Total accumulated runtime. |
| ProductionRuntimeSec | DINT | Total production runtime. |
| IdleRuntimeSec | DINT | Total idle runtime. |
| PauseRuntimeSec | DINT | Total paused runtime. |
| FaultRuntimeSec | DINT | Total fault duration. |

---

# State Flow

```text
Power On
    │
Enable
    │
Runtime Monitoring
    │
Running
    │
Production Runtime
```

Pause sequence

```text
Running
    │
Paused
    │
Pause Runtime
    │
Running
```

Fault sequence

```text
Any State
    │
Fault
    │
Fault Runtime
    │
Ready
```

---

# Rules

- Runtime counters shall never decrease.
- Only one runtime state shall accumulate at any given time.
- `CycleTimeMs` shall be greater than zero.
- Counters shall survive PLC power cycles if configured for retentive memory.
- Runtime calculations shall execute once every PLC scan.

---

# Used By

- FB_RuntimeManager
- FB_FeedingControlManager
- FB_MaintenanceManager
- HMI
- AquaFeed Manager
- Reporting System