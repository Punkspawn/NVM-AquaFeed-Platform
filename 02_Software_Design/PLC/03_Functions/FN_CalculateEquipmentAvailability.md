# Function

FN_CalculateEquipmentAvailability

---

# Function

FN_CalculateEquipmentAvailability

---

# Purpose

Calculates the availability percentage of an individual equipment by comparing its operating time with the total scheduled operating time.

This KPI is commonly used for blowers, feeders, dosing units, conveyors, and other production equipment.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperatingTime | REAL | Equipment operating time (seconds) |
| ScheduledTime | REAL | Scheduled operating time (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Equipment availability (%) |

---

# Formula

```text
EquipmentAvailability =
(OperatingTime /
ScheduledTime)
× 100
```

---

# Logic

```text
IF OperatingTime < 0.0 THEN

    Return := 0.0;

ELSIF ScheduledTime <= 0.0 THEN

    Return := 0.0;

ELSIF OperatingTime >= ScheduledTime THEN

    Return := 100.0;

ELSE

    Return :=
        (OperatingTime * 100.0)
        /
        ScheduledTime;

END_IF;
```

---

# Rules

- ScheduledTime shall be greater than zero.
- OperatingTime shall be zero or greater.
- OperatingTime shall not exceed ScheduledTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Equipment availability (%) |
| Equipment unavailable | 0.0 |
| Equipment available during entire schedule | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Equipment KPI calculations
- OEE calculations
- Preventive maintenance reporting
- Equipment utilization dashboards
- Production reporting
- Asset performance monitoring

---

# Used By

- FB_LineManager
- FB_MaintenanceManager
- FB_ProductionManager
- FB_ReportManager
- FB_SystemManager

---

# Test Cases

| Operating Time | Scheduled Time | Expected |
|---------------:|---------------:|---------:|
| 3600 s | 3600 s | 100% |
| 3420 s | 3600 s | 95% |
| 2700 s | 3600 s | 75% |
| 0 s | 3600 s | 0% |
| 100 s | 0 s | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only equipment availability.

It does not:

- Detect equipment failures
- Schedule maintenance
- Calculate OEE
- Store historical operating data
- Generate maintenance reports
- Control equipment operation

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateAvailability.md
- FN_CalculateResourceUtilization.md
- FN_CalculateSystemUtilization.md
- FB_MaintenanceManager.md
- FB_LineManager.md
- TEST_Functions.md

---

# Revision

Version 1.0