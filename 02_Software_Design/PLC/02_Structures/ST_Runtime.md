# ST_Runtime

---

# Purpose

Represents lifetime runtime statistics maintained by the PLC.

This structure stores machine counters and accumulated operating values required for machine control, maintenance and communication with the AquaFeed Platform.

Daily, weekly, monthly and historical statistics are calculated by the AquaFeed Platform using the database.

---

# Structure

```iecst
TYPE ST_Runtime :
STRUCT

    TotalRuntimeSec         : UDINT;

    TotalProductionTimeSec  : UDINT;

    TotalIdleTimeSec        : UDINT;

    TotalPauseTimeSec       : UDINT;

    TotalFeedKg             : REAL;

    TotalCycleCount         : UDINT;

    LastFeedKg              : REAL;

    LastCycleTimeSec        : UDINT;

    BlowerRuntimeSec        : UDINT;

    DosingRuntimeSec        : UDINT;

    SelectorRuntimeSec      : UDINT;

    MachineStartCount       : UDINT;

    EmergencyStopCount      : UDINT;

    AlarmCount              : UDINT;

END_STRUCT
END_TYPE
```

---

# Updated By

FB_RuntimeManager

FB_SystemManager

FB_FeedingControlManager

---

# Read By

Desktop Application

Dashboard

Maintenance Manager

Statistics Manager

Service Screen

---

# Description

TotalRuntimeSec

Accumulated machine runtime.

---

TotalProductionTimeSec

Accumulated automatic production time.

---

TotalIdleTimeSec

Accumulated idle time.

---

TotalPauseTimeSec

Accumulated operator pause time.

---

TotalFeedKg

Lifetime delivered feed.

---

TotalCycleCount

Lifetime completed feeding cycles.

---

LastFeedKg

Feed amount of the most recently completed feeding cycle.

---

LastCycleTimeSec

Duration of the most recently completed feeding cycle.

---

BlowerRuntimeSec

Accumulated blower runtime.

---

DosingRuntimeSec

Accumulated dosing runtime.

---

SelectorRuntimeSec

Accumulated selector runtime.

---

MachineStartCount

Number of machine starts.

---

EmergencyStopCount

Number of emergency stop events.

---

AlarmCount

Total alarm occurrences.

---

# Rules

Runtime counters shall never decrease.

Lifetime counters shall be retained across PLC power cycles.

Feed quantities shall always be recorded in kilograms.

The PLC shall only maintain lifetime counters.

Daily, weekly, monthly and historical statistics shall be calculated by the AquaFeed Platform.

---

# Lifetime

Persistent (Retain)

Values survive PLC restart and power loss.

---

# Example

```iecst
g_Runtime

g_Runtime.TotalFeedKg

g_Runtime.TotalCycleCount

g_Runtime.BlowerRuntimeSec
```

---

# Used By

- FB_RuntimeManager
- FB_SystemManager
- FB_MaintenanceManager
- AquaFeed Platform

---

# Revision History

Version 2.0

Changes

- Removed TodayFeedKg
- Removed TodayCycleCount
- Removed LastStartTime
- Removed LastStopTime
- Clarified PLC and AquaFeed Platform responsibilities