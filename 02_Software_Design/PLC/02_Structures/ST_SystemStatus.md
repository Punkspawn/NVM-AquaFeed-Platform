# ST_SystemStatus

---

# Purpose

Represents the overall state of the AquaFeed Platform.

Every software layer shall reference this structure to determine the current operating status of the system.

---

# Description

This structure provides a single source of truth for the machine state.

It is updated by the PLC and read by the HMI and Desktop Application.

---

# Structure

```iecst
TYPE ST_SystemStatus :
STRUCT

    SystemReady        : BOOL;
    SystemRunning      : BOOL;
    SystemPaused       : BOOL;
    SystemStopped      : BOOL;

    ManualMode         : BOOL;
    AutoMode           : BOOL;
    ServiceMode        : BOOL;

    AlarmActive        : BOOL;
    EmergencyStop      : BOOL;
    CommunicationOK    : BOOL;

    CurrentLine        : USINT;
    ActiveRecipe       : UINT;

    CurrentJob         : UINT;

    FeedingActive      : BOOL;
    SelectorBusy       : BOOL;
    BlowerRunning      : BOOL;
    DosingRunning      : BOOL;

    CurrentUser        : UINT;

    SystemState        : E_SystemState;

END_STRUCT
END_TYPE
```

---

# Updated By

FB_SystemManager

---

# Read By

FB_LineManager

FB_FeedingControlManager

HMI

Desktop Application

Diagnostics

---

# Description Of Fields

SystemReady

Machine initialization completed.

---

SystemRunning

Machine is operating.

---

SystemPaused

Automatic cycle is paused.

---

SystemStopped

Machine is stopped.

---

ManualMode

Manual operation enabled.

---

AutoMode

Automatic operation enabled.

---

ServiceMode

Maintenance mode enabled.

---

AlarmActive

At least one active alarm exists.

---

EmergencyStop

Emergency circuit activated.

---

CommunicationOK

Desktop communication available.

---

CurrentLine

Selected feeding line.

---

ActiveRecipe

Currently loaded recipe.

---

CurrentJob

Running job identifier.

---

FeedingActive

Feeding sequence is active.

---

SelectorBusy

Selector currently moving.

---

BlowerRunning

Blower operating.

---

DosingRunning

Dosing motor operating.

---

CurrentUser

Logged operator ID.

---

SystemState

Overall machine state.

---

# Rules

Only FB_SystemManager may modify this structure.

Other modules shall treat it as read-only.

---

# Lifetime

Always allocated.

Never recreated.

---

# Usage

Global system status exchange.

PLC ↔ HMI

PLC ↔ Desktop

PLC Internal Communication