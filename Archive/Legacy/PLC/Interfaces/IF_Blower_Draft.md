# IF_Blower

---

# Purpose

Defines the standard software interface for the Blower unit.

The Blower provides the airflow required to transport feed through the selected pipeline. It shall reach the configured operating speed before dosing is permitted to start.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables the blower. |
| Start | BOOL | Starts the blower. |
| Stop | BOOL | Stops the blower. |
| Reset | BOOL | Clears active faults. |
| SpeedSetpoint | REAL | Requested blower speed (%). |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | Blower is ready to start. |
| Running | BOOL | Blower is running. |
| AtSpeed | BOOL | Requested speed has been reached. |
| Fault | BOOL | Blower fault detected. |
| ActualSpeed | REAL | Actual blower speed (%). |
| AlarmCode | UINT | Active alarm code. |

---

# State Flow

```text
Disabled
    │
Enable
    │
Ready
    │
Start
    │
Running
    │
AtSpeed
```

Stop sequence

```text
Running
    │
Stop
    │
Ready
```

Fault sequence

```text
Any State
    │
Fault
    │
Reset
    │
Ready
```

---

# Rules

- The blower shall not start unless `Enable = TRUE`.
- `AtSpeed` shall only become TRUE after the requested speed is reached.
- Feed dosing shall not begin unless `AtSpeed = TRUE`.
- `Fault` shall immediately stop blower operation.
- `AlarmCode` shall be zero when no alarm is active.

---

# Used By

- FB_Blower
- FB_FeedingControlManager
- FB_RuntimeManager
- HMI
- AquaFeed Manager