# 96_Line_Configuration_System.md

# NVM AquaFeed Platform

## Line Configuration System

Document ID : AQ-LCF-096

Version : 1.0

--------------------------------------------------
1. Purpose
--------------------------------------------------

Configure every feeding line independently.

Each feeding line shall operate using its own configuration.

Changing one line shall never affect another line.

--------------------------------------------------
2. Line Parameters
--------------------------------------------------

Line Name

Enabled

Selector ID

Blower ID

Dosing Unit ID

Maximum Feed Rate

Maximum Mission Size

Communication Timeout

--------------------------------------------------
3. Runtime Configuration
--------------------------------------------------

Changes requiring restart

Machine Mapping

Communication Address

Calibration Reset

--------------------------------------------------

Changes allowed during operation

Mission Queue

Feed Rate

Target Feed

Mission Priority

--------------------------------------------------
4. Validation
--------------------------------------------------

Every machine shall belong to only one line.

Duplicate assignments prohibited.

--------------------------------------------------

End Of Document