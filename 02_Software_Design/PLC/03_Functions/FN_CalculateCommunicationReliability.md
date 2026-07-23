# Function

FN_CalculateCommunicationReliability

---

# Function

FN_CalculateCommunicationReliability

---

# Purpose

Calculates the overall communication reliability by comparing the number of successful communication cycles with the total scheduled communication cycles.

This KPI measures how reliably the communication infrastructure performs over an extended operating period and is suitable for long-term system performance evaluation.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SuccessfulCycles | DINT | Number of successful communication cycles |
| ScheduledCycles | DINT | Total scheduled communication cycles |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication reliability (%) |

---

# Formula

```text
CommunicationReliability =
(SuccessfulCycles /
ScheduledCycles)
× 100
```

---

# Logic

```text
IF SuccessfulCycles < 0 THEN

    Return := 0.0;

ELSIF ScheduledCycles <= 0 THEN

    Return := 0.0;

ELSIF SuccessfulCycles >= ScheduledCycles THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(SuccessfulCycles) * 100.0) /
        REAL(ScheduledCycles);

END_IF;
```

---

# Rules

- ScheduledCycles shall be greater than zero.
- SuccessfulCycles shall be zero or greater.
- Division by zero shall be prevented.
- SuccessfulCycles shall not exceed ScheduledCycles.
- The returned value shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Communication reliability (%) |
| All cycles successful | 100.0 |
| No successful cycles | 0.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Long-term communication KPI calculations
- PLC network reliability monitoring
- Modbus RTU/TCP performance evaluation
- Preventive maintenance analysis
- System health dashboards
- Historical trend reporting

---

# Used By

- FB_CommunicationManager
- FB_ModbusMaster
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Successful Cycles | Scheduled Cycles | Expected |
|------------------:|-----------------:|---------:|
| 10000 | 10000 | 100% |
| 9950 | 10000 | 99.5% |
| 9800 | 10000 | 98% |
| 0 | 10000 | 0% |
| 100 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the communication reliability KPI.

It does not:

- Detect communication failures
- Retry communication packets
- Measure communication latency
- Calculate communication throughput
- Store communication history
- Generate maintenance reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationAvailability.md
- FN_CalculateCommunicationEfficiency.md
- FN_CalculateCommunicationStability.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- TEST_Functions.md

---

# Revision

Version 1.0