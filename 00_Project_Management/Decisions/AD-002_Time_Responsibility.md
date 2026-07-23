# AD-002 - Time Responsibility

## Status

Accepted

---

## Date

2026-07-24

---

## Decision

The Desktop Application shall be the system time authority.

The PLC shall not calculate daily, weekly or monthly statistics.

---

## Reason

The Desktop uses the operating system clock and stores historical data in the database.

This avoids duplicated time calculations.

---

## Consequences

Removed from PLC

- TodayFeedKg
- TodayCycleCount
- Daily statistics

Desktop calculates

- Daily production
- Weekly production
- Monthly production
- Reports

---

## Related Documents

ST_Runtime.md

ST_OperationData.md