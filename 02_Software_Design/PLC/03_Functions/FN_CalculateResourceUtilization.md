# Function

FN_CalculateResourceUtilization

---

# Function

FN_CalculateResourceUtilization

---

# Purpose

Calculates the utilization percentage of a production resource by comparing the actual operating time with the available operating time.

This KPI is used to evaluate the efficiency of production resources such as feeders, blowers, conveyors, dosing units and complete production lines.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperatingTime | REAL | Actual operating time (seconds) |
| AvailableTime | REAL | Available operating time (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Resource utilization (%) |

---

# Formula

```text
ResourceUtilization =
(OperatingTime /
AvailableTime)
× 100
```

---

# Logic

```text
IF OperatingTime < 0.0 THEN

    Return := 0.0;

ELSIF AvailableTime <= 0.0 THEN

    Return := 0.0;

ELSIF OperatingTime >= AvailableTime THEN

    Return := 100.0;

ELSE

    Return :=
        (OperatingTime * 100.0)
        /
        AvailableTime;

END_IF;
```

---

# Rules

- AvailableTime shall be greater than zero.
- OperatingTime shall be zero or greater.
- OperatingTime shall not exceed AvailableTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Resource utilization (%) |
| Resource never operated | 0.0 |
| Resource fully utilized | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Equipment utilization monitoring
- Production KPI dashboards
- Preventive maintenance planning
- Resource capacity analysis
- Performance reporting
- OEE support calculations

---

# Used By

- FB_LineManager
- FB_ProductionManager
- FB_ReportManager
- FB_SystemManager
- FB_MaintenanceManager

---

# Test Cases

| Operating Time | Available Time | Expected |
|---------------:|---------------:|---------:|
| 3600 s | 7200 s | 50% |
| 5400 s | 7200 s | 75% |
| 7200 s | 7200 s | 100% |
| 0 s | 7200 s | 0% |
| 100 s | 0 s | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the resource utilization percentage.

It does not:

- Schedule production resources
- Detect equipment failures
- Predict maintenance requirements
- Store utilization history
- Generate production reports
- Control field devices

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateUtilization.md
- FN_CalculateEfficiency.md
- FN_CalculateSystemUtilization.md
- FB_ProductionManager.md
- FB_MaintenanceManager.md
- TEST_Functions.md

---

# Revision

Version 1.0