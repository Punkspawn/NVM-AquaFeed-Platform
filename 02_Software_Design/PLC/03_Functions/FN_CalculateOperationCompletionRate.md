# Function

FN_CalculateOperationCompletionRate

---

# Function

FN_CalculateOperationCompletionRate

---

# Purpose

Calculates the percentage of completed operations compared to assigned operations.

This function is used for operation progress monitoring and statistics.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CompletedOperations | DINT | Number of completed operations |
| AssignedOperations | DINT | Total assigned operations |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Operation completion rate (%) |

---

# Formula

```text
CompletionRate =
(CompletedOperations /
AssignedOperations)
× 100