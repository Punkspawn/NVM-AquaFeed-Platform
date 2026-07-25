# ST_Line

---

# Purpose

Represents a single feeding line.

Each physical feeding line shall have one instance of this structure.

---

# Structure

```iecst
TYPE ST_Line :
STRUCT

    LineId              : USINT;

    Enabled             : BOOL;

    AutoMode            : BOOL;

    ManualMode          : BOOL;

    Ready               : BOOL;

    Running             : BOOL;

    Busy                : BOOL;

    Fault               : BOOL;

    Selected            : BOOL;

    CurrentRecipe       : UINT;

    CurrentJob          : UINT;

    FeedAmountKg        : REAL;

    FeededAmountKg      : REAL;

    FeedingTimeSec      : UDINT;

    RemainingTimeSec    : UDINT;

    SelectorPosition    : USINT;

    BlowerRunning       : BOOL;

    DosingRunning       : BOOL;

    LastAlarm           : UINT;

END_STRUCT
END_TYPE
```

---

# Updated By

- FB_LineManager
- FB_FeedingControlManager

---

# Read By

- FB_SystemManager
- HMI
- Desktop Application
- Diagnostics

---

# Description

LineId

Unique feeding line identifier.

---

Enabled

Line available for operation.

---

AutoMode

Automatic operation.

---

ManualMode

Manual operation.

---

Ready

Line is ready for feeding.

---

Running

Line currently executing.

---

Busy

Line occupied by another task.

---

Fault

Line contains an active fault.

---

Selected

Current operator selected line.

---

CurrentRecipe

Loaded recipe.

---

CurrentJob

Executing job.

---

FeedAmountKg

Requested feed quantity.

---

FeededAmountKg

Delivered feed quantity.

---

FeedingTimeSec

Configured feeding duration.

---

RemainingTimeSec

Remaining execution time.

---

SelectorPosition

Current selector destination.

---

BlowerRunning

Blower state.

---

DosingRunning

Dosing motor state.

---

LastAlarm

Latest alarm code.

---

# Rules

Only FB_LineManager updates this structure.

Other modules shall access it as read-only whenever possible.

---

# Lifetime

Persistent during PLC runtime.

One instance exists for each feeding line.

---

# Example

```iecst
Lines[1]
Lines[2]
Lines[3]
Lines[4]
Lines[5]
Lines[6]
```