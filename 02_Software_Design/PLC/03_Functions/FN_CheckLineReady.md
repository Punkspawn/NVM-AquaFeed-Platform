# Function

FN_CheckLineReady

---

# Function

FN_CheckLineReady

---

# Purpose

Checks whether an individual feeding line is ready for operation.

This function evaluates the basic readiness conditions of the line equipment before starting an automatic feeding operation.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SelectorReady | BOOL | Selector ready status |
| DosingReady | BOOL | Dosing unit ready status |
| BlowerReady | BOOL | Blower ready status |
| AlarmActive | BOOL | Active line alarm status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Line ready status |

---

# Logic

```text
IF SelectorReady = FALSE THEN

    Return := FALSE;

ELSIF DosingReady = FALSE THEN

    Return := FALSE;

ELSIF BlowerReady = FALSE THEN

    Return := FALSE;

ELSIF AlarmActive = TRUE THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- Each line shall evaluate its own equipment status.
- Other lines shall not affect this result.
- Active alarms shall prevent automatic operation.
- The function shall only evaluate readiness.
- The function shall not start equipment.
- The function shall not control selector, dosing, or blower outputs.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| All equipment ready and no alarm | TRUE |
| Any equipment not ready | FALSE |
| Alarm active | FALSE |

---

# Typical Usage

- Automatic feeding start permission
- Line status monitoring
- Sequence preparation
- Operator interface status display

---

# Used By

- FB_LineManager
- FB_FeedProgramManager
- FB_SequenceManager

---

# Test Cases

| Selector | Dosing | Blower | Alarm | Expected |
|----------|--------|--------|-------|----------|
| TRUE | TRUE | TRUE | FALSE | TRUE |
| FALSE | TRUE | TRUE | FALSE | FALSE |
| TRUE | FALSE | TRUE | FALSE | FALSE |
| TRUE | TRUE | FALSE | FALSE | FALSE |
| TRUE | TRUE | TRUE | TRUE | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function checks only the readiness of one individual line.

It does not:

- Manage multiple lines
- Select active lines
- Start feeding operation
- Control equipment
- Generate alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsLineAvailable.md
- FN_IsEquipmentReady.md
- FN_GetLineStatus.md
- FB_LineManager.md

---

# Revision

Version 1.0