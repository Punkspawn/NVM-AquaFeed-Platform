# FB_DeviceManager

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Responsibility | Runtime state of one physical device |
| Version | 1.1 |
| Governing boundary | [System Boundary](../../../00_Project_Management/SYSTEM_BOUNDARY.md) |

---

## Purpose

`FB_DeviceManager` is the single owner of the runtime state of one physical device.

The block converts configuration, commands, feedback signals and interlocks into a consistent `ST_Device` state that can be read by line control, system control, HMI and the Desktop Application.

The block does not directly implement equipment-specific motion logic. Blower, selector, dosing and other equipment blocks remain responsible for their own physical control sequences.

---

## Scope

One instance of `FB_DeviceManager` shall manage one instance of `ST_Device`.

Typical managed devices include:

- Blower
- Selector
- Dosing motor
- Air lock
- Conveyor
- Auxiliary motor

---

## Responsibilities

`FB_DeviceManager` shall:

- Initialize the device runtime state.
- Apply the configured enable state.
- Validate automatic and manual mode requests.
- Calculate device availability.
- Publish running and fault feedback.
- Reject invalid or conflicting commands.
- Enforce common device-level rules.
- Provide a deterministic state for higher-level managers.

`FB_DeviceManager` shall not:

- Write physical outputs directly.
- Execute equipment-specific start or stop sequences.
- Store historical data.
- Generate user-facing alarm text.
- Replace safety circuits or equipment interlocks.

---

## Data Ownership

`FB_DeviceManager` is the only block allowed to modify its assigned `ST_Device` instance.

Other modules shall treat `ST_Device` as read-only.

```text
Configuration + Commands + Feedback + Interlocks
                     │
                     ▼
              FB_DeviceManager
                     │
                     ▼
                 ST_Device
                     │
       ┌─────────────┼─────────────┐
       ▼             ▼             ▼
 FB_LineManager  FB_SystemManager  HMI/Desktop
```

---

## Interface

### Inputs

```iecst
FUNCTION_BLOCK FB_DeviceManager
VAR_INPUT
    xEnableConfig       : BOOL;
    xAutoRequest        : BOOL;
    xManualRequest      : BOOL;
    xRunFeedback        : BOOL;
    xFaultFeedback      : BOOL;
    xInterlockOK        : BOOL;
    xCommunicationOK    : BOOL;
    xReset              : BOOL;
END_VAR
```

### In-Out Data

```iecst
VAR_IN_OUT
    stDevice            : ST_Device;
END_VAR
```

### Outputs

```iecst
VAR_OUTPUT
    xReady              : BOOL;
    xCommandConflict    : BOOL;
END_VAR
```

### Internal Variables

```iecst
VAR
    xInitialized        : BOOL;
    xAvailableInternal  : BOOL;
END_VAR
```

---

## Input Definitions

### xEnableConfig

Configuration-level permission for the device to participate in operation.

When `FALSE`, the device shall not be considered available and shall not be allowed to run.

### xAutoRequest

Requests automatic mode for the device.

The request is accepted only when no manual-mode request is active.

### xManualRequest

Requests manual mode for the device.

The request is accepted only when no automatic-mode request is active.

### xRunFeedback

Actual running feedback received from the equipment-specific Function Block or field feedback.

This signal shall represent confirmed operation, not merely a start command.

### xFaultFeedback

Aggregated fault status received from the equipment-specific Function Block.

Detailed alarms remain the responsibility of equipment logic and `FB_AlarmManager`.

### xInterlockOK

Indicates that all operational interlocks required for common device availability are satisfied.

### xCommunicationOK

Indicates that required communication with the device is healthy.

For hardwired devices without communication dependency, this input may be permanently `TRUE`.

### xReset

Resets transient manager diagnostics such as command-conflict indication.

This input shall not bypass an active physical fault.

---

## Output Definitions

### xReady

Indicates that the device is enabled, available, fault-free and assigned to exactly one operating mode.

### xCommandConflict

Indicates that automatic and manual modes were requested simultaneously.

When a conflict exists, both mode outputs in `ST_Device` shall be forced to `FALSE`.

---

## Availability Rule

The common availability state is calculated as:

```text
Available = Enabled
            AND InterlockOK
            AND CommunicationOK
            AND NOT Fault
```

Equipment-specific conditions may be combined into `xInterlockOK` by the corresponding equipment Function Block.

---

## Mode Arbitration

The block shall apply the following priority-neutral arbitration:

| Auto request | Manual request | AutoMode | ManualMode | Conflict |
|---:|---:|---:|---:|---:|
| 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 0 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 | 1 |

The manager shall not silently select one mode when both are requested.

---

## Execution Logic

The block shall execute in the following order during every PLC scan:

1. Initialize runtime values on first execution.
2. Copy configuration enable state.
3. Copy physical or equipment fault feedback.
4. Arbitrate automatic and manual mode requests.
5. Calculate availability.
6. Validate running feedback against common rules.
7. Calculate ready state.
8. Publish diagnostics.

---

## IEC 61131-3 Structured Text Reference Implementation

```iecst
FUNCTION_BLOCK FB_DeviceManager
VAR_INPUT
    xEnableConfig       : BOOL;
    xAutoRequest        : BOOL;
    xManualRequest      : BOOL;
    xRunFeedback        : BOOL;
    xFaultFeedback      : BOOL;
    xInterlockOK        : BOOL;
    xCommunicationOK    : BOOL;
    xReset              : BOOL;
END_VAR

VAR_IN_OUT
    stDevice            : ST_Device;
END_VAR

VAR_OUTPUT
    xReady              : BOOL;
    xCommandConflict    : BOOL;
END_VAR

VAR
    xInitialized        : BOOL;
    xAvailableInternal  : BOOL;
END_VAR

// One-time runtime initialization
IF NOT xInitialized THEN
    stDevice.Enabled    := FALSE;
    stDevice.Available  := FALSE;
    stDevice.Running    := FALSE;
    stDevice.Fault      := FALSE;
    stDevice.AutoMode   := FALSE;
    stDevice.ManualMode := FALSE;

    xCommandConflict    := FALSE;
    xInitialized        := TRUE;
END_IF;

// Configuration and feedback
stDevice.Enabled := xEnableConfig;
stDevice.Fault   := xFaultFeedback;

// Mode arbitration
xCommandConflict := xAutoRequest AND xManualRequest;

IF xCommandConflict THEN
    stDevice.AutoMode   := FALSE;
    stDevice.ManualMode := FALSE;
ELSE
    stDevice.AutoMode   := xAutoRequest;
    stDevice.ManualMode := xManualRequest;
END_IF;

// Availability calculation
xAvailableInternal := stDevice.Enabled
                      AND xInterlockOK
                      AND xCommunicationOK
                      AND NOT stDevice.Fault;

stDevice.Available := xAvailableInternal;

// Running is accepted only while the device is enabled.
// Unexpected feedback may later be promoted to a dedicated alarm.
stDevice.Running := xRunFeedback AND stDevice.Enabled;

// Ready requires one valid selected mode.
xReady := stDevice.Available
          AND (stDevice.AutoMode XOR stDevice.ManualMode)
          AND NOT xCommandConflict;

IF xReset THEN
    xCommandConflict := FALSE;
END_IF;
```

---

## Invariants

The following conditions shall always remain true:

```text
NOT (AutoMode AND ManualMode)

Running -> Enabled

Available -> Enabled

Available -> NOT Fault

Ready -> Available
```

An equipment-specific block may impose stricter rules but shall not violate these common invariants.

---

## Call Order

Recommended cyclic execution order:

```text
1. Read field inputs and communication data
2. Execute equipment-specific Function Block
3. Execute FB_DeviceManager
4. Execute FB_LineManager
5. Execute FB_SystemManager
6. Update HMI and Modbus publication data
7. Write physical outputs
```

The equipment-specific Function Block supplies confirmed feedback and aggregated interlock state to `FB_DeviceManager`.

---

## Example Instance

```iecst
VAR
    fbBlowerDeviceManager : FB_DeviceManager;
    stBlowerDevice        : ST_Device;
END_VAR

fbBlowerDeviceManager(
    xEnableConfig      := g_Config.BlowerEnabled,
    xAutoRequest       := g_Command.BlowerAutoMode,
    xManualRequest     := g_Command.BlowerManualMode,
    xRunFeedback       := fbBlower.xRunning,
    xFaultFeedback     := fbBlower.xFault,
    xInterlockOK       := fbBlower.xInterlockOK,
    xCommunicationOK   := fbBlower.xCommunicationOK,
    xReset             := g_Command.Reset,
    stDevice           := stBlowerDevice,
    xReady             => g_Status.BlowerReady,
    xCommandConflict   => g_Diagnostics.BlowerModeConflict
);
```

---

## Fault and Alarm Integration

`FB_DeviceManager` publishes common diagnostic conditions but does not create localized alarm messages.

Recommended alarm mapping:

| Condition | Alarm source |
|---|---|
| Auto and manual request conflict | `FB_DeviceManager` diagnostic |
| Communication loss | Equipment FB or communication manager |
| Physical drive fault | Equipment FB |
| Interlock not satisfied | Equipment FB |
| Device unavailable | Derived status; alarm only when operation is requested |

`FB_AlarmManager` shall convert these conditions into alarm records and identifiers.

---

## Test Cases

Minimum unit tests:

1. Disabled device is not available.
2. Enabled healthy device becomes available.
3. Active fault removes availability.
4. Communication loss removes availability.
5. Failed interlock removes availability.
6. Auto request selects only automatic mode.
7. Manual request selects only manual mode.
8. Simultaneous mode requests select neither mode and raise conflict.
9. Running feedback is rejected when the device is disabled.
10. Ready is true only when the device is available and exactly one mode is selected.

---

## Dependencies

- `ST_Device`
- `E_DeviceType`
- Equipment-specific Function Blocks
- `FB_LineManager`
- `FB_SystemManager`
- `FB_AlarmManager`

---

## Architectural Exclusions

Platform-wide asset registry, discovery, provisioning, firmware inventory, long-term lifecycle records, database storage, and fleet management are not PLC responsibilities. Those concepts are retained only in the [legacy asset-registry specification](../../../../Archive/Legacy/PLC/Function_Blocks/98_FB_DeviceManager_AssetRegistry.md) for future Desktop/Edge design work.

---

## Related Documents

- `../02_Structures/ST_Device.md`
- `FB_LineManager.md`
- `FB_AlarmManager.md`
- `../00_Architecture/EXECUTION_FLOW.md`
- `../00_Architecture/DEVICE_LIFECYCLE.md`

---

## Revision History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-24 | Initial deterministic device manager design. |
| 1.1 | 2026-07-25 | Declared authoritative PLC ownership and excluded platform asset-registry responsibilities. |
