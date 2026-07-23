# Function

FN_IsCommunicationHealthy

---

# Purpose

Determines whether communication with a remote device is considered healthy based on the communication status and the elapsed time since the last successful message.

This function provides a standardized method for communication health evaluation across Modbus RTU devices, VFDs, remote I/O modules, and other field equipment used in the AquaFeed Platform.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| CommunicationOK | BOOL | Result of the latest communication attempt |
| LastResponseTime | TIME | Time elapsed since the last successful response |
| TimeoutLimit | TIME | Maximum allowed communication interval |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | BOOL | TRUE if communication is healthy |

---

# Logic

```text
IF NOT CommunicationOK THEN
    Return := FALSE;

ELSIF LastResponseTime > TimeoutLimit THEN
    Return := FALSE;

ELSE
    Return := TRUE;

END_IF;
```

---

# Rules

- Communication must be successful.
- The elapsed time since the last valid response shall not exceed the configured timeout.
- Boundary values equal to the timeout are considered valid.
- The function shall not modify input values.
- The function shall execute within a single PLC scan.
- No internal memory shall be used.

---

# Return Value

| Condition | Return |
|-----------|--------|
| Communication OK and timeout not exceeded | TRUE |
| Communication failed | FALSE |
| Timeout exceeded | FALSE |

---

# Typical Usage

- Modbus RTU monitoring
- VFD communication supervision
- Remote I/O monitoring
- PLC-to-HMI communication checks
- Device diagnostics
- System health monitoring

---

# Used By

- FB_ModbusMaster
- FB_DriveCommunication
- FB_IOCommunication
- FB_SystemManager
- FB_HMIManager

---

# Test Cases

| Comm OK | Last Response | Timeout | Expected |
|----------|---------------|---------|----------|
| TRUE | T#2S | T#5S | TRUE |
| TRUE | T#5S | T#5S | TRUE |
| TRUE | T#6S | T#5S | FALSE |
| FALSE | T#2S | T#5S | FALSE |

---

# Complexity

Time Complexity

O(1)

Memory Usage

Constant

---

# Notes

This function only evaluates the communication health.

It does not:

- Send communication requests
- Retry failed messages
- Reset communication hardware
- Generate communication alarms
- Log communication events

These responsibilities belong to the calling Function Block.

---

# Related Documents

- FN_IsTimeout.md
- FB_ModbusMaster.md
- FB_SystemManager.md
- TEST_Functions.md

---

# Revision

Version 1.0