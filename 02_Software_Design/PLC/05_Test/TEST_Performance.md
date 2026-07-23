# Performance Test

---

# Purpose

Verify that the complete PLC application meets the required performance, responsiveness and stability targets under normal and maximum operating conditions.

---

# Test Environment

- Delta PLC
- Delta HMI
- Modbus RTU Network
- All field devices connected
- AquaFeed Manager connected
- Engineering Laptop

---

# Preconditions

- System Ready
- No active alarms
- All devices operational
- Scan time monitoring enabled

---

# Test Cases

## PT-001 PLC Scan Time

### Procedure

1. Start the system.
2. Observe PLC scan time under idle conditions.

### Expected Result

- Scan time remains within the specified engineering limit.
- No scan overruns occur.

Result

□ PASS

□ FAIL

---

## PT-002 Full System Load

### Procedure

1. Execute all active communication tasks.
2. Run automatic feeding.

### Expected Result

- Stable scan time.
- No communication delays.
- No missed control cycles.

Result

□ PASS

□ FAIL

---

## PT-003 Maximum Communication Load

### Procedure

1. Poll every Modbus slave continuously.
2. Record communication statistics.

### Expected Result

- No packet loss.
- Acceptable communication latency.
- Stable polling cycle.

Result

□ PASS

□ FAIL

---

## PT-004 HMI Refresh Performance

### Procedure

1. Navigate between all HMI pages.
2. Observe live process values.

### Expected Result

- Screen updates are responsive.
- No delayed status indication.
- Alarm updates are immediate.

Result

□ PASS

□ FAIL

---

## PT-005 Continuous Production

### Procedure

1. Run automatic production continuously for 12 hours.

### Expected Result

- No unexpected faults.
- No PLC watchdog events.
- Stable production throughout the test.

Result

□ PASS

□ FAIL

---

## PT-006 Alarm Response Time

### Procedure

1. Generate a simulated field fault.

### Expected Result

- Alarm detected immediately.
- HMI updated without noticeable delay.
- Alarm logged successfully.

Result

□ PASS

□ FAIL

---

## PT-007 Emergency Stop Response

### Procedure

1. Start automatic feeding.
2. Activate Emergency Stop.

### Expected Result

- Outputs disabled immediately.
- Machine enters Safe State.
- Emergency alarm displayed.

Result

□ PASS

□ FAIL

---

## PT-008 Memory Stability

### Procedure

1. Operate the system continuously for 24 hours.

### Expected Result

- No abnormal memory growth.
- No application instability.
- Stable PLC execution.

Result

□ PASS

□ FAIL

---

## PT-009 Report Generation Performance

### Procedure

1. Generate reports using the maximum expected historical data.

### Expected Result

- Reports generated successfully.
- Acceptable generation time.
- No interruption of PLC operation.

Result

□ PASS

□ FAIL

---

## PT-010 Recovery Performance

### Procedure

1. Disconnect and reconnect the communication network.

### Expected Result

- Automatic recovery completed.
- No manual PLC restart required.
- Production may continue after validation.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- PLC scan time remains within project limits.
- Communication remains stable under maximum expected load.
- Alarm and safety response times meet system requirements.
- Long-duration operation does not reduce performance.
- No watchdog resets, deadlocks or unexpected software exceptions occur.
- All performance test cases shall pass successfully.

---

# Tested Modules

- FB_SystemManager
- FB_ModbusMaster
- FB_FeedingControlManager
- FB_RuntimeManager
- FB_AlarmManager
- FB_ReportManager

---

# Revision

Version 1.0