# Coding Standard

---

# Purpose

This document defines the coding standards for the AquaFeed PLC software.

Following these standards ensures that all software remains readable, deterministic, maintainable and suitable for long-term industrial operation.

---

# General Principles

Every line of PLC code shall be:

- Readable
- Deterministic
- Modular
- Maintainable
- Testable
- Well documented

Code shall prioritize reliability over brevity.

---

# Software Architecture

The application shall follow a layered architecture.

Execution order:

1. Input Acquisition
2. Input Validation
3. Safety Processing
4. State Machines
5. Equipment Control
6. Process Logic
7. Alarm Processing
8. Runtime Statistics
9. Communication
10. Output Update

No layer shall bypass a previous layer.

---

# Function Block Rules

Every Function Block shall have:

- Single responsibility
- Defined interface
- Internal state machine
- Error handling
- Diagnostic support

Function Blocks shall never directly access another FB's internal variables.

Communication shall occur only through interfaces.

---

# Code Length

Recommended limits:

- Function Block: < 500 lines
- Function: < 150 lines
- CASE branch: < 50 lines
- IF block: < 30 lines

Large blocks shall be divided into smaller reusable modules.

---

# Nesting Depth

Maximum recommended nesting:

- IF statements: 3 levels
- CASE statements: 2 levels
- Loops: 2 levels

Deep nesting shall be replaced with helper Functions or Function Blocks.

---

# State Machine Implementation

Preferred structure:

```text
CASE CurrentState OF

    Disabled:

    Ready:

    Starting:

    Running:

    Paused:

    Stopping:

    Fault:

END_CASE;
```

Each state shall:

- Validate inputs
- Execute only its own logic
- Define valid transition conditions
- Never modify unrelated states

---

# Boolean Logic

Boolean expressions shall remain simple.

Preferred:

```text
IF isReady AND startRequest THEN
```

Avoid:

```text
IF (((A AND B) OR C) AND NOT D) THEN
```

Complex expressions shall be separated into intermediate variables.

---

# Timers

Timers shall:

- Be clearly named
- Have documented timeout values
- Reset after successful completion
- Never remain active unintentionally

Example:

```text
tmSelectorTimeout
tmBlowerStartup
tmCommunication
```

---

# Error Handling

Every detected fault shall:

- Stop the affected process safely
- Generate an AlarmCode
- Update diagnostics
- Log the event
- Prevent unsafe restart

Silent failures are prohibited.

---

# Communication Rules

Communication shall never directly control outputs.

Every received value shall be:

- Validated
- Range checked
- Type checked
- Timestamped if required

Invalid data shall be rejected.

---

# Retentive Data

Retain only information required after power loss.

Examples:

- Recipes
- Runtime counters
- Maintenance counters
- User database
- Production statistics

Do not retain temporary process values.

---

# Memory Usage

Avoid:

- Duplicate variables
- Unused variables
- Large temporary arrays
- Repeated calculations inside every scan

Reuse existing structures whenever possible.

---

# Comments

Every Function Block shall begin with:

- Purpose
- Inputs
- Outputs
- Description
- Author
- Version
- Revision Date

Complex algorithms shall include explanatory comments.

Comments shall explain **why**, not **what**.

---

# Code Review Checklist

Before release, verify:

- Naming Convention followed
- No compiler warnings
- No unused variables
- No unreachable code
- State machine verified
- Error handling implemented
- Documentation updated
- Unit tests passed

---

# Revision

Version 1.0