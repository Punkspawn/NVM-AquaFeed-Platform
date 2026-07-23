# Function

FN_CalculateNetworkAvailability

---

# Function

FN_CalculateNetworkAvailability

---

# Purpose

Calculates the percentage of time that the communication network remained operational during the observation period.

This KPI is commonly used to evaluate industrial network uptime and verify communication service level objectives.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| NetworkUptime | REAL | Total network operational time (seconds) |
| ObservationTime | REAL | Total observation period (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Network availability (%) |

---

# Formula

```text
NetworkAvailability =
(NetworkUptime /
ObservationTime)
× 100
```

---

# Logic

```text
IF NetworkUptime < 0.0 THEN

    Return := 0.0;

ELSIF ObservationTime <= 0.0 THEN

    Return := 0.0;

ELSIF NetworkUptime >= ObservationTime THEN

    Return := 100.0;

ELSE

    Return :=
        (NetworkUptime * 100.0) /
        ObservationTime;

END_IF;
```

---

# Rules

- ObservationTime shall be greater than zero.
- NetworkUptime shall be zero or greater.
- NetworkUptime shall not exceed ObservationTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Network availability (%) |
| Network unavailable | 0.0 |
| Network continuously available | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Industrial Ethernet monitoring
- Modbus TCP network diagnostics
- SCADA communication monitoring
- PLC network health evaluation
- Communication KPI dashboards
- Reliability reporting

---

# Used By

- FB_CommunicationManager
- FB_SystemManager
- FB_DiagnosticsManager
- FB_ReportManager
- FB_SCADAInterface

---

# Test Cases

| Network Uptime | Observation Time | Expected |
|---------------:|-----------------:|---------:|
| 3600 s | 3600 s | 100% |
| 3540 s | 3600 s | 98.33% |
| 3420 s | 3600 s | 95% |
| 0 s | 3600 s | 0% |
| 100 s | 0 s | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the network availability percentage.

It does not:

- Detect communication failures
- Restart network interfaces
- Retry failed communication
- Record communication events
- Generate alarms
- Store historical statistics

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationAvailability.md
- FN_CalculateCommunicationReliability.md
- FN_CalculateBusUtilization.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- TEST_Functions.md

---

# Revision

Version 1.0