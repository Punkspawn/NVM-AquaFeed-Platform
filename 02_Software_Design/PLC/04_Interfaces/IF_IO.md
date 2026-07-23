# IF_IO

---

# Purpose

Defines the standard software interface for all physical digital and analog inputs/outputs.

This interface provides a unified abstraction layer between the PLC application and the machine hardware, allowing higher-level Function Blocks to interact with I/O independently of the PLC hardware configuration.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables I/O processing. |
| Refresh | BOOL | Updates all I/O values. |
| Reset | BOOL | Clears I/O communication faults. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | I/O system is operational. |
| DI_Updated | BOOL | Digital inputs have been refreshed. |
| AI_Updated | BOOL | Analog inputs have been refreshed. |
| DO_Updated | BOOL | Digital outputs have been written. |
| AO_Updated | BOOL | Analog outputs have been written. |
| Fault | BOOL | I/O system fault detected. |
| AlarmCode | UINT | Active I/O alarm code. |

---

# Managed Signals

## Digital Inputs

- Emergency Stop
- Start Button
- Stop Button
- Reset Button
- Selector Home Sensor
- Selector Position Sensors
- Motor Protection Contacts
- Safety Inputs

---

## Digital Outputs

- Blower Run
- Dosing Run
- Selector Left
- Selector Right
- Alarm Buzzer
- Warning Lamp
- Status Lamp

---

## Analog Inputs

- Drive Feedback
- Current Measurement
- Pressure Sensor
- Temperature Sensor

---

## Analog Outputs

- Blower Speed Reference
- Dosing Speed Reference

---

# State Flow

```text
Power On
    │
Enable
    │
Initialize I/O
    │
Ready
    │
Refresh Cycle
```

Fault sequence

```text
Ready
   │
I/O Fault
   │
Fault
   │
Reset
   │
Ready
```

---

# Rules

- Physical I/O mapping shall only be performed in the I/O Manager.
- Application Function Blocks shall never access physical addresses directly.
- All outputs shall assume a safe state during a fault condition.
- I/O refresh shall execute once every PLC scan.
- `AlarmCode` shall be zero when no I/O fault is active.

---

# Used By

- FB_IOManager
- FB_SystemManager
- FB_LineManager
- FB_Selector
- FB_Blower
- FB_Dosing
- FB_FeedingControlManager
- HMI
- AquaFeed Manager