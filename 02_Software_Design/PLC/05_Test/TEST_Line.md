# TEST_Line

| Field | Value |
|---|---|
| Status | Authoritative test specification |
| Target | FB_LineManager, E_LineState, ST_Line, IF_Line |
| Version | 1.1 |

| ID | Test | Expected result |
|---|---|---|
| LIN-001 | Disabled line | state Off; all equipment requests removed |
| LIN-002 | Healthy enable | deterministic initialization reaches Ready |
| LIN-003 | Candidate with Desktop loss | rejected; no active job |
| LIN-004 | Invalid identity/version/CRC | rejected with bounded reason |
| LIN-005 | REAL-free unit bounds | centi-kg, permille, and centi-Hz values validated |
| LIN-006 | Dosing mask 01 or 02 | selected single unit accepted |
| LIN-007 | Dosing mask 00, 03, or unsupported bit | rejected; no equipment request |
| LIN-008 | Immutable acceptance | later candidate changes do not alter active values |
| LIN-009 | Selector sequence | Blower request remains false until accepted outlet confirmed |
| LIN-010 | Blower sequence | Dosing request remains false until AtSpeed/dosing permission and full pre-run |
| LIN-011 | Selected Dosing unit | only mask-selected unit receives Start and target |
| LIN-012 | Valid delivered increments | delivered/remaining/progress update once without wrap |
| LIN-013 | Target completion | Dosing stops before Blower normal-stop/post-run |
| LIN-014 | Pause | Dosing stops; progress and active snapshot preserved |
| LIN-015 | Resume | re-enters Selector and Blower verification; never direct Dosing |
| LIN-016 | Stop or Cancel | selected Dosing stops, bounded post-run completes, no success event |
| LIN-017 | Emergency/safety/blocking fault | Dosing request removed with highest priority; no Complete |
| LIN-018 | Desktop loss during healthy run | active job continues; no new job accepted |
| LIN-019 | Equipment fault | safe shutdown/fault; other line instances unaffected |
| LIN-020 | Reset with active cause | rejected |
| LIN-021 | Reset after cause removed | Ready; no automatic equipment restart |
| LIN-022 | Replay line command | no duplicate transition or event |
| LIN-023 | Completion event | emitted exactly one scan after safe sequence |
| LIN-024 | Time/counter boundary | wrap-safe elapsed checks; quantities saturate or fault, never wrap |
| LIN-025 | Replayed accepted or rejected transfer sequence | ignored; no second acceptance/rejection event |
| LIN-026 | Pause airflow policy | selected Dosing stops; Blower completes its accepted recipe post-run once; Paused follows safe stop |
| LIN-027 | Resume after Pause | Selector and Blower are revalidated and full pre-run is applied before remaining Dosing target |
| LIN-028 | Execution-time multiplication bound | maximum accepted seconds cannot overflow UDINT milliseconds |
| LIN-029 | Inactive status cleanup | active identifiers, targets, delivered quantity, and elapsed time return to zero after terminal event |
| LIN-030 | Fault reset with prior active job | active job is discarded and no automatic recovery/restart occurs |

## Gate

Implementation may begin only while this specification, `IF_Line`, `ST_Line`, `ST_JobExecution`, and `ST_RecipeExecution` use the same integer units and Dosing selection rule.
