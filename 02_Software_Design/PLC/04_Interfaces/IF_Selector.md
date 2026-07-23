# IF_Selector

---

# Purpose

Defines the standard software interface for the Selector unit.

The Selector is responsible for positioning the outlet to the requested feeding line before the feeding process begins.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables the selector. |
| Home | BOOL | Moves the selector to the home position. |
| Move | BOOL | Starts positioning. |
| Reset | BOOL | Clears active faults. |
| TargetLine | UINT | Requested feeding line number. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | Selector is ready for movement. |
| Moving | BOOL | Selector is currently moving. |
| InPosition | BOOL | Target position reached. |
| Homed | BOOL | Home position confirmed. |
| Fault | BOOL | Selector fault detected. |
| CurrentLine | UINT | Current selector position. |
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
Move
    │
Moving
    │
InPosition
    │
Ready
```

Home sequence

```text
Any State
    │
Home
    │
Moving
    │
Homed
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

- Movement shall only begin when `Ready = TRUE`.
- `TargetLine` shall be within the configured line range.
- `InPosition` shall become TRUE only after position verification.
- `Moving` and `InPosition` shall never be TRUE simultaneously.
- `Fault` shall stop all movement immediately.
- `AlarmCode` shall be zero when no alarm is active.

---

# Used By

- FB_Selector
- FB_LineManager
- FB_FeedingControlManager
- HMI
- AquaFeed Manager