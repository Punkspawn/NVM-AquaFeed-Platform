# Legacy PLC Recipe Management Interface

> **Status:** Legacy / Superseded  
> **Reason archived:** Recipe save/delete and master management belong to Desktop.  
> **Replacement:** `IF_ExecutionTransfer.md`

---

# IF_Recipe

---

# Purpose

Defines the standard software interface for recipe management.

This interface standardizes recipe creation, validation, loading and execution throughout the PLC software.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables recipe management. |
| Load | BOOL | Loads the selected recipe. |
| Save | BOOL | Saves the current recipe. |
| Delete | BOOL | Deletes the selected recipe. |
| Validate | BOOL | Validates the selected recipe. |
| RecipeID | UINT | Recipe identifier. |
| Recipe | ST_Recipe | Recipe data structure. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | Recipe manager is ready. |
| Loaded | BOOL | Recipe successfully loaded. |
| Saved | BOOL | Recipe successfully saved. |
| Valid | BOOL | Recipe validation successful. |
| Busy | BOOL | Recipe operation in progress. |
| Fault | BOOL | Recipe operation failed. |
| ActiveRecipeID | UINT | Currently active recipe. |
| AlarmCode | UINT | Active recipe alarm code. |

---

# State Flow

```text
Idle
   │
Load
   │
Recipe Loaded
   │
Validate
   │
Valid
   │
Ready For Production
```

Save sequence

```text
Idle
   │
Save
   │
Recipe Stored
   │
Idle
```

Fault sequence

```text
Any State
    │
Fault
    │
Reset
    │
Idle
```

---

# Rules

- A recipe shall be validated before it can become active.
- Only one recipe may be active at any given time.
- A recipe shall not be modified while it is in use.
- `Busy` shall remain TRUE during load, save and validation operations.
- `AlarmCode` shall be zero when no recipe-related alarm is active.

---

# Used By

- FB_RecipeManager
- FB_FeedingControlManager
- FB_JobManager
- HMI
- AquaFeed Manager