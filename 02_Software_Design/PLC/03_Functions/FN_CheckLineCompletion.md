# Function

FN_CheckLineCompletion

---

# Function

FN_CheckLineCompletion

---

# Purpose

Checks whether an individual feeding line operation has been completed.

This function evaluates the completion conditions of a single feeding line after the assigned feeding task is finished.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| TargetAmount | REAL | Required feed amount (kg) |
| DeliveredAmount | REAL | Delivered feed amount (kg) |
| FeedActive | BOOL | Feeding operation active status |
| CompletionTolerance | REAL | Allowed completion tolerance (%) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Feeding completion status |

---

# Formula

```text
CompletionDeviation =
((DeliveredAmount - TargetAmount)
/
TargetAmount)
× 100
```

---

# Logic

```text
IF FeedActive = FALSE THEN

    Return := FALSE;

ELSIF TargetAmount <= 0.0 THEN

    Return := FALSE;

ELSE

    Deviation :=
        ((DeliveredAmount - TargetAmount)
        /
        TargetAmount)
        * 100.0;


    IF ABS(Deviation) <= CompletionTolerance THEN

        Return := TRUE;

    ELSE

        Return := FALSE;

    END_IF;

END_IF;
```

---

# Rules

- Completion check shall only be active during feeding operation.
- TargetAmount shall be greater than zero.
- DeliveredAmount shall be zero or greater.
- CompletionTolerance shall be zero or greater.
- The function shall only evaluate completion state.
- The function shall not stop equipment.
- The function shall not modify recipe data.
- Other lines shall not affect the result.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Feed amount completed within tolerance | TRUE |
| Feed still active | FALSE |
| Amount outside tolerance | FALSE |
| Invalid target amount | FALSE |

---

# Typical Usage

- Automatic feeding sequence
- Batch completion detection
- Line state transition
- Recipe execution monitoring

---

# Used By

- FB_LineManager
- FB_Dosing
- FB_FeedProgramManager
- FB_RecipeManager

---

# Test Cases

| Target | Delivered | Tolerance | Active | Expected |
|-------:|----------:|----------:|--------|----------|
| 100 kg | 100 kg | 5% | TRUE | TRUE |
| 100 kg | 96 kg | 5% | TRUE | TRUE |
| 100 kg | 90 kg | 5% | TRUE | FALSE |
| 100 kg | 100 kg | 5% | FALSE | FALSE |
| 0 kg | 100 kg | 5% | TRUE | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function checks only feeding completion status.

It does not:

- Control dosing motor
- Stop blower
- Save production records
- Start next operation
- Manage other lines

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckLineStopCondition.md
- FN_CheckDosageDeviation.md
- FN_CalculateFeedAccuracy.md
- FB_LineManager.md

---

# Revision

Version 1.0