# IF_Service

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | FB_SystemManager |
| Version | 1.0 |

## Purpose

Defines the bounded PLC permission and status contract for service mode. It does not implement users, passwords, roles, sessions, or direct physical output writes.

## Commands

| Name | Type | Rule |
|---|---|---|
| RequestEnter | BOOL | Rising-edge request to enter service mode |
| RequestExit | BOOL | Rising-edge request to leave service mode |
| AuthorizationGranted | BOOL | Trusted external authorization result; no credentials are stored in PLC |
| ResetFault | BOOL | Rising-edge request; cannot bypass active safety or interlocks |

## Preconditions

Service mode may become active only when all are true:

- the system is stopped and no line has an active job
- hardwired safety and `FB_SafetyCoordinator` permit operation
- `AuthorizationGranted` is true
- no automatic equipment request is active
- the request is accepted by `FB_SystemManager`

## Status

| Name | Type | Meaning |
|---|---|---|
| Active | BOOL | Service mode is active |
| ManualPermission | BOOL | Manual equipment commands may be evaluated |
| AutomaticInhibited | BOOL | Automatic execution is blocked |
| RequestRejected | BOOL | Latest enter request failed validation |
| RejectReason | UINT | Stable reason code; zero when none |

## Ownership

- `FB_SystemManager` owns service-mode entry, exit, and automatic inhibition.
- Selector, Blower, and Dosing accept manual commands only through their authoritative interfaces and only while `ManualPermission` is true.
- `FB_IOManager` remains the sole physical-output writer and applies safety arbitration.
- Desktop/HMI owns authentication, users, roles, sessions, and audit attribution.

## Fail-Closed Rules

- loss of authorization, safety permission, or PLC restart clears `ManualPermission`
- exit or fault removes all manual requests before automatic mode can be selected
- service mode never overrides hardwired safety, interlocks, feedback validation, timeouts, or safe output removal
- direct digital/analog output forcing is an engineering commissioning function outside this runtime interface
- leaving service mode never starts or resumes an automatic job
