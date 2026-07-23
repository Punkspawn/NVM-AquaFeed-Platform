# Function

FN_CalculateFeedRate

---

# Purpose

Calculates the average feed delivery rate based on the delivered feed quantity and the elapsed feeding time.

This function provides a standardized method for determining the actual feeding performance during completed or ongoing feeding jobs.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| FeedQuantity | REAL | Delivered feed quantity (kg) |
| FeedingTime | TIME | Feeding duration |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Average feed rate (kg/min) |

---

# Formula

```text
FeedRate =
FeedQuantity
/
(TIME_TO_DINT(FeedingTime) / 60000.0)
```

---

# Logic

```text
IF FeedingTime <= T#0S THEN
    Return := 0.0;

ELSIF FeedQuantity < 0 THEN
    Return := 0.0;

ELSE
    Return :=
        FeedQuantity /
        (TIME_TO_DINT(FeedingTime) / 60000.0);

END_IF;
```

---

# Rules

- FeedingTime shall be greater than zero.
- FeedQuantity shall not be negative.
- Division by zero shall be prevented.
- The function shall return the average feed rate in **kg/min**.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Average feed rate |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Feeding performance analysis
- Recipe verification
- Production statistics
- Historical reports
- Operator performance monitoring
- HMI process display

---

# Used By

- FB_FeedingControlManager
- FB_ReportManager
- FB_RuntimeManager
- FB_JobManager
- FB_HistoryManager

---

# Test Cases

| Feed Quantity | Feeding Time | Expected |
|--------------:|-------------:|---------:|
| 100 kg | T#10M | 10 kg/min |
| 60 kg | T#5M | 12 kg/min |
| 0 kg | T#10M | 0 kg/min |
| 50 kg | T#0S | 0 kg/min |
| -10 kg | T#5M | 0 kg/min |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the average feed rate.

It does not:

- Measure instantaneous feed rate
- Control dosing speed
- Validate recipe parameters
- Detect feeding interruptions
- Adjust equipment output
- Store production statistics

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateFeedAmount.md
- FN_CalculateJobDuration.md
- FB_FeedingControlManager.md
- FB_ReportManager.md
- TEST_Functions.md

---

# Revision

Version 1.0