# Function

FN_CalculateCommunicationAvailability

---

# Function

FN_CalculateCommunicationAvailability

---

# Purpose

Calculates the communication availability percentage by comparing the successful communication time with the total monitoring time.

This function is used to evaluate the reliability of PLC communications with drives, HMIs, remote I/O, sensors, and other Modbus devices.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CommunicationTime | TIME | Time during which communication was healthy |
| MonitoringTime | TIME | Total communication monitoring period |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication availability (%) |

---

# Formula

```text
CommunicationAvailability =
(CommunicationTime /
MonitoringTime)
× 100
```

---

# Logic

```text
VAR
    CommSeconds : REAL;
    MonitorSeconds : REAL;
END_VAR

CommSeconds := TIME_TO_REAL(CommunicationTime) / 1000.0;
MonitorSeconds := TIME_TO_REAL(MonitoringTime) / 1000.0;

IF MonitorSeconds <= 0.0 THEN

    Return := 0.0;

ELSIF CommSeconds < 0.0 THEN

    Return := 0.0;

ELSIF CommSeconds >= MonitorSeconds THEN

    Return := 100.0;

ELSE

    Return :=
        (CommSeconds * 100.0) /
        MonitorSeconds;

END_IF;
```

---

# Rules

- MonitoringTime shall be greater than zero.
- CommunicationTime shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- Availability greater than 100% shall be limited to 100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Communication availability (%) |
| CommunicationTime ≥ MonitoringTime | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Modbus communication monitoring
- Drive communication statistics
- Remote I/O diagnostics
- HMI communication health monitoring
- Network reliability reporting
- System KPI calculations

---

# Used By

- FB_ModbusMaster
- FB_CommunicationManager
- FB_SystemManager
- FB_ReportManager
- FB_HMIManager

---

# Test Cases

| Communication Time | Monitoring Time | Expected |
|-------------------|-----------------|---------:|
| 59 min | 60 min | 98.33% |
| 60 min | 60 min | 100% |
| 30 min | 60 min | 50% |
| 0 min | 60 min | 0% |
| 30 min | 0 min | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only communication availability.

It does not:

- Detect communication faults
- Retry failed communications
- Reset communication devices
- Generate communication alarms
- Store diagnostic history
- Generate reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsCommunicationHealthy.md
- FN_CalculateAvailability.md
- FN_CalculateSystemUtilization.md
- FB_CommunicationManager.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0