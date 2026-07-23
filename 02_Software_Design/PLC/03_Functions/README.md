# PLC Functions

---

# Purpose

This directory contains all reusable PLC Functions used throughout the AquaFeed Platform.

Unlike Function Blocks (FB), Functions do not contain persistent internal memory. They perform deterministic calculations, conversions, validations or utility operations and immediately return a result.

Functions are intended to eliminate duplicate code and provide standardized behavior across all software modules.

---

# Function Characteristics

All Functions shall:

- Be deterministic.
- Produce the same output for the same input.
- Execute within a single PLC scan.
- Contain no retentive variables.
- Have no internal state.
- Be reusable by any Function Block.

---

# Typical Usage

Functions are used for:

- Mathematical calculations
- Unit conversions
- Range validation
- Alarm evaluation
- Runtime calculations
- CRC calculations
- String manipulation
- Date & time calculations
- Modbus utilities
- Engineering calculations

---

# Directory Structure

Typical function categories include:

- Validation Functions
- Conversion Functions
- Mathematical Functions
- Communication Functions
- Utility Functions
- Runtime Functions

---

# Naming Convention

All functions shall use the following naming format:

```text
FN_<FunctionName>
```

Examples:

- FN_CheckRange
- FN_LimitValue
- FN_CalculateFeedAmount
- FN_CRC16
- FN_IsTimeout
- FN_SecondsToTime

---

# Design Rules

Functions shall:

- Have a single responsibility.
- Avoid side effects.
- Never modify global variables.
- Never access hardware directly.
- Never generate alarms directly.
- Return clear and predictable outputs.

---

# Documentation Standard

Every Function document shall include:

- Purpose
- Inputs
- Outputs
- Processing Logic
- Return Value
- Usage Example
- Used By
- Revision

---

# Related Directories

- 01_Function_Blocks
- 02_Structures
- 04_Interfaces
- 05_Test

---

# Revision

Version 1.0