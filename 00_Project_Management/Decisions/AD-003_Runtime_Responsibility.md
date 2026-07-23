# AD-003 - Runtime Responsibility

## Status

Accepted

---

## Date

2026-07-24

---

## Decision

The PLC shall maintain lifetime runtime information only.

Historical runtime analysis belongs to the Desktop Application.

---

## Reason

Lifetime counters must survive power loss.

Historical analysis is database-oriented and should not be implemented inside the PLC.

---

## Consequences

PLC stores

- TotalFeedKg
- TotalRuntime
- TotalCycleCount

Desktop stores

- History
- Reports
- Statistics
- Charts

---

## Related Documents

ST_Runtime.md