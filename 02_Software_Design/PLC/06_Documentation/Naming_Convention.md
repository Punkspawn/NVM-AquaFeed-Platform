# Naming Convention

---

# Purpose

This document defines the naming conventions used throughout the AquaFeed PLC software.

Consistent naming improves readability, debugging, maintenance and long-term scalability.

---

# General Rules

- Use English names only.
- Use PascalCase for Function Blocks, Structures and Data Types.
- Use CamelCase for variables.
- Avoid abbreviations unless they are industry standard.
- Names shall clearly describe their purpose.
- Avoid generic names such as Data, Temp or Value.

---

# Function Blocks

Format:

FB_<FunctionName>

Examples:

- FB_SystemManager
- FB_LineManager
- FB_FeedingControlManager
- FB_Selector
- FB_Blower
- FB_Dosing
- FB_ModbusMaster
- FB_RuntimeManager
- FB_AlarmManager

---

# Structures

Format:

ST_<StructureName>

Examples:

- ST_Line
- ST_Recipe
- ST_Alarm
- ST_Runtime
- ST_ModbusDevice
- ST_User

---

# Enumerations

Format:

E_<Name>

Examples:

- E_SystemState
- E_LineState
- E_AlarmPriority
- E_AlarmType
- E_UserRole

---

# Global Variables

Format:

g<Name>

Examples:

- gSystemStatus
- gRecipeList
- gAlarmList
- gRuntimeData

---

# Local Variables

Format:

camelCase

Examples:

- currentState
- nextState
- targetLine
- retryCounter
- timeoutTimer

---

# Boolean Variables

Boolean variables shall describe a condition.

Preferred prefixes:

- is
- has
- can
- enable
- request

Examples:

- isReady
- isRunning
- hasFault
- canStart
- enableBlower
- requestReset

---

# Timers

Format:

tm<Name>

Examples:

- tmStartup
- tmSelectorTimeout
- tmBlowerDelay
- tmCommunication

---

# Counters

Format:

cnt<Name>

Examples:

- cntRetry
- cntFeedCycles
- cntAlarm
- cntRuntimeHours

---

# Constants

Format:

k<Name>

Examples:

- kMaxLines
- kTimeoutMs
- kMaxRecipes
- kSoftwareVersion

---

# Inputs

Prefix:

i

Examples:

- iStart
- iStop
- iReset
- iEmergencyStop
- iRecipeID

---

# Outputs

Prefix:

q

Examples:

- qBlowerRun
- qSelectorMove
- qDosingRun
- qAlarm

---

# Internal Variables

Prefix:

x

Examples:

- xInitialized
- xBusy
- xFault
- xSequenceComplete

---

# Arrays

Use plural names.

Examples:

- recipes
- alarms
- users
- lines
- statistics

---

# Comments

Every Function Block shall begin with:

- Purpose
- Author
- Version
- Revision Date

Complex logic shall include explanatory comments.

---

# Prohibited Names

Avoid names such as:

- temp
- test
- value
- data
- var1
- newData
- abc

Every identifier shall clearly express its purpose.

---

# Revision

Version 1.0