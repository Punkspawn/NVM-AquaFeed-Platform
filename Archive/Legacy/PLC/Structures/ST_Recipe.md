# Legacy Mixed Recipe Structure

> **Status:** Legacy / Superseded  
> **Reason archived:** Mixed Desktop recipe master and PLC execution parameters.  
> **Replacements:** `03_Desktop/Domain/Recipe.md` and `ST_RecipeExecution.md`

---

# ST_Recipe

---

# Purpose

Represents a feeding recipe.

A recipe contains all parameters required to execute one feeding operation.

---

# Structure

```iecst
TYPE ST_Recipe :
STRUCT

    RecipeId            : UINT;

    RecipeName          : STRING[50];

    Enabled             : BOOL;

    FeedAmountKg        : REAL;

    FeedingTimeSec      : UDINT;

    DosingSpeedPercent  : REAL;

    BlowerSpeedPercent  : REAL;

    BlowerStartDelayMs  : UINT;

    BlowerStopDelayMs   : UINT;

    LineMask            : WORD;

    RepeatCount         : UINT;

    RepeatDelaySec      : UINT;

    CreatedBy           : UINT;

    ModifiedBy          : UINT;

    CreatedDate         : DT;

    ModifiedDate        : DT;

END_STRUCT
END_TYPE
```

---

# Updated By

Desktop Application

Recipe Manager

---

# Read By

FB_RecipeManager

FB_FeedingControlManager

FB_LineManager

HMI

---

# Description

RecipeId

Unique recipe number.

---

RecipeName

Operator friendly recipe name.

---

Enabled

Recipe available for use.

---

FeedAmountKg

Target feed quantity.

---

FeedingTimeSec

Target feeding duration.

---

DosingSpeedPercent

Dosing inverter speed.

---

BlowerSpeedPercent

Blower inverter speed.

---

BlowerStartDelayMs

Delay before dosing starts.

---

BlowerStopDelayMs

Delay after dosing stops.

---

LineMask

Allowed feeding lines.

Each bit represents one line.

Bit0 = Line1

Bit1 = Line2

...

Bit15 = Line16

---

RepeatCount

Number of feeding repetitions.

---

RepeatDelaySec

Delay between repetitions.

---

CreatedBy

Operator ID.

---

ModifiedBy

Last editor.

---

CreatedDate

Creation timestamp.

---

ModifiedDate

Last modification timestamp.

---

# Rules

RecipeId shall be unique.

FeedAmountKg > 0

FeedingTimeSec > 0

Speed values shall be between 0 and 100%.

Disabled recipes cannot be executed.

---

# Lifetime

Recipes are permanently stored in the database.

PLC loads only the active recipe.

---

# Example

```iecst
Recipes[1]
Recipes[2]
Recipes[3]
...
Recipes[100]
```