# IF_Dosing

---

# Purpose

Defines the standard software interface for the Dosing unit.

The Dosing unit controls the feed delivery rate according to the active recipe. It shall operate only when the blower is ready and the selector is confirmed in position.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables the dosing unit. |
| Start | BOOL | Starts feed dosing. |
| Stop | BOOL | Stops feed dosing. |
| Reset | BOOL | Clears active faults. |
| SpeedSetpoint | REAL | Requested dosing speed (%). |
| FeedTargetKg | REAL | Target feed amount (kg). |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | Dosing unit is ready. |
| Running | BOOL | Feed dosing is active. |
| Completed | BOOL | Target feed amount reached. |
| Fault | BOOL | Dosing fault detected. |
| ActualSpeed | REAL | Actual dosing speed (%). |
| FeedDeliveredKg | REAL | Total delivered feed (kg). |
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
Completed
    │
Ready
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

- Dosing shall not start unless:
  - `Blower.AtSpeed = TRUE`
  - `Selector.InPosition = TRUE`
  - `Ready = TRUE`
- `FeedDeliveredKg` shall increase only while `Running = TRUE`.
- `Completed` shall become TRUE when `FeedTargetKg` is reached.
- `Fault` shall immediately stop feed dosing.
- `AlarmCode` shall be zero when no alarm is active.

---

# Used By

- FB_Dosing
- FB_FeedingControlManager
- FB_RecipeManager
- FB_RuntimeManager
- HMI
- AquaFeed Manager