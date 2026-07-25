# ST_ModbusMap

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Communication Layer |
| Version | 2.0 |
| Register count | 4000 Holding Registers |

## Purpose

Defines a stable flat Modbus publication buffer.

Internal PLC structures are copied field-by-field into fixed WORD offsets. They are never overlaid directly onto the Modbus memory map because compiler padding, enum size, array layout, or later structure changes could shift addresses.

## Definition

```iecst
TYPE ST_ModbusMap :
STRUCT
    HoldingRegisters : ARRAY[0..3999] OF WORD;
END_STRUCT
END_TYPE
```

## Ownership

- PLC owns the complete buffer allocation.
- Desktop writes only the ranges explicitly marked W in the register map.
- PLC copies writable request blocks into private validation buffers before processing.
- Internal runtime modules never read mutable Desktop registers directly.
- Publication logic copies authoritative `ST_SystemStatus`, `ST_Line`, `ST_Alarm`, diagnostics, and counters into fixed offsets.

## Prohibited Patterns

- nesting internal structs directly in the communication structure
- mapping compiler-dependent memory layout
- Desktop writes to runtime status
- one-shot commands without sequence/acknowledgement
- strings in the realtime register map
- reusing retired offsets

## Related Documents

- [Modbus Register Map](../06_Documentation/Modbus_Register_Map.md)
- [Communication Protocol](../00_Architecture/COMMUNICATION_PROTOCOL.md)
- [IF_ExecutionTransfer](../04_Interfaces/IF_ExecutionTransfer.md)
- [IF_Alarm](../04_Interfaces/IF_Alarm.md)
