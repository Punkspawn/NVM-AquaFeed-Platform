# Legacy Maintenance Management Interface

> **Status:** Legacy / Superseded  
> **Reason archived:** Mixed PLC threshold/reset behavior with Desktop authorization and history.  
> **Replacement:** `IF_MaintenanceCounter.md`

---

# IF_Maintenance

---

# Purpose

Defines the standard software interface for maintenance monitoring and service management.

This interface standardizes maintenance scheduling, service notifications and equipment health monitoring across all machine modules.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables maintenance monitoring. |
| RuntimeHours | DINT | Current accumulated runtime hours. |
| ServiceReset | BOOL | Resets the completed maintenance interval. |
| ServiceIntervalHours | DINT | Scheduled maintenance interval. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| ServiceRequired | BOOL | Maintenance interval has been reached. |
| RemainingHours | DINT | Remaining runtime before service is required. |
| OverdueHours | DINT | Runtime exceeding the service interval. |
| LastServiceHours | DINT | Runtime value at the last completed service. |
| MaintenanceActive | BOOL | Maintenance mode is currently active. |

---

# State Flow

```text
Normal Operation
        │
Runtime Accumulated
        │
Service Interval Reached
        │
Service Required
        │
Maintenance Completed
        │
Service Reset
        │
Normal Operation
```

---

# Rules

- `RemainingHours` shall never be negative.
- `OverdueHours` shall remain zero until the service interval is exceeded.
- `ServiceReset` shall only be performed by an authorized user.
- Service history shall not be deleted after a reset.
- Maintenance calculations shall execute once every PLC scan.

---

# Used By

- FB_MaintenanceManager
- FB_RuntimeManager
- FB_SystemManager
- HMI
- AquaFeed Manager
- Service Software