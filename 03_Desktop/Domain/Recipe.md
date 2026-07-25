# Recipe Domain Model

| Field | Value |
|---|---|
| Status | Authoritative |
| Owner | AquaFeed Manager / Desktop |
| Persistence | Database |
| Version | 1.0 |

## Purpose

Represents a versioned feeding recipe and its business metadata.

Desktop owns recipe creation, editing, approval, versioning, names, audit fields, compatible lines, repeat programs, and historical usage.

## Core Data

- unique Recipe ID and revision
- name and description
- enabled/approved status
- compatible line/equipment configuration
- dosing and blower setpoints
- pre-run, post-run, and selector-settle times
- quantity tolerance and maximum execution limits
- repeat/program configuration
- created, modified, and approved user references
- timestamps and revision history

## Rules

- An approved revision is immutable.
- Editing creates a new revision.
- Desktop validates business and configuration rules before transfer.
- An active PLC execution keeps the accepted revision even if a newer Desktop revision exists.
- Values transferred to PLC are bounded to approved engineering limits.

## PLC Boundary

The PLC receives [ST_RecipeExecution](../../02_Software_Design/PLC/02_Structures/ST_RecipeExecution.md), not names, audit fields, or historical metadata.
