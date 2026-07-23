# Function

FN_CalculatePacketLossRate

---

# Function

FN_CalculatePacketLossRate

---

# Purpose

Calculates the percentage of communication packets that were lost during transmission.

This KPI is used to evaluate communication quality and detect network degradation, excessive electrical noise, cable faults, or communication congestion.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| LostPackets | DINT | Number of lost communication packets |
| TotalPackets | DINT | Total transmitted communication packets |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Packet loss rate (%) |

---

# Formula

```text
PacketLossRate =
(LostPackets /
TotalPackets)
× 100
```

---

# Logic

```text
IF LostPackets < 0 THEN

    Return := 0.0;

ELSIF TotalPackets <= 0 THEN

    Return := 0.0;

ELSIF LostPackets >= TotalPackets THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(LostPackets) * 100.0) /
        REAL(TotalPackets);

END_IF;
```

---

# Rules

- TotalPackets shall be greater than zero.
- LostPackets shall be zero or greater.
- LostPackets shall not exceed TotalPackets.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- The function shall execute within a single PLC scan.
- The function shall not modify input parameters.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Packet loss rate (%) |
| No packets lost | 0.0 |
| All packets lost | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Modbus RTU diagnostics
- Ethernet communication monitoring
- Industrial network quality analysis
- Communication KPI dashboards
- Predictive maintenance
- Communication performance reports

---

# Used By

- FB_CommunicationManager
- FB_ModbusMaster
- FB_DiagnosticsManager
- FB_SystemManager
- FB_ReportManager

---

# Test Cases

| Lost Packets | Total Packets | Expected |
|-------------:|--------------:|---------:|
| 0 | 10000 | 0% |
| 25 | 10000 | 0.25% |
| 100 | 10000 | 1% |
| 10000 | 10000 | 100% |
| 10 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the packet loss percentage.

It does not:

- Detect the cause of packet loss
- Retry lost packets
- Measure communication latency
- Evaluate communication throughput
- Store communication history
- Generate communication alarms

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationErrorRate.md
- FN_CalculateCommunicationTimeoutRate.md
- FN_CalculateCommunicationAvailability.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- TEST_Functions.md

---

# Revision

Version 1.0