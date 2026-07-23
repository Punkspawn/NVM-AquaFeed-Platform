# PLC Test Documentation Index

---

# Purpose

This document provides an index of all PLC verification documents included in the AquaFeed Platform test package.

It serves as the entry point for verification, validation, commissioning and customer acceptance activities.

---

# Unit Tests

| Document | Description |
|----------|-------------|
| TEST_SystemManager.md | System state management |
| TEST_LineManager.md | Feeding line management |
| TEST_Selector.md | Selector positioning |
| TEST_Blower.md | Blower control |
| TEST_Dosing.md | Dosing control |
| TEST_FeedingControlManager.md | Automatic feeding sequence |
| TEST_RecipeManager.md | Recipe management |
| TEST_JobManager.md | Job scheduling and execution |
| TEST_AlarmManager.md | Alarm handling |
| TEST_RuntimeManager.md | Runtime statistics |
| TEST_MaintenanceManager.md | Maintenance management |
| TEST_ModbusMaster.md | Modbus RTU communication |
| TEST_UserManager.md | User authentication and authorization |
| TEST_ReportManager.md | Report generation |
| TEST_IO.md | Digital and analog I/O verification |
| TEST_Diagnostics.md | Diagnostic functions |
| TEST_Communication.md | Communication interfaces |

---

# Integration Tests

| Document | Description |
|----------|-------------|
| TEST_SystemIntegration.md | Complete PLC integration |
| TEST_Safety.md | Safety verification |
| TEST_Recovery.md | Recovery procedures |
| TEST_Performance.md | Performance verification |
| TEST_Stress.md | Stress testing |

---

# Acceptance Tests

| Document | Description |
|----------|-------------|
| TEST_FAT.md | Factory Acceptance Test |
| TEST_SAT.md | Site Acceptance Test |
| TEST_Commissioning.md | Commissioning verification |
| TEST_Regression.md | Regression testing |
| TEST_Validation.md | Final validation |
| TEST_Traceability.md | Requirement traceability matrix |

---

# Recommended Execution Order

| Step | Document |
|------|----------|
| 1 | TEST_IO.md |
| 2 | TEST_SystemManager.md |
| 3 | TEST_LineManager.md |
| 4 | TEST_Selector.md |
| 5 | TEST_Blower.md |
| 6 | TEST_Dosing.md |
| 7 | TEST_ModbusMaster.md |
| 8 | TEST_Communication.md |
| 9 | TEST_RecipeManager.md |
| 10 | TEST_JobManager.md |
| 11 | TEST_FeedingControlManager.md |
| 12 | TEST_RuntimeManager.md |
| 13 | TEST_MaintenanceManager.md |
| 14 | TEST_AlarmManager.md |
| 15 | TEST_Diagnostics.md |
| 16 | TEST_SystemIntegration.md |
| 17 | TEST_Performance.md |
| 18 | TEST_Stress.md |
| 19 | TEST_Recovery.md |
| 20 | TEST_Safety.md |
| 21 | TEST_FAT.md |
| 22 | TEST_SAT.md |
| 23 | TEST_Commissioning.md |
| 24 | TEST_Regression.md |
| 25 | TEST_Validation.md |
| 26 | TEST_Traceability.md |

---

# Release Criteria

The PLC software may be released only after:

- All Unit Tests have passed.
- All Integration Tests have passed.
- FAT has been approved.
- SAT has been approved.
- Validation has been completed.
- Traceability coverage is complete.
- No Critical or High severity defects remain open.

---

# Document Revision

Version 1.0