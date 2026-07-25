# ST_IO

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | PLC Runtime / AquaCore |
| Persistence | Non-retentive process image |
| Version | 1.0 |

## Capacity

| Channel class | Fixed capacity |
|---|---:|
| Digital inputs | 64 |
| Digital outputs | 64 |
| Analog inputs | 16 |
| Analog outputs | 16 |

Unused channels are disabled by static configuration. Capacity changes require a reviewed interface version.

## Definition

```iecst
TYPE ST_IO :
STRUCT
    axDigitalInput           : ARRAY[0..63] OF BOOL;
    axDigitalInputValid      : ARRAY[0..63] OF BOOL;

    axDigitalOutput          : ARRAY[0..63] OF BOOL;
    axDigitalOutputValid     : ARRAY[0..63] OF BOOL;

    adiAnalogInput           : ARRAY[0..15] OF DINT;
    axAnalogInputValid       : ARRAY[0..15] OF BOOL;

    adiAnalogOutput          : ARRAY[0..15] OF DINT;
    axAnalogOutputValid      : ARRAY[0..15] OF BOOL;

    xRequiredModulesOnline   : BOOL;
    xForceActive             : BOOL;
    uiInvalidInputCount      : UINT;
    uiInvalidOutputCount     : UINT;
    uiOutputMismatchCount    : UINT;
    uiDiagnosticCode         : UINT;
    udiImageSequence         : UDINT;
END_STRUCT
END_TYPE
```

## Rules

- analog values use configured scaled integer engineering units; scaling factor is documented per channel
- no REAL value crosses the physical IO boundary unless separately justified
- invalid channels use explicit Valid flags; sentinel measurements are prohibited
- image sequence increments once per completed acquisition/application cycle and saturates
- channel meaning and hardware address are defined in the approved IO list, not by array position alone
- this process image is non-retentive; startup always begins from the safe output image
