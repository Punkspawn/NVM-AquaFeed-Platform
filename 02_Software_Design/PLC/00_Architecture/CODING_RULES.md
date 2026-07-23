# NVM AquaFeed Platform
# CODING RULES

---

# Purpose

This document defines the coding standards used throughout the entire NVM AquaFeed Platform.

All generated code must comply with these rules.

The objective is consistency, readability, maintainability, and production-quality software.

---

# General Principles

Always write code that is

- Simple
- Readable
- Maintainable
- Modular
- Predictable

Never sacrifice readability for cleverness.

---

# SOLID Principle

Follow SOLID principles whenever applicable.

Avoid unnecessary inheritance.

Prefer composition over complexity.

---

# Keep It Simple

Always choose the simplest solution that satisfies the requirement.

Avoid unnecessary abstractions.

Avoid premature optimization.

---

# Don't Repeat Yourself

Never duplicate logic.

If the same logic appears multiple times, move it into a reusable module.

---

# Single Responsibility

Every module should have one primary responsibility.

One FB

One task.

One function

One purpose.

---

# PLC Rules

PLC code must be deterministic.

Avoid unnecessary loops.

Avoid recursive logic.

Avoid blocking execution.

Cycle time must remain predictable.

---

# Function Blocks

Use existing Function Blocks whenever possible.

Do not create new FBs without a clear reason.

Never duplicate an existing FB.

---

# Variable Naming

Variable names must clearly describe their purpose.

Avoid abbreviations unless they are industry standard.

Good

MotorSpeed

FeedingTime

AlarmCode

CurrentRecipe

Bad

A

B

TMP

VAR1

TEST

---

# Boolean Naming

Boolean variables should answer a question.

Examples

IsRunning

IsReady

IsConnected

HasAlarm

IsManualMode

CanStart

---

# Constants

Never hard-code magic numbers.

Use named constants.

Example

MAX_SPEED

DEFAULT_TIMEOUT

MAX_RECIPES

---

# Comments

Write comments only when necessary.

Good code should explain itself.

Do not comment obvious code.

Explain why.

Not what.

---

# Error Handling

Every error must

- be detected
- be logged
- generate an alarm if necessary
- recover safely whenever possible

Never ignore an error.

---

# Logging

Log only meaningful events.

Examples

Machine Started

Recipe Loaded

Alarm Triggered

Emergency Stop

Connection Lost

Maintenance Reset

Avoid excessive logging.

---

# Communication

Validate every received value.

Never trust external devices.

Handle timeout conditions.

Detect communication loss.

Recover safely.

---

# Safety

Safety always has priority over production.

Unsafe operations must never execute.

Emergency conditions must immediately stop dangerous actions.

---

# Performance

Readable code comes first.

Optimize only when necessary.

Measure before optimizing.

---

# Desktop Software

Separate

UI

Business Logic

Database

Communication

Reporting

Each layer must remain independent.

---

# Database

Never store duplicated data.

Use clear table names.

Maintain referential integrity.

Store timestamps whenever appropriate.

---

# Version Control

Every significant change should be traceable.

Avoid breaking compatibility unless necessary.

---

# AI Code Generation

When generating code

Prefer implementation over explanation.

Generate complete code whenever possible.

Avoid placeholder implementations.

Avoid pseudo-code unless explicitly requested.

---

# Final Rule

Always produce software that another engineer can understand, maintain and extend years later.

Production quality is always the goal.