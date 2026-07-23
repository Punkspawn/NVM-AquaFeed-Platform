# Function

FN_CheckSelectorMovementPermission

---

# Function

FN_CheckSelectorMovementPermission

---

# Purpose

Checks whether selector movement is allowed according to system conditions.

This function verifies the required conditions before starting selector positioning.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SystemReady | BOOL | General system ready status |
| TargetPositionValid | BOOL | Requested selector position validity |
| BlowerRunning | BOOL | Blower operating status |
| SelectorBusy | BOOL | Current selector movement status |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | Movement permission status |

---

# Logic

```text
IF SystemReady = FALSE THEN

    Return := FALSE;

ELSIF TargetPositionValid = FALSE THEN

    Return := FALSE;

ELSIF BlowerRunning = TRUE THEN

    Return := FALSE;

ELSIF SelectorBusy = TRUE THEN

    Return := FALSE;

ELSE

    Return := TRUE;

END_IF;
```

---

# Rules

- Selector movement shall only start when system is ready.
- Target position shall be valid before movement.
- Blower shall not be running during selector positioning.
- Only one selector movement operation shall be active at a time.
- The function shall only evaluate movement permission.
- The function shall not control motor outputs.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| All conditions satisfied | TRUE |
| Any condition not satisfied | FALSE |

---

# Typical Usage

- Selector automatic sequence
- Feeding line preparation
- Safe positioning control
- Machine state coordination

---

# Used By

- FB_Selector
- FB_LineManager
- FB_SequenceManager

---

# Test Cases

| System Ready | Target Valid | Blower | Busy | Expected |
|-------------|--------------|--------|------|----------|
| TRUE | TRUE | FALSE | FALSE | TRUE |
| FALSE | TRUE | FALSE | FALSE | FALSE |
| TRUE | FALSE | FALSE | FALSE | FALSE |
| TRUE | TRUE | TRUE | FALSE | FALSE |
| TRUE | TRUE | FALSE | TRUE | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function checks only selector movement permission.

It does not:

- Move the selector
- Start or stop blower
- Control motors
- Execute positioning sequence
- Manage alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckSelectorPosition.md
- FN_CheckSelectorMovementTimeout.md
- FN_IsEquipmentReady.md
- FB_Selector.md

---

# Revision

Version 1.0