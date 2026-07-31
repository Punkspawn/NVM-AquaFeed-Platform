# NVM AquaFeed Platform

# Cartesian Selector Mechanical Design

Document ID : AQ-SEL-MECH-012

Version : 0.10

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

Confirmed shaft and bearing selection for both axes:

- Ø25 mm hardened and ground precision shafts
- Shafts supported continuously along their length
- Two parallel shafts per axis
- Open-type, clearance-adjustable Ø25 linear bearing blocks
- Double-sealed bearing blocks for contaminated field conditions
- Two bearing blocks per shaft
- Four bearing blocks per axis
- Eight bearing blocks total

SBR25UU-compatible supported-shaft bearing geometry may be used, subject to final supplier verification.

Confirmed drive transmission for both axes:

- Ø20 mm ball screw
- 5 mm lead
- C7 accuracy class
- Preloaded double ball nut
- Fixed-supported end arrangement
- BK15 fixed-end support unit
- BF15 supported-end unit
- Flexible motor coupling
- Protective bellows or equivalent mechanical cover against feed dust

Reference purchase class: SFU2005 C7 double-nut assembly.

Final screw lengths and end machining dimensions shall be frozen after the sigma-profile frame and carriage geometry are completed.

A 5 mm lead provides 0.025 mm theoretical travel per full step with a 200-step/revolution step motor. Microstepping shall not be treated as equivalent to mechanical positioning accuracy.

---

## 6. Outlet Coordinate System

The outlet matrix is defined as:

| Row / Column | C1 | C2 | C3 | C4 |
|---|---|---|---|---|
| R1 | Outlet 1 | Outlet 2 | Outlet 3 | Outlet 4 |
| R2 | Outlet 5 | Outlet 6 | Outlet 7 | Outlet 8 |
| R3 | Outlet 9 | Outlet 10 | Outlet 11 | Outlet 12 |

Coordinate origin is the upper-left corner of the 725 × 725 mm plate when viewed from the moving-carriage side.

Confirmed grid geometry:

| Parameter | Value |
|---|---:|
| Horizontal centre pitch | 150 mm |
| Vertical centre pitch | 180 mm |
| X centre span | 450 mm |
| Y centre span | 360 mm |
| Horizontal hole-edge margin for Ø90 | 92.5 mm |
| Vertical hole-edge margin for Ø90 | 137.5 mm |
| X working travel | 450 mm |
| Y working travel | 360 mm |
| X design mechanical stroke | 500 mm |
| Y design mechanical stroke | 410 mm |

Confirmed outlet coordinates:

| Outlet | X (mm) | Y (mm) |
|---|---:|---:|
| 1 | 137.5 | 182.5 |
| 2 | 287.5 | 182.5 |
| 3 | 437.5 | 182.5 |
| 4 | 587.5 | 182.5 |
| 5 | 137.5 | 362.5 |
| 6 | 287.5 | 362.5 |
| 7 | 437.5 | 362.5 |
| 8 | 587.5 | 362.5 |
| 9 | 137.5 | 542.5 |
| 10 | 287.5 | 542.5 |
| 11 | 437.5 | 542.5 |
| 12 | 587.5 | 542.5 |

The actual machined hole diameter remains dependent on the final connector interface.

---

## 7. Moving Feed Connection

The moving feed outlet shall travel to the selected X-Y coordinate and align with the corresponding fixed outlet.

The selector shall have only two motion axes: X and Y.

No Z axis or separate engagement axis shall be used.

Air leakage shall be solved by the mechanical geometry of the moving outlet, fixed outlet interface and sealing components without adding another motion axis.

The design study shall determine:

- The two-axis mechanical outlet interface
- How feed and air leakage will be prevented
- How pipe load will be isolated from the X-Y positioning mechanism
- How the fixed feed inlet will accommodate X-Y movement

---

## 8. Sigma-Profile Structure

Confirmed profile family:

- 45-series sigma aluminium profile
- 10 mm slot
- Heavy series
- Anodized 6063-class aluminium
- 45 × 90 mm heavy profile for the fixed main frame and primary axis-support beams
- 45 × 45 mm heavy profile for moving carriage frames, secondary ties and bracing
- M8 slot nuts and compatible 45-series connection hardware
- Reinforced 90-degree brackets at primary frame joints

Confirmed preliminary cut and motion-component lengths:

| Component | Length | Quantity |
|---|---:|---:|
| X supported Ø25 shaft assembly | 700 mm | 2 |
| Y supported Ø25 shaft assembly | 600 mm | 2 |
| X SFU2005 ball-screw assembly, total ordered length | 700 mm | 1 |
| Y SFU2005 ball-screw assembly, total ordered length | 600 mm | 1 |
| 45 × 90 heavy profile, full-width members | 815 mm | 4 |
| 45 × 90 heavy profile, side members | 725 mm | 2 |
| 45 × 45 heavy profile, Y vertical members | 600 mm | 2 |
| 45 × 45 heavy profile, Y cross-members | 300 mm | 2 |
| X energy chain, preliminary | 1000 mm | 1 |
| Y energy chain, preliminary | 800 mm | 1 |

The main frame has a 725 × 725 mm clear opening and an approximately 815 × 815 mm outside dimension.

Ball screws shall be ordered with BK15/BF15-compatible end machining. Energy-chain lengths remain field-trimmable.

## 9. Fabricated Plates and Brackets

Plate blanks shall be procured cut to size in Türkiye. Final drilling and machining shall use the actual supplier drawings of SBR25UU blocks, BK15/BF15 supports, DSG20H housings and NEMA 34 motors.

| ID | Part | Material | Blank size | Quantity |
|---|---|---|---:|---:|
| FP-01 | Moving outlet carriage plate | EN AW-6082 T6/T651 | 300 × 220 × 15 mm | 1 |
| FP-02 | X gantry-to-SBR adapter plate | EN AW-6082 T6/T651 | 120 × 100 × 12 mm | 4 |
| FP-03 | NEMA 34 motor plate | EN AW-6082 T6/T651 | 140 × 140 × 12 mm | 2 |
| FP-04 | BK15 fixed-support plate | EN AW-6082 T6/T651 | 120 × 100 × 12 mm | 2 |
| FP-05 | BF15 supported-end plate | EN AW-6082 T6/T651 | 100 × 80 × 12 mm | 2 |
| FP-06 | DSG20H ball-nut-housing adapter | EN AW-6082 T6/T651 | 120 × 100 × 12 mm | 2 |
| FP-07 | Adjustable sensor bracket | AISI 316 stainless steel | 80 × 40 × 3 mm | 4 |
| FP-08 | Sensor target flag | AISI 316 stainless steel | 40 × 30 × 3 mm | 4 |

Approximate total 6082 plate blank mass is 7.6 kg before machining.

## 10. Fasteners and Assembly Consumables

Exposed bolts shall be A4-70/AISI 316 stainless steel. Profile slot nuts may be zinc- or nickel-plated steel compatible with 45-series 10 mm slots.

| Item | Specification | Procurement quantity |
|---|---|---:|
| Reinforced profile angle bracket | 45-series, 10-slot | 24 |
| Profile slot nut | M8, 45-series, 10-slot | 150 |
| Socket-head bolt | M8 × 20, DIN 912, A4-70 | 150 |
| Flat washer | M8, A4 | 150 |
| Socket-head bolt | M6 × 20, DIN 912, A4-70 | 60 |
| Socket-head bolt | M6 × 25, DIN 912, A4-70 | 30 |
| Flat washer | M6, A4 | 100 |
| Locknut | M6, A4 | 40 |
| Socket-head bolt | M5 × 16, DIN 912, A4-70 | 20 |
| Flat washer and locknut | M5, A4 | 20 sets |
| Anti-seize compound | Stainless/aluminium compatible | 1 tube |
| Medium threadlocker | Removable grade | 1 bottle |
| Electrical isolation washer | Polyamide, M6/M8 mixed | 1 set |

Final fastener lengths shall be checked against the purchased component drawings before release.

## 11. Protection, Lubrication and Service Items

The motion system shall be protected from feed dust, moisture and the marine operating environment without adding another motion axis.

| Item | Specification | Quantity |
|---|---|---:|
| Ball-screw bellows | Custom technical-fabric bellows, two sections per axis | 4 |
| External cover sheet | EN AW-5754 H111 aluminium, 2 mm, 1000 × 2000 mm | 2 sheets |
| Cover edge seal | EPDM bulb or panel-edge seal | 10 m |
| Stainless continuous hinge | AISI 316 | 2 m |
| Toggle latch | Stainless steel | 4 |
| Cover handle | Corrosion-resistant | 2 |
| Grease | SKF LGFG 2/0.4 food-grade NLGI 2 or equivalent | 2 cartridges |
| Manual grease gun | 420 ml cartridge type | 1 |
| Grease nipples | Straight type; thread confirmed after component purchase | 12 |
| Spare SBR25UU block | Same brand and type as production blocks | 2 |
| Spare inductive sensor | Same model as production sensors | 1 |

The selected grease shall be food-grade because the mechanism operates adjacent to the feed path. Different grease types shall not be mixed.

Initial maintenance basis:

- Visual inspection and dry cleaning: every 100 operating hours
- Wiper, bellows and corrosion inspection: every 250 operating hours
- Relubrication inspection: every 500 operating hours
- Final relubrication interval: supplier instruction and commissioning observation take precedence

Grease quantity shall be controlled. Excess grease shall not be allowed to enter the feed path.

Bellows shall be ordered only after the final compressed length, extended length and end-flange geometry are measured from the completed CAD assembly.

## 12. Domestic Procurement Policy

All BOM items shall be specified for procurement from suppliers operating in Türkiye.

The BOM shall use common Turkish-market product descriptions and standard sizes.

Supplier-specific or imported-to-order parts shall not be frozen unless a locally available standard equivalent is unavailable.

Ball screws shall be ordered from a Türkiye-based motion supplier with final length and BK15/BF15 end machining included.

The final procurement package shall include:

- Technical description
- Quantity
- Final cut or machining length
- Preferred specification
- Acceptable equivalent
- Türkiye supplier options
- Unit price
- Total price
- VAT status
- Price-check date

## 13. Design Loads and Motor Sizing Inputs

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

Preliminary design masses for motor selection:

| Axis | Preliminary moving mass |
|---|---:|
| X axis, including complete Y assembly | 35 kg |
| Y axis moving outlet carriage | 12 kg |

These are conservative R&D masses and shall be replaced by measured CAD masses before manufacturing release.

Confirmed motor and drive selection for both axes:

| Item | Selection |
|---|---|
| Motor | Leadshine CS-M23485 or exact compatible equivalent |
| Frame | NEMA 34, 86 mm |
| Holding torque | 8.5 N·m |
| Feedback | Incremental encoder, closed-loop |
| Drive | Leadshine CS2RS-D1008 |
| Communication | RS-485, Modbus RTU |
| Axis quantity | 2 identical motor-drive sets |
| Power supply basis | 48 VDC industrial supply; final wattage after electrical load schedule |

The motor-drive combination shall be purchased as a matched set from a supplier operating in Türkiye.

Pulse-only open-loop or pulse-only closed-loop drives are not acceptable as the primary procurement selection.

Confirmed auxiliary motion components:

| Item | Specification | Quantity |
|---|---|---:|
| Ball-nut housing | DSG20H-compatible housing for SFU2005 | 2 |
| Motor coupling | Zero-backlash elastomer-jaw coupling, minimum 15 N·m, 14 mm × 15 mm finished bores | 2 |
| Motor mounting plate | 6082-T6 aluminium, 12 mm thick, NEMA 34 pattern | 2 |
| Energy chain | Closed type, minimum 25 × 50 mm internal section | 2 axis sets |
| Energy-chain end brackets | Compatible fixed and moving brackets | 2 sets |
| Axis reference sensors | M12 inductive, PNP NO, 12–24 VDC, IP67, 4 mm nominal sensing | 4 |
| Primary sensor reference | Autonics PR12-4DP or equivalent | 4 |
| Sensor brackets | Adjustable stainless steel brackets | 4 |
| Sensor target flags | Stainless steel target flags | 4 |
| Axis power supplies | 48 VDC, 10 A, 480 W industrial DIN-rail supply | 2 |
| Primary PSU reference | Mean Well NDR-480-48 or equivalent | 2 |

Each axis shall use one home/reference sensor and one opposite-end safety limit sensor.

Power and encoder cables shall be routed with separation inside the energy chain. Final chain lengths and bend radii shall be frozen after the layout drawing and cable datasheets are available.

---

## 14. Confirmed Decisions

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
| CD-011 | The selector shall have only X and Y motion axes. No Z or separate engagement axis shall be added. |
| CD-012 | Air leakage shall be solved mechanically within the two-axis outlet interface. |
| CD-013 | Both X and Y axes use continuously supported Ø25 mm hardened and ground precision shafts. |
| CD-014 | Each axis uses four open-type, clearance-adjustable, double-sealed Ø25 linear bearing blocks. |
| CD-015 | Shaft and bearing dimensions are standardized across both axes. |
| CD-016 | Both axes use Ø20 mm, 5 mm lead, C7 preloaded double-nut ball screws. |
| CD-017 | Both ball screws use BK15 fixed and BF15 supported end units. |
| CD-018 | Ball screws shall be mechanically protected against feed dust. |
| CD-019 | Fixed main frame and primary supports use 45 × 90 mm heavy, 10-slot sigma profile. |
| CD-020 | Moving frames and secondary ties use 45 × 45 mm heavy, 10-slot sigma profile. |
| CD-021 | Procurement shall be made through suppliers operating in Türkiye using common market standards. |
| CD-022 | Both axes use identical NEMA 34, 8.5 N·m closed-loop step motors. |
| CD-023 | Primary motor reference is Leadshine CS-M23485. |
| CD-024 | Primary drive reference is Leadshine CS2RS-D1008 with RS-485 Modbus RTU. |
| CD-025 | Motor and drive shall be procured as a matched set from a Türkiye-based supplier. |
| CD-026 | Each axis uses one reference sensor and one opposite-end limit sensor. |
| CD-027 | Axis sensors are M12, PNP NO, 12–24 VDC, IP67 inductive sensors. |
| CD-028 | Motor couplings are zero-backlash jaw type with 14 mm × 15 mm finished bores and at least 15 N·m rating. |
| CD-029 | Each axis uses a dedicated 48 VDC, 10 A industrial DIN-rail power supply. |
| CD-030 | Moving cables use closed 25 × 50 mm minimum internal-section energy chains. |
| CD-031 | Outlet grid pitch is fixed at 150 mm horizontal and 180 mm vertical. |
| CD-032 | X/Y working travels are 450/360 mm; mechanical design strokes are 500/410 mm. |
| CD-033 | X/Y supported-shaft lengths are 700/600 mm. |
| CD-034 | X/Y SFU2005 ordered lengths are 700/600 mm with BK15/BF15 end machining. |
| CD-035 | Main frame outside dimension is approximately 815 × 815 mm around the 725 × 725 mm plate. |
| CD-036 | Fabricated carriage and support plates use EN AW-6082 T6/T651 aluminium. |
| CD-037 | Exposed fasteners use A4-70/AISI 316 stainless steel. |
| CD-038 | Component hole patterns shall be machined only after actual supplier drawings are available. |
| CD-039 | Each ball screw uses two custom protective bellows sections. |
| CD-040 | External covers use 2 mm EN AW-5754 H111 aluminium sheet and EPDM edge sealing. |
| CD-041 | Lubrication uses one food-grade NLGI 2 grease type; primary reference is SKF LGFG 2. |
| CD-042 | Lubrication remains manual; no automatic lubrication system is added. |

---

## 15. Open Decisions

| ID | Open decision | Status |
|---|---|---|
| OD-001 | Plate thickness: 18 mm or 20 mm | Open |
| OD-002 | Actual plate machining diameter for each outlet connection | Open |
| OD-003 | Horizontal outlet centre pitch | Closed: 150 mm |
| OD-004 | Vertical outlet centre pitch | Closed: 180 mm |
| OD-005 | X-axis guide shaft diameter and support type | Closed: supported Ø25 mm |
| OD-006 | Y-axis guide shaft diameter and support type | Closed: supported Ø25 mm |
| OD-007 | Bearing type and quantity per carriage | Closed: 4 open adjustable sealed blocks per axis |
| OD-008 | Axis drive transmission type | Closed: SFU2005-class preloaded ball screw |
| OD-009 | X-axis step motor size | Closed: NEMA 34, 8.5 N·m closed-loop |
| OD-010 | Y-axis step motor size | Closed: NEMA 34, 8.5 N·m closed-loop |
| OD-011 | Two-axis moving-to-fixed outlet geometry and sealing method | Open |
| OD-012 | Required positioning tolerance and repeatability | Open |
| OD-013 | Target movement time between outlets | Open |
| OD-014 | X-Y movement accommodation of the fixed feed inlet | Open |

---

## 16. R&D Sequence

1. Finalize outlet connector geometry.
2. Finalize outlet centre pitches and plate machining coordinates.
3. Define the two-axis moving feed outlet and mechanical sealing method.
4. Determine X and Y moving masses.
5. Select guide shaft diameters and bearings.
6. Select axis drive transmission.
7. Calculate step motor torque and speed.
8. Design the sigma-profile frame.
9. Verify travel limits and mechanical clearances.
10. Update the PLC selector specification for two-axis Cartesian positioning.

---

## 17. Revision History

| Version | Date | Description |
|---|---|---|
| 0.1 | 2026-07-31 | Initial Cartesian selector mechanical R&D document created. |
| 0.2 | 2026-07-31 | Confirmed X-Y-only architecture; excluded Z or separate engagement axis. |
| 0.3 | 2026-07-31 | Selected supported Ø25 shafts and open adjustable sealed bearing blocks for both axes. |
| 0.4 | 2026-07-31 | Selected Ø20 × 5 mm C7 preloaded ball screws and BK15/BF15 supports for both axes. |
| 0.5 | 2026-07-31 | Selected locally available 45-series heavy profiles and added Türkiye procurement policy. |
| 0.6 | 2026-07-31 | Selected matched 8.5 N·m closed-loop step motor and Modbus RTU drive sets for both axes. |
| 0.7 | 2026-07-31 | Selected couplings, motor plates, reference sensors, energy chains and dedicated axis power supplies. |
| 0.8 | 2026-07-31 | Frozen outlet coordinates, axis strokes and preliminary procurement lengths. |
| 0.9 | 2026-07-31 | Added fabricated plate blanks, brackets, fasteners and marine-environment assembly consumables. |
| 0.10 | 2026-07-31 | Added dust protection, removable covers, food-grade lubrication and initial maintenance items. |

---

End of Document
