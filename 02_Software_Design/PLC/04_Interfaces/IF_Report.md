# IF_Report

---

# Purpose

Defines the standard software interface for report generation.

This interface provides a common mechanism for creating production, feeding, alarm, maintenance and runtime reports for the PLC, HMI and AquaFeed Manager.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables report generation. |
| Generate | BOOL | Generates the selected report. |
| Export | BOOL | Exports the generated report. |
| Reset | BOOL | Clears report status. |
| ReportType | UINT | Report type identifier. |
| DateFrom | DT | Report start date and time. |
| DateTo | DT | Report end date and time. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | Report system is ready. |
| Busy | BOOL | Report generation is in progress. |
| Completed | BOOL | Report generated successfully. |
| Exported | BOOL | Report exported successfully. |
| Fault | BOOL | Report generation failed. |
| ReportID | UDINT | Generated report identifier. |
| AlarmCode | UINT | Active report alarm code. |

---

# Report Types

| ID | Report |
|---:|--------|
| 1 | Feeding Report |
| 2 | Runtime Report |
| 3 | Alarm Report |
| 4 | Maintenance Report |
| 5 | Production Report |
| 6 | Job History Report |

---

# State Flow

```text
Idle
   │
Generate
   │
Generating
   │
Completed
   │
Export
   │
Exported
```

Fault sequence

```text
Generating
      │
Fault
      │
Reset
      │
Idle
```

---

# Rules

- Only one report generation task shall execute at a time.
- Export shall only be available after successful report generation.
- Report generation shall not interrupt machine operation.
- Generated reports shall remain available until deleted by the user.
- `AlarmCode` shall be zero when no reporting fault is active.

---

# Used By

- FB_ReportManager
- FB_RuntimeManager
- FB_AlarmManager
- FB_MaintenanceManager
- FB_JobManager
- HMI
- AquaFeed Manager