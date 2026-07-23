# Function

FN_CalculateSystemUtilization

---

# Function

FN_CalculateSystemUtilization

---

# Purpose

Calculates the utilization percentage of the complete feeding system by comparing the accumulated operating time with the total available production time.

This function is used for production analysis, capacity utilization monitoring, reporting, and overall system performance evaluation.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| OperatingTime | TIME | Total operating time |
| AvailableTime | TIME | Total available production time |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | System utilization (%) |

---

# Formula

```text
SystemUtilization =
(OperatingTime /
AvailableTime)
× 100
```

---

# Logic

```text
VAR
    OperatingSeconds : REAL;
    AvailableSeconds : REAL;
END_VAR

OperatingSeconds := TIME_TO_REAL(OperatingTime) / 1000.0;
AvailableSeconds := TIME_TO_REAL(AvailableTime) / 1000.0;

IF AvailableSeconds <= 0.0 THEN

    Return := 0.0;

ELSIF OperatingSeconds < 0.0 THEN

    Return := 0.0;

ELSIF OperatingSeconds >= AvailableSeconds THEN

    Return := 100.0;

ELSE

    Return :=
        (OperatingSeconds * 100.0) /
        AvailableSeconds;

END_IF;
```

---

# Rules

- AvailableTime shall be greater than zero.
- OperatingTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- Utilization greater than 100% shall be limited to 100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Utilization (%) |
| OperatingTime ≥ AvailableTime | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Overall system monitoring
- Capacity utilization analysis
- OEE calculations
- Production dashboards
- Historical reporting
- Maintenance planning

---

# Used By

- FB_SystemManager
- FB_ReportManager
- FB_StatisticsManager
- FB_HMIManager
- FB_OEEManager

---

# Test Cases

| Operating Time | Available Time | Expected |
|---------------|----------------|---------:|
| 8 h | 10 h | 80% |
| 10 h | 10 h | 100% |
| 12 h | 10 h | 100% |
| 0 h | 10 h | 0% |
| 5 h | 0 h | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only overall system utilization.

It does not:

- Calculate equipment efficiency
- Calculate production quality
- Detect machine failures
- Control production equipment
- Store historical production data
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateUtilization.md
- FN_CalculateAvailability.md
- FN_CalculateOEE.md
- FB_SystemManager.md
- FB_OEEManager.md
- TEST_Functions.md

---

# Revision

Version 1.0