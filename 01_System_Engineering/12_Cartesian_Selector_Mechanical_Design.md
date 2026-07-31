# NVM AquaFeed Platform

# Cartesian Selector Mechanical Design

Document ID : AQ-SEL-MECH-012

Version : 0.1

Status : R&D / Living Document

---

## 1. Purpose

This document is the single source of truth for the mechanical R&D of the new Cartesian selector.

The new design replaces the existing circular positioning mechanism with an X-Y Cartesian positioning mechanism.

Only confirmed design decisions are recorded as requirements. Dimensions and components that are not yet finalized are listed under Open Decisions.

---

## 2. Existing Selector Reference

The existing selector uses:

- 12 outlets arranged in a circular pattern
- One rotating curved feed pipe
- One motor and reducer for angular positioning
- 16 bar, Ø90 mm outlet pipes

The existing selector specification remains in:

`01_System_Engineering/11_Selector_Specification.md`

This document does not modify the existing design.

---

## 3. New Design Concept

The new selector shall use:

- 12 fixed outlet positions
- 3 rows and 4 columns
- X-Y Cartesian positioning
- One step motor for the X axis
- One step motor for the Y axis
- The Y axis mounted on the X carriage
- Two parallel guide shafts on the X axis
- Two parallel guide shafts on the Y axis
- Bearing-supported axis movement
- Sigma aluminium profiles for the structural frame
- One moving feed outlet aligned with the selected fixed outlet

The selector operates under heavy field conditions.

Positioning repeatability and mechanical rigidity are primary design requirements.

---

## 4. Fixed Outlet Plate

Confirmed properties:

| Property | Value |
|---|---:|
| Material | Aluminium |
| Plate width | 725 mm |
| Plate height | 725 mm |
| Outlet quantity | 12 |
| Outlet arrangement | 3 rows × 4 columns |
| Pipe nominal outside diameter | Ø90 mm |
| Pipe pressure class | 16 bar |

Plate thickness is not finalized.

Candidate thicknesses:

- 18 mm
- 20 mm

The final machining diameter shall be determined from the actual mounting geometry of the pipe connector. It shall not be assumed to be Ø90 mm until the connector interface is finalized.

---

## 5. Axis Architecture

### 5.1 X Axis

The X axis carries the complete Y-axis assembly.

Confirmed architecture:

- Two parallel guide shafts
- Bearing-supported X carriage
- Step motor drive
- Structural support using sigma aluminium profiles

### 5.2 Y Axis

The Y axis is installed on the X carriage.

Confirmed architecture:

- Two parallel guide shafts
- Bearing-supported Y carriage
- Step motor drive
- Moving Ø90 feed outlet mounted on the Y carriage

### 5.3 Structural Principle

Both axes shall use two parallel guide shafts to improve:

- Rigidity
- Resistance to rotation
- Position repeatability
- Stability under heavy field conditions

Shaft diameter, shaft support type, bearing type and drive transmission are not yet finalized.

---

## 6. Outlet Coordinate System

The outlet matrix is defined as:

| Row / Column | C1 | C2 | C3 | C4 |
|---|---|---|---|---|
| R1 | Outlet 1 | Outlet 2 | Outlet 3 | Outlet 4 |
| R2 | Outlet 5 | Outlet 6 | Outlet 7 | Outlet 8 |
| R3 | Outlet 9 | Outlet 10 | Outlet 11 | Outlet 12 |

Coordinate origin, horizontal pitch and vertical pitch are not yet finalized.

Initial study values, not approved for manufacturing:

| Parameter | Study value |
|---|---:|
| Horizontal centre pitch | 150 mm |
| Vertical centre pitch | 180 mm |
| X centre span | 450 mm |
| Y centre span | 360 mm |

These values shall be validated against the connector outside dimensions, moving carriage dimensions, bearing blocks and available axis travel.

---

## 7. Moving Feed Connection

The moving feed outlet shall travel to the selected X-Y coordinate and align with the corresponding fixed outlet.

The connection method between the moving outlet and fixed outlet is not yet finalized.

The design study shall determine:

- Whether alignment alone is sufficient
- Whether a mechanical engagement movement is required
- How feed leakage will be prevented
- How pipe load will be isolated from the X-Y positioning mechanism
- How the fixed feed inlet will accommodate X-Y movement

---

## 8. Design Loads and Motor Sizing Inputs

The following data is required before shaft, bearing, drive and step motor sizing:

- Total mass carried by the X axis
- Total mass carried by the Y axis
- Moving feed pipe mass
- Pipe reaction forces
- Required travel time between outlets
- Required positioning tolerance
- Required positioning repeatability
- Maximum acceleration
- Duty cycle
- Environmental contamination conditions

Motor sizing shall not be finalized before these values are defined.

---

## 9. Confirmed Decisions

| ID | Decision |
|---|---|
| CD-001 | The new selector uses a 3 × 4 Cartesian outlet matrix. |
| CD-002 | The selector has 12 outlets. |
| CD-003 | Outlet pipes are 16 bar, Ø90 mm. |
| CD-004 | The fixed aluminium plate is 725 × 725 mm. |
| CD-005 | X and Y movement is provided by step motors. |
| CD-006 | Both axes use two parallel guide shafts. |
| CD-007 | The Y axis is mounted on the X carriage. |
| CD-008 | The structural frame uses sigma aluminium profiles. |
| CD-009 | The machine is designed for heavy field conditions. |
| CD-010 | Positioning repeatability and rigidity are primary requirements. |

---

## 10. Open Decisions

| ID | Open decision | Status |
|---|---|---|
| OD-001 | Plate thickness: 18 mm or 20 mm | Open |
| OD-002 | Actual plate machining diameter for each outlet connection | Open |
| OD-003 | Horizontal outlet centre pitch | Open |
| OD-004 | Vertical outlet centre pitch | Open |
| OD-005 | X-axis guide shaft diameter and support type | Open |
| OD-006 | Y-axis guide shaft diameter and support type | Open |
| OD-007 | Bearing type and quantity per carriage | Open |
| OD-008 | Axis drive transmission type | Open |
| OD-009 | X-axis step motor size | Open |
| OD-010 | Y-axis step motor size | Open |
| OD-011 | Moving-to-fixed outlet engagement and sealing method | Open |
| OD-012 | Required positioning tolerance and repeatability | Open |
| OD-013 | Target movement time between outlets | Open |
| OD-014 | X-Y movement accommodation of the fixed feed inlet | Open |

---

## 11. R&D Sequence

1. Finalize outlet connector geometry.
2. Finalize outlet centre pitches and plate machining coordinates.
3. Define moving feed outlet and engagement method.
4. Determine X and Y moving masses.
5. Select guide shaft diameters and bearings.
6. Select axis drive transmission.
7. Calculate step motor torque and speed.
8. Design the sigma-profile frame.
9. Verify travel limits and mechanical clearances.
10. Update the PLC selector specification for two-axis Cartesian positioning.

---

## 12. Revision History

| Version | Date | Description |
|---|---|---|
| 0.1 | 2026-07-31 | Initial Cartesian selector mechanical R&D document created. |

---

End of Document
