# Function

FN_CalculateAverageOperationTime

---

# Function

FN_CalculateAverageOperationTime

---

# Purpose

Calculates the average duration of completed operations.

This function is used for operation performance statistics by calculating the average time spent per completed operation.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalOperationTime | REAL | Total operation time (seconds) |
| CompletedOperationCount | DINT | Number of completed operations |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Average operation time (seconds) |

---

# Formula

```text
AverageOperationTime =
TotalOperationTime /
CompletedOperationCount
```

---

# Logic

```text
IF CompletedOperationCount <= 0 THEN

    Return := 0.0;

ELSIF TotalOperationTime < 0.0 THEN

    Return := 0.0;

ELSE

    Return :=
        TotalOperationTime /
        REAL(CompletedOperationCount);

END_IF;
```

---

# Rules

- CompletedOperationCount shall be greater than zero.
- TotalOperationTime shall be zero or greater.
- Division by zero shall be prevented.
- The function shall calculate only average value.
- The function shall not store operation history.
- The function shall not manage counters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid data | Average operation time (s) |
| No completed operation | 0.0 |
| Invalid input | 0.0 |

---

# Typical Usage

- Feeding performance analysis
- Cycle time monitoring
- Production statistics
- Line efficiency calculations

---

# Used By

- FB_StatisticsManager
- FB_ReportManager
- FB_DataLogger

---

# Test Cases

| Total Time | Operation Count | Expected |
|-----------:|----------------:|---------:|
| 1000 s | 10 | 100 s |
| 5000 s | 50 | 100 s |
| 0 s | 10 | 0 s |
| 1000 s | 0 | 0 s |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only average operation duration.

It does not:

- Measure time
- Count operations
- Store history
- Generate reports
- Control equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateRuntimeSeconds.md
- FN_IncrementOperationCounter.md
- FB_StatisticsManager.md

---

# Revision

Version 1.0