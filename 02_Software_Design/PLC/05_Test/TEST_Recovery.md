# Recovery Test

---

# Purpose

Verify that the AquaFeed PLC system can safely recover from hardware, communication and software faults without data corruption or unsafe machine behavior.

---

# Test Environment

- Delta PLC
- Delta HMI
- Modbus RTU Network
- AquaFeed Manager
- Complete field hardware

---

# Preconditions

- System operating normally
- Active production available
- All communications healthy
- Valid recipe loaded

---

# Test Cases

## RT-001 PLC Power Recovery

### Procedure

1. Start automatic feeding.
2. Remove PLC power.
3. Restore power.

### Expected Result

- PLC initializes successfully.
- Retentive variables restored.
- Outputs remain OFF until operator confirmation.
- System enters Ready state safely.

Result

□ PASS

□ FAIL

---

## RT-002 HMI Restart

### Procedure

1. Keep PLC running.
2. Restart the HMI.

### Expected Result

- PLC continues operating normally.
- HMI reconnects automatically.
- Current process values restored.

Result

□ PASS

□ FAIL

---

## RT-003 Modbus Network Recovery

### Procedure

1. Disconnect the Modbus network.
2. Wait for communication timeout.
3. Restore the network.

### Expected Result

- Communication fault detected.
- Automatic reconnection performed.
- Device polling resumes correctly.

Result

□ PASS

□ FAIL

---

## RT-004 VFD Power Recovery

### Procedure

1. Remove power from one VFD.
2. Restore power.

### Expected Result

- Drive detected again automatically.
- Drive parameters verified.
- Ready status restored.

Result

□ PASS

□ FAIL

---

## RT-005 Emergency Stop Recovery

### Procedure

1. Activate Emergency Stop.
2. Release Emergency Stop.
3. Reset alarms.

### Expected Result

- Safe restart sequence executed.
- Automatic restart prohibited.
- Operator acknowledgement required.

Result

□ PASS

□ FAIL

---

## RT-006 Alarm Recovery

### Procedure

1. Generate a recoverable fault.
2. Remove the fault.
3. Reset alarms.

### Expected Result

- Alarm cleared correctly.
- System returns to Ready state.
- Alarm history preserved.

Result

□ PASS

□ FAIL

---

## RT-007 Recipe Recovery

### Procedure

1. Interrupt production.
2. Reload the same recipe.

### Expected Result

- Recipe parameters restored correctly.
- No corrupted values.
- Validation successful.

Result

□ PASS

□ FAIL

---

## RT-008 Job Recovery

### Procedure

1. Interrupt production during an active job.
2. Restore system operation.

### Expected Result

- Job status follows project restart policy.
- No duplicate production.
- Job queue remains consistent.

Result

□ PASS

□ FAIL

---

## RT-009 Database Synchronization

### Procedure

1. Disconnect AquaFeed Manager.
2. Continue production.
3. Reconnect AquaFeed Manager.

### Expected Result

- Missing records synchronized.
- No duplicated production data.
- History remains complete.

Result

□ PASS

□ FAIL

---

## RT-010 Full System Recovery

### Procedure

1. Simulate simultaneous communication, drive and power faults.
2. Restore all systems.

### Expected Result

- Complete recovery without software restart.
- All Function Blocks synchronized.
- System returns to Ready state.
- Safe operation restored.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Every recoverable fault shall return the system to a defined safe state.
- No production or historical data shall be lost.
- Automatic restart shall never occur after safety-related events.
- Communication shall recover without manual PLC intervention whenever possible.
- All recovery sequences shall be deterministic and repeatable.
- All test cases shall pass successfully.

---

# Tested Modules

- FB_SystemManager
- FB_ModbusMaster
- FB_FeedingControlManager
- FB_JobManager
- FB_RuntimeManager
- FB_AlarmManager
- FB_ReportManager
- FB_RecipeManager

---

# Revision

Version 1.0