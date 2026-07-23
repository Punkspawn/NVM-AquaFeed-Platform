# Function

FN_CalculateRemainingTime

---

# Function

FN_CalculateRemainingTime

---

# Purpose

Calculates the estimated remaining time required to complete a feeding or production job based on the remaining quantity and the current processing rate.

This function provides a consistent estimate of completion time for HMI displays, production scheduling, and operator guidance.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| RemainingQuantity | REAL | Remaining quantity to process (kg) |
| CurrentRate | REAL | Current processing rate (kg/min) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | TIME | Estimated remaining time |

---

# Formula

```text
RemainingTime =
RemainingQuantity
/
CurrentRate
```

The result is converted from minutes to a `TIME` value.

---

# Logic

```text
IF RemainingQuantity <= 0.0 THEN
    Return := T#0S;

ELSIF CurrentRate <= 0.0 THEN
    Return := T#0S;

ELSE
    Return :=
        DINT_TO_TIME(
            REAL_TO_DINT(
                (RemainingQuantity / CurrentRate) * 60000.0
            )
        );

END_IF;
```

---

# Rules

- RemainingQuantity shall be zero or greater.
- CurrentRate shall be greater than zero.
- Division by zero shall be prevented.
- The returned value shall represent the estimated completion time.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Estimated remaining time |
| RemainingQuantity = 0 | T#0S |
| CurrentRate ≤ 0 | T#0S |

---

# Typical Usage

- Remaining job time display
- HMI countdown
- Production scheduling
- Feeding progress estimation
- Operator information
- Historical reporting

---

# Used By

- FB_JobManager
- FB_FeedingControlManager
- FB_RuntimeManager
- FB_HMIManager
- FB_ReportManager

---

# Test Cases

| Remaining Quantity | Current Rate | Expected |
|-------------------:|-------------:|---------:|
| 100 kg | 10 kg/min | T#10M |
| 45 kg | 15 kg/min | T#3M |
| 0 kg | 20 kg/min | T#0S |
| 50 kg | 0 kg/min | T#0S |
| -10 kg | 5 kg/min | T#0S |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function provides only an estimated completion time based on the current processing rate.

It does not:

- Predict future rate changes
- Compensate for pauses or interruptions
- Detect equipment faults
- Modify job parameters
- Schedule production
- Store historical information

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedRate.md
- FN_CalculateProductionRate.md
- FN_CalculateProgress.md
- FB_JobManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0