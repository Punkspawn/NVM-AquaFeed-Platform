# TEST_Selector

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_Selector, E_SelectorState, IF_Selector |

| ID | Test | Expected result |
|---|---|---|
| SEL-001 | Valid homing | home confirmed; Ready |
| SEL-002 | Valid target | correct direction; settle; InPosition |
| SEL-003 | Target outside configured range | rejected without motion |
| SEL-004 | Both direction conditions attempted | outputs remain mutually exclusive |
| SEL-005 | Active directional limit | prohibited direction never energizes |
| SEL-006 | Position invalid during move | immediate stop; Fault |
| SEL-007 | Movement timeout | outputs off; stable diagnostic |
| SEL-008 | Position oscillates in tolerance | settle timer restarts; no early InPosition |
| SEL-009 | New target while moving | rejected; original target remains latched |
| SEL-010 | Replay command sequence | no second movement |
| SEL-011 | Safety loss | immediate logical stop request |
| SEL-012 | Manual jog without Service permission | rejected |
| SEL-013 | Jog exceeds maximum duration | output off; diagnostic |
| SEL-014 | Fault reset while cause active | rejected |
| SEL-015 | Power-up with unknown position | no movement until accepted home/move policy |
