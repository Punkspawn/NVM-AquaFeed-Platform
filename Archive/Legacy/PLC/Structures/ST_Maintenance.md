# Legacy Mixed Maintenance Structure

> **Status:** Legacy / Superseded  
> **Reason archived:** Mixed PLC counters with Desktop dates, users, notes, plans, and history.  
> **Replacements:** `ST_MaintenanceCounter.md` and `03_Desktop/Domain/Maintenance.md`

---

# ST_Maintenance

---

# Purpose

Represents maintenance information for a machine or device.

This structure is used to schedule preventive maintenance, record maintenance history, and monitor service intervals.

---

# Structure

```iecst
TYPE ST_Maintenance :
STRUCT

    DeviceId                : UINT;

    MaintenanceId           : UINT;

    Enabled                 : BOOL;

    RuntimeHours            : REAL;

    ServiceIntervalHours    : REAL;

    RemainingHours          : REAL;

    NextServiceHours        : REAL;

    ServiceRequired         : BOOL;

    ServiceOverdue          : BOOL;

    LastServiceDate         : DT;

    NextServiceDate         : DT;

    LastServiceUser         : UINT;

    ResetCounter            : UDINT;

    Notes                   : STRING[100];

END_STRUCT
END_TYPE
```

---

# Updated By

FB_MaintenanceManager

Desktop Application

---

# Read By

Dashboard

Maintenance Screen

Reports

Diagnostics

---

# Description

DeviceId

Unique equipment identifier.

Examples

- Blower
- Selector
- Dosing Motor
- Conveyor
- Compressor

---

MaintenanceId

Maintenance record identifier.

---

Enabled

Maintenance monitoring enabled.

---

RuntimeHours

Accumulated operating hours.

---

ServiceIntervalHours

Configured maintenance interval.

Example

250 Hours

500 Hours

1000 Hours

---

RemainingHours

Hours remaining until next maintenance.

---

NextServiceHours

Target runtime for next maintenance.

---

ServiceRequired

Maintenance is due.

---

ServiceOverdue

Maintenance interval exceeded.

---

LastServiceDate

Date of last completed maintenance.

---

NextServiceDate

Planned maintenance date.

---

LastServiceUser

Operator or technician ID.

---

ResetCounter

Number of maintenance resets performed.

---

Notes

Optional maintenance remarks.

---

# Rules

RemainingHours shall never be negative.

RuntimeHours shall increase only.

ServiceRequired becomes TRUE when

RuntimeHours >= NextServiceHours

ServiceOverdue becomes TRUE after the configured grace period.

Maintenance reset updates

- LastServiceDate
- NextServiceHours
- RemainingHours
- ResetCounter

---

# Lifetime

Persistent (Retain)

Maintenance data survives PLC restart.

Historical maintenance records are stored in the database.

---

# Example

```iecst
g_Maintenance[1]    // Blower

g_Maintenance[2]    // Selector

g_Maintenance[3]    // Dosing Motor
```

---

# Used By

- Maintenance Manager
- Dashboard
- Reports
- Service Screen
- Alarm Manager