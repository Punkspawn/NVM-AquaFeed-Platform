# Function

FN_CalculateNetworkDowntime

---

# Function

FN_CalculateNetworkDowntime

---

# Purpose

Calculates the percentage of time that the communication network was unavailable during the observation period.

This KPI complements Network Availability and provides a direct measure of communication outages affecting the automation system.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| NetworkDowntime | REAL | Total network downtime during the observation period (seconds) |
| ObservationTime | REAL | Total observation period (seconds) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Network downtime (%) |

---

# Formula

```text
NetworkDowntimePercentage =
(NetworkDowntime /
ObservationTime)
× 100
```

---

# Logic

```text
IF NetworkDowntime < 0.0 THEN

    Return := 0.0;

ELSIF ObservationTime <= 0.0 THEN

    Return := 0.0;

ELSIF NetworkDowntime >= ObservationTime THEN

    Return := 100.0;

ELSE

    Return :=
        (NetworkDowntime * 100.0) /
        ObservationTime;

END_IF;
```

---

# Rules

- ObservationTime shall be greater than zero.
- NetworkDowntime shall be zero or greater.
- NetworkDowntime shall not exceed ObservationTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Network downtime (%) |
| No downtime | 0.0 |
| Network unavailable for entire observation period | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Industrial Ethernet monitoring
- Modbus TCP diagnostics
- SCADA communication monitoring
- PLC network health analysis
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

| Network Downtime | Observation Time | Expected |
|-----------------:|-----------------:|---------:|
| 0 s | 3600 s | 0% |
| 60 s | 3600 s | 1.67% |
| 180 s | 3600 s | 5% |
| 3600 s | 3600 s | 100% |
| 60 s | 0 s | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the network downtime percentage.

It does not:

- Detect communication failures
- Identify downtime causes
- Restore network communication
- Generate communication alarms
- Store historical statistics
- Produce diagnostic reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateNetworkAvailability.md
- FN_CalculateCommunicationAvailability.md
- FN_CalculateCommunicationReliability.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- TEST_Functions.md

---

# Revision

Version 1.0