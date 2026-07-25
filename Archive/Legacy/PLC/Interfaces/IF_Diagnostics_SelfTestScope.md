# IF_Diagnostics

---

# Purpose

Defines the standard software interface for system diagnostics.

This interface provides a unified method for monitoring the operational health of PLC modules, communication devices and machine components. It is intended for maintenance personnel, service software and the AquaFeed Manager.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Enable | BOOL | Enables diagnostic monitoring. |
| StartTest | BOOL | Starts a diagnostic test. |
| StopTest | BOOL | Stops the active diagnostic test. |
| Reset | BOOL | Clears diagnostic results and active faults. |
| ModuleID | UINT | Identifier of the module to test. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| Ready | BOOL | Diagnostic system is ready. |
| TestRunning | BOOL | Diagnostic test is in progress. |
| TestPassed | BOOL | Test completed successfully. |
| TestFailed | BOOL | Test failed. |
| Fault | BOOL | Diagnostic fault detected. |
| DiagnosticCode | UINT | Diagnostic result code. |
| AlarmCode | UINT | Active diagnostic alarm code. |

---

# State Flow

```text
Idle
   │
StartTest
   │
Testing
   │
Passed / Failed
   │
Ready
```

Reset sequence

```text
Passed / Failed
        │
Reset
        │
Idle
```

Fault sequence

```text
Any State
    │
Fault
    │
Reset
    │
Idle
```

---

# Rules

- Only one diagnostic test shall run at a time.
- A diagnostic test shall not interrupt an active feeding cycle unless explicitly requested by the operator.
- Diagnostic results shall remain available until reset.
- Every failed test shall generate a valid `DiagnosticCode`.
- `AlarmCode` shall be zero when no diagnostic alarm is active.

---

# Used By

- FB_DiagnosticsManager
- FB_SystemManager
- FB_ModbusMaster
- FB_LineManager
- FB_Blower
- FB_Dosing
- HMI
- AquaFeed Manager
- Service Software