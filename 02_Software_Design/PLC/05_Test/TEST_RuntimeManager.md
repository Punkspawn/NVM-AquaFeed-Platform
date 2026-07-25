# TEST_RuntimeCounter

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_RuntimeCounter, ST_Runtime, IF_Runtime |

| ID | Test | Expected result |
|---|---|---|
| RUN-001 | 600 validated powered ticks | TotalPoweredSec increases by 600 |
| RUN-002 | Ready/Feeding/Paused/Fault/Service ticks | Exactly one state bucket increases per tick |
| RUN-003 | Duplicate tick/event sequence | Counted once |
| RUN-004 | Completed job with 123.45 kg | TotalFeedCentiKg increases by 12345; job count +1 |
| RUN-005 | Power cycle | Retentive values restored |
| RUN-006 | Desktop clock change | No runtime effect |
| RUN-007 | Daily boundary | PLC counters continue; no daily reset |
| RUN-008 | Normal reset attempt | Lifetime counters unchanged |
| RUN-009 | Near-maximum counter | Saturates; diagnostic raised; no wrap |
| RUN-010 | Compare external monotonic reference | Accuracy within approved tick tolerance |

Desktop tests separately verify daily/weekly/monthly aggregation from persisted events.
