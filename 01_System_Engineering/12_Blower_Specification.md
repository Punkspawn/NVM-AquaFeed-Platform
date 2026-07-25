# Blower Specification

| Field | Value |
|---|---|
| Document ID | AQ-BLW-012 |
| Status | Approved baseline |
| Version | 2.0 |
| Responsibility | Generate transport airflow before and during dosing |

## Hardware Baseline

| Item | Baseline |
|---|---|
| Blower supplier | TMM |
| Motor | 22 kW, three-phase AC induction motor |
| Supply class | 380–480 V AC |
| Default drive | Delta C2000 Plus, panel-mounted |
| Drive sizing | Heavy-duty output current shall be at least the motor nameplate current |
| PLC communication | Modbus RTU, PLC sole master |
| Safety | Hardwired protection remains independent of PLC and Modbus |

The final C2000 Plus order code is selected from the approved motor nameplate current, supply voltage, enclosure arrangement, and regional catalog. The motor/blower nameplate and TMM operating envelope remain the commissioning authority.

## Architectural Boundary

`FB_Blower` is vendor-independent. It consumes only normalized VFD feedback and produces normalized Run and frequency requests.

The C2000 Plus device profile owns:

- vendor register addresses and control-word encoding
- frequency scaling and byte/word order
- drive status and fault-code decoding
- bounded poll, timeout, and retry behavior
- the conversion between C2000 Plus data and `IF_Blower`

Changing the VFD model replaces the approved device profile and commissioning parameters; it does not replace the blower state machine.

## Required Normalized Signals

### PLC to drive profile

- Run request
- frequency reference in 0.01 Hz
- approved reset pulse where permitted by the electrical design

### Drive profile to PLC

- drive ready
- drive running
- drive fault
- actual frequency in 0.01 Hz
- bounded drive fault code
- communication freshness/health

Motor current may be published for diagnostics, but it does not bypass drive protection or directly grant dosing permission.

## Operating Sequence

1. Selector reaches its accepted position.
2. Blower command and target frequency are validated and latched.
3. The drive starts and accelerates within bounded time.
4. Actual frequency remains within tolerance for the complete stable interval.
5. Only then may `xDosingPermitted` become true.
6. After normal dosing completion, the blower runs for the configured post-run interval.
7. Run is removed and stopped feedback is verified within timeout.

Safety loss, drive fault, or critical VFD communication loss removes Run immediately and bypasses post-run. Reset never restarts the blower automatically.

## Commissioning Parameters

The following values are approved during TMM blower and motor commissioning rather than compiled as model-specific constants:

- minimum and maximum operating frequency
- target frequency
- acceleration time; initial engineering range 15–30 s
- deceleration or coast-stop method
- AtSpeed tolerance and stable time
- start, acceleration, feedback-loss, stop, and communication timeouts
- post-run time and maximum permitted post-run
- TMM minimum-speed, pressure/vacuum, relief-valve, and thermal constraints

For a lobed/positive-displacement blower, constant-torque capability and the manufacturer minimum-speed limit are mandatory. A side-channel blower may use a variable-torque profile only after the exact blower curve is approved.

## Acceptance Criteria

- no dosing before stable airflow permission
- frequencies outside the commissioned range are rejected
- command replay cannot create another start
- normal completion always receives bounded post-run
- critical faults remove Run without waiting for post-run
- PC loss does not stop an already accepted healthy PLC-controlled job
- VFD communication loss removes dosing permission and Run
- fault reset requires the cause removed and produces no automatic restart
