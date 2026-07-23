# Function

FN_CalculateCommunicationSuccessRate

---

# Function

FN_CalculateCommunicationSuccessRate

---

# Purpose

Calculates the communication success rate by comparing the number of successful communication requests with the total communication requests.

This KPI provides an indication of communication reliability between the PLC and connected devices such as VFDs, HMIs, remote I/O modules, weighing systems, and other Modbus devices.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| SuccessfulRequests | DINT | Number of successful communication requests |
| TotalRequests | DINT | Total communication requests |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | REAL | Communication success rate (%) |

---

# Formula

```text
CommunicationSuccessRate =
(SuccessfulRequests /
TotalRequests)
× 100
```

---

# Logic

```text
IF SuccessfulRequests < 0 THEN

    Return := 0.0;

ELSIF TotalRequests <= 0 THEN

    Return := 0.0;

ELSIF SuccessfulRequests >= TotalRequests THEN

    Return := 100.0;

ELSE

    Return :=
        (REAL(SuccessfulRequests) * 100.0) /
        REAL(TotalRequests);

END_IF;
```

---

# Rules

- TotalRequests shall be greater than zero.
- SuccessfulRequests shall be zero or greater.
- Division by zero shall be prevented.
- The returned value shall be limited to the range 0–100%.
- SuccessfulRequests greater than TotalRequests shall return 100%.
- The function shall not modify input parameters.
- The function shall execute within a single PLC scan.
- No persistent memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Valid inputs | Communication success rate (%) |
| No successful requests | 0.0 |
| All requests successful | 100.0 |
| Invalid inputs | 0.0 |

---

# Typical Usage

- Modbus RTU/TCP communication monitoring
- PLC network diagnostics
- Drive communication statistics
- HMI communication monitoring
- Remote I/O reliability analysis
- System KPI reporting

---

# Used By

- FB_ModbusMaster
- FB_CommunicationManager
- FB_SystemManager
- FB_HMIManager
- FB_ReportManager

---

# Test Cases

| Successful Requests | Total Requests | Expected |
|--------------------:|---------------:|---------:|
| 1000 | 1000 | 100% |
| 990 | 1000 | 99% |
| 950 | 1000 | 95% |
| 0 | 1000 | 0% |
| 500 | 0 | 0% |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function calculates only the communication success rate.

It does not:

- Retry failed communication requests
- Detect communication timeout causes
- Reset communication devices
- Store communication history
- Generate communication alarms
- Perform communication diagnostics

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_CalculateCommunicationErrorRate.md
- FN_CalculateCommunicationAvailability.md
- FN_IsCommunicationHealthy.md
- FB_CommunicationManager.md
- FB_ModbusMaster.md
- TEST_Functions.md

---

# Revision

Version 1.0