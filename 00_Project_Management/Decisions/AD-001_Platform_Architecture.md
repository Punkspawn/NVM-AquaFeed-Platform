# AD-001 - Platform Architecture

## Status

Accepted

---

## Date

2026-07-24

---

## Decision

The NVM AquaFeed Platform shall be divided into independent layers.

Platform

↓

Desktop Application

↓

Modbus Communication

↓

PLC

↓

Machine

Each layer has its own responsibilities.

---

## Reason

Separating responsibilities makes the software easier to maintain, test and extend.

It also prevents business logic from leaking into the PLC.

---

## Consequences

Desktop is responsible for:

- Database
- Reports
- Users
- Job Orders
- Historical Data
- Statistics

PLC is responsible for:

- Machine control
- Runtime control
- Safety
- IO
- Communication
- Runtime counters

---

## Related Documents

SYSTEM_ARCHITECTURE.md

SYSTEM_SPECIFICATION.md

PROJECT_STATE.md