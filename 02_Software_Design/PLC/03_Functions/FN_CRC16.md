# Function

FN_CRC16

---

# Purpose

Calculates the CRC-16 checksum for a data buffer using the Modbus RTU CRC algorithm.

This function is used to verify data integrity during Modbus RTU communication between the PLC and field devices such as VFDs, HMIs, and remote I/O modules.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Data | ARRAY[*] OF BYTE | Data buffer to calculate |
| Length | UINT | Number of bytes to process |

---

# Output

| Name | Type | Description |
|------|------|-------------|
| Return | WORD | Calculated CRC-16 checksum |

---

# Algorithm

- Initial CRC value: `16#FFFF`
- Polynomial: `16#A001`
- Process each byte from the data buffer.
- Shift and XOR according to the Modbus RTU CRC-16 specification.
- Return the final 16-bit CRC value.

---

# Logic

```text
CRC := 16#FFFF;

FOR each byte IN Data DO
    CRC := CRC XOR Byte;

    FOR 8 bits DO
        IF CRC.0 = 1 THEN
            CRC := SHR(CRC,1);
            CRC := CRC XOR 16#A001;
        ELSE
            CRC := SHR(CRC,1);
        END_IF;
    END_FOR;
END_FOR;

Return := CRC;
```

---

# Rules

- The function shall not modify the input buffer.
- The input length shall not exceed the size of the supplied buffer.
- The CRC calculation shall follow the Modbus RTU standard.
- The function shall produce identical results for identical input data.
- No persistent variables shall be used.

---

# Return Value

| Result | Description |
|---------|-------------|
| WORD | Calculated CRC-16 checksum |

---

# Typical Usage

- Modbus RTU frame generation
- Modbus RTU frame validation
- Serial communication diagnostics
- VFD communication
- Remote I/O communication
- PLC communication testing

---

# Used By

- FB_ModbusMaster
- FB_ModbusSlave
- FB_SerialCommunication
- FB_DriveCommunication
- FB_IOCommunication

---

# Test Cases

| Description | Expected |
|-------------|----------|
| Empty buffer | CRC initialized according to Modbus standard |
| Valid Modbus request | CRC matches published Modbus example |
| Modified data byte | CRC changes |
| Same input twice | Identical CRC result |

---

# Complexity

Time Complexity

O(n)

where **n** is the number of processed bytes.

Memory Usage

Constant

---

# Notes

This function performs only CRC calculation.

It does not:

- Transmit communication frames
- Receive serial data
- Validate device addresses
- Check Modbus function codes
- Handle communication retries

These responsibilities belong to the calling communication Function Block.

---

# Related Documents

- FB_ModbusMaster.md
- FB_ModbusSlave.md
- PLC_Communication_Standard.md
- TEST_Functions.md

---

# Revision

Version 1.0