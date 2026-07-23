# Function

FN_CalculateBusUtilization

---

# Function

FN_CalculateBusUtilization

---

# Purpose

Calculates the utilization percentage of the communication bus by comparing the current occupied bus time with the available communication cycle time.

This KPI helps identify overloaded communication buses and supports communication capacity planning.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| BusBusyTime | REAL | Time the communication bus was occupied during one cycle (ms) |
| CycleTime | REAL | Total communication cycle time (ms) |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Bus utilization (%) |

---

# Formula

```text
BusUtilization =
(BusBusyTime /
CycleTime)
× 100
```

---

# Logic

```text
IF BusBusyTime < 0.0 THEN

    Return := 0.0;

ELSIF CycleTime <= 0.0 THEN

    Return := 0.0;

ELSIF BusBusyTime >= CycleTime THEN

    Return := 100.0;

ELSE

    Return :=
        (BusBusyTime * 100.0) /
        CycleTime;

END_IF;
```

---

# Rules

- CycleTime shall be greater than zero.
- BusBusyTime shall be zero or greater.
- BusBusyTime shall not exceed CycleTime.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Bus utilization (%) |
| Bus idle | 0.0 |
| Bus fully occupied | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Modbus RTU bus monitoring
- RS-485 communication diagnostics
- Ethernet network utilization monitoring
- Communication performance analysis
- PLC diagnostics
- Communication capacity planning

---

# Used By

- FB_CommunicationManager
- FB_ModbusMaster
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Bus Busy Time | Cycle Time | Expected |
|--------------:|-----------:|---------:|
| 10 ms | 100 ms | 10% |
| 45 ms | 100 ms | 45% |
| 80 ms | 100 ms | 80% |
| 100 ms | 100 ms | 100% |
| 10 ms | 0 ms | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the communication bus utilization percentage.

It does not:

- Schedule communication traffic
- Prioritize communication requests
- Retry failed messages
- Detect communication faults
- Store utilization history
- Generate communication reports

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationLoad.md
- FN_CalculateCommunicationThroughput.md
- FN_CalculateCommunicationLatency.md
- FB_CommunicationManager.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0