# Function

FN_CalculateAverageFeedAmount

---

# Function

FN_CalculateAverageFeedAmount

---

# Purpose

Calculates the average feed amount per completed feeding operation.

This function is used for feeding statistics and operation performance monitoring.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TotalFeedAmount | REAL | Total delivered feed amount (kg) |
| CompletedOperationCount | DINT | Number of completed feeding operations |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Average feed amount per operation (kg) |

---

# Formula

```text
AverageFeedAmount =
TotalFeedAmount /
CompletedOperationCount