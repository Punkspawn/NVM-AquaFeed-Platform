# 32_Silo_Management.md

# NVM AquaFeed Platform

## Silo Management

Document ID : AQ-SIL-032

Version : 1.0

--------------------------------------------------
1. Purpose
--------------------------------------------------

The Silo Management System tracks feed inventory and ensures the correct feed is delivered.

--------------------------------------------------
2. Silo Information
--------------------------------------------------

Silo ID

Name

Feed Type

Feed Lot

Capacity

Current Weight

Minimum Level

Maximum Level

--------------------------------------------------
3. Feed Lot Tracking
--------------------------------------------------

Each silo shall contain one feed lot.

Changing feed requires closing the current lot and opening a new lot.

History shall never be deleted.

--------------------------------------------------
4. Low Feed Warning
--------------------------------------------------

If remaining feed is below threshold

↓

Warning

Threshold configurable.

--------------------------------------------------
5. Empty Silo
--------------------------------------------------

Mission cannot start if

Available Feed

<

Required Feed

--------------------------------------------------
6. Feed Consumption
--------------------------------------------------

Every mission automatically decreases silo stock.

--------------------------------------------------
7. Manual Adjustment
--------------------------------------------------

Only Service or Supervisor may adjust inventory.

Every adjustment shall be logged.

--------------------------------------------------

End Of Document