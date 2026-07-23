# Function

FN_CreateAlarmCode

---

# Function

FN_CreateAlarmCode

---

# Purpose

Creates a standardized alarm code based on alarm source and alarm type.

This function provides a common alarm identification structure for PLC diagnostics and HMI display.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SourceID | INT | Alarm source identifier |
| AlarmType | INT | Alarm type identifier |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | DINT | Generated alarm code |

---

# Formula

```text
AlarmCode =
(SourceID × 100)
+
AlarmType
```

---

# Logic

```text
IF SourceID < 0 THEN

    Return := 0;

ELSIF AlarmType < 0 THEN

    Return := 0;

ELSE

    Return :=
        (SourceID * 100)
        +
        AlarmType;

END_IF;
```

---

# Rules

- SourceID shall identify the equipment or subsystem.
- AlarmType shall identify the alarm category.
- Generated alarm codes shall be unique.
- The function shall only create alarm identifiers.
- The function shall not activate alarms.
- The function shall not store alarm history.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid source and type | Generated alarm code |
| Invalid input | 0 |

---

# Typical Usage

- Alarm manager
- HMI alarm display
- Event logging
- Diagnostic reporting

---

# Used By

- FB_AlarmManager
- FB_DiagnosticsManager
- FB_DataLogger
- FB_ReportManager

---

# Test Cases

| Source ID | Alarm Type | Expected |
|----------:|-----------:|---------:|
| 1 | 1 | 101 |
| 2 | 5 | 205 |
| 10 | 3 | 1003 |
| -1 | 1 | 0 |
| 1 | -1 | 0 |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only generates alarm identifiers.

It does not:

- Detect alarm conditions
- Trigger alarms
- Reset alarms
- Store alarm history
- Control equipment

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CheckAlarmPriority.md
- FN_IsAlarmActive.md
- FB_AlarmManager.md

---

# Revision

Version 1.0