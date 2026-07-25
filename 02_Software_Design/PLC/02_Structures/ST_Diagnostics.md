# ST_Diagnostics

---

# Purpose

Represents the diagnostic information of the AquaFeed Platform.

This structure provides real-time system health monitoring for the PLC, communication, hardware devices and software services.

---

# Structure

```iecst
TYPE ST_Diagnostics :
STRUCT

    PlcScanTimeMs          : REAL;

    PlcCycleCounter        : UDINT;

    CpuLoadPercent         : REAL;

    MemoryUsagePercent     : REAL;

    CommunicationOK        : BOOL;

    CommunicationErrors    : UDINT;

    HeartbeatCounter       : UDINT;

    WatchdogActive         : BOOL;

    LastErrorCode          : UINT;

    LastErrorTime          : DT;

    ActiveAlarmCount       : UINT;

    DigitalInputErrors     : UINT;

    DigitalOutputErrors    : UINT;

    AnalogInputErrors      : UINT;

    AnalogOutputErrors     : UINT;

    ModbusErrors           : UDINT;

    DriveErrors            : UINT;

    SensorErrors           : UINT;

    SystemHealthy          : BOOL;

END_STRUCT
END_TYPE
```

---

# Updated By

FB_DiagnosticsManager

FB_SystemManager

---

# Read By

Desktop Application

Dashboard

Service Screen

Maintenance Manager

Alarm Manager

---

# Description

PlcScanTimeMs

Current PLC scan time.

---

PlcCycleCounter

Total PLC execution cycles.

---

CpuLoadPercent

Estimated PLC CPU load.

---

MemoryUsagePercent

Estimated PLC memory utilization.

---

CommunicationOK

Communication status with Desktop Application.

---

CommunicationErrors

Total communication failures.

---

HeartbeatCounter

Heartbeat received from Desktop.

---

WatchdogActive

PLC watchdog status.

---

LastErrorCode

Most recent diagnostic error.

---

LastErrorTime

Timestamp of last error.

---

ActiveAlarmCount

Current active alarm quantity.

---

DigitalInputErrors

Digital input faults.

---

DigitalOutputErrors

Digital output faults.

---

AnalogInputErrors

Analog input faults.

---

AnalogOutputErrors

Analog output faults.

---

ModbusErrors

Modbus communication failures.

---

DriveErrors

Connected drive faults.

---

SensorErrors

Sensor failures.

---

SystemHealthy

Overall diagnostic result.

TRUE = No critical issues detected.

FALSE = Service required.

---

# Rules

Diagnostic information shall update continuously.

Diagnostic values are read-only outside the Diagnostics Manager.

SystemHealthy shall become FALSE whenever a critical fault is detected.

CommunicationErrors, ModbusErrors and hardware errors shall never decrease except after an explicit maintenance reset.

---

# Lifetime

Runtime values remain in PLC memory.

Historical diagnostic events are stored in the database.

---

# Example

```iecst
g_Diagnostics

g_Diagnostics.PlcScanTimeMs

g_Diagnostics.CommunicationOK

g_Diagnostics.SystemHealthy
```

---

# Used By

- FB_DiagnosticsManager
- FB_SystemManager
- Dashboard
- Service Screen
- Alarm Manager
- Maintenance Manager
- Report Manager