# NVM AquaFeed Platform
# NAMING CONVENTIONS

---

# Purpose

This document defines the naming conventions used throughout the NVM AquaFeed Platform.

Every software component must follow these standards.

Consistency is more important than personal preference.

---

# Language

All identifiers shall be written in English.

Documentation may be written in Turkish or English.

Never mix Turkish variable names into the source code.

---

# General Rules

Use PascalCase for

- Function Blocks
- Structures
- Enums
- Classes
- Interfaces
- Methods

Use camelCase only where required by the programming language.

Avoid abbreviations unless they are industry standard.

---

# Function Block Naming

Format

FB_<Name>

Examples

FB_LineManager

FB_Blower

FB_Dosing

FB_RecipeManager

FB_SystemManager

Do not use

FB_Test

FB_New

FB_Manager2

---

# Structure Naming

Format

ST_<Name>

Examples

ST_Line

ST_Recipe

ST_Alarm

ST_Runtime

---

# Enumeration Naming

Format

E_<Name>

Examples

E_LineState

E_SystemMode

E_AlarmLevel

E_UserRole

---

# Interface Naming

Format

I<Name>

Examples

ICommunication

ILogger

IDataStorage

---

# Function Naming

Format

Verb + Object

Examples

StartMotor()

StopMotor()

LoadRecipe()

SaveConfiguration()

CalculateFeed()

GenerateReport()

Avoid

DoWork()

Run()

Execute()

---

# Variable Naming

Use meaningful names.

Examples

CurrentRecipe

SelectedLine

MotorSpeed

AlarmCode

RuntimeHours

ConnectionState

Avoid

Temp

Data

Value

Var1

Test

---

# Boolean Variables

Begin with

Is

Has

Can

Should

Examples

IsRunning

IsConnected

HasAlarm

CanStart

ShouldStop

---

# Constant Naming

Use uppercase with underscore.

Examples

MAX_LINES

DEFAULT_TIMEOUT

MAX_SPEED

MIN_PRESSURE

---

# Global Variables

Prefix

g_

Examples

g_SystemStatus

g_CurrentRecipe

g_TotalRuntime

---

# Local Variables

Use descriptive names.

Avoid prefixes unless required.

---

# IO Variables

Digital Inputs

DI_

Examples

DI_EmergencyStop

DI_StartButton

DI_StopButton

Digital Outputs

DO_

Examples

DO_Blower

DO_MainMotor

DO_AlarmLamp

Analog Inputs

AI_

Examples

AI_Pressure

AI_Current

AI_Level

Analog Outputs

AO_

Examples

AO_InverterSpeed

---

# Modbus Registers

Holding Registers

HR_

Input Registers

IR_

Coils

CO_

Discrete Inputs

DI_

Examples

HR_RecipeID

HR_FeedAmount

HR_Runtime

CO_Start

CO_Stop

---

# Alarm Naming

Format

ALM_<Description>

Examples

ALM_EmergencyStop

ALM_MotorOverload

ALM_ModbusTimeout

ALM_LowPressure

---

# Recipe Naming

Recipe names should be human-readable.

Examples

Starter Feed

Grower Feed

Finisher Feed

Maintenance Feed

---

# Database Tables

Use singular nouns.

Examples

Recipe

FeedHistory

AlarmHistory

Maintenance

Configuration

User

---

# Primary Keys

Format

Id

Examples

RecipeId

AlarmId

UserId

HistoryId

---

# Date Fields

Examples

CreatedAt

UpdatedAt

StartedAt

FinishedAt

---

# Time Fields

Examples

StartTime

StopTime

ElapsedTime

CycleTime

---

# File Names

Use PascalCase.

Examples

FB_LineManager.md

FB_Blower.md

ST_Recipe.md

CommunicationManager.cs

DashboardView.xaml

---

# Folder Names

Keep folder names stable.

Do not rename folders unless absolutely necessary.

---

# Final Rule

If a name cannot be understood immediately by another engineer,

rename it.