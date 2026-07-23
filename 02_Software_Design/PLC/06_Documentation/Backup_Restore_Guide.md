# Backup & Restore Guide

---

# Purpose

This document defines the procedures for backing up and restoring the AquaFeed PLC software, configuration data and project files.

The objective is to ensure rapid recovery after hardware replacement, software corruption or accidental data loss.

---

# Scope

This procedure applies to:

- PLC Application
- PLC Parameters
- Retentive Data
- HMI Project
- Recipes
- User Database
- Modbus Configuration
- Documentation
- Software Source Files

---

# Backup Objectives

Every backup shall ensure:

- Complete software recovery
- Configuration preservation
- Recipe integrity
- User account preservation
- Minimal production downtime
- Version traceability

---

# Backup Types

## Full Backup

Includes:

- PLC application
- HMI application
- Configuration files
- Recipes
- User database
- Documentation

Recommended:

- Before every software release
- Before commissioning
- Before hardware replacement

---

## Incremental Backup

Includes only modified files since the previous backup.

Recommended:

- Daily during active development
- After configuration changes

---

## Emergency Backup

Performed immediately before:

- Firmware update
- PLC replacement
- Major software modification
- Network reconfiguration

---

# Backup Frequency

| Item | Frequency |
|------|-----------|
| PLC Application | Before every modification |
| HMI Project | Before every modification |
| Recipes | Weekly |
| User Database | Weekly |
| Runtime Data | Monthly |
| Documentation | After each approved revision |

---

# Backup Contents

Every backup package shall contain:

```text
Backup/
│
├── PLC/
├── HMI/
├── Recipes/
├── Users/
├── Configuration/
├── Documentation/
├── VersionInfo.txt
└── ChangeLog.txt
```

---

# Backup Naming Convention

Format:

```text
Project_YYYYMMDD_Revision
```

Example:

```text
AquaFeed_20260720_V1.3
```

---

# Backup Procedure

1. Stop automatic operation.
2. Verify production is complete.
3. Save PLC application.
4. Export PLC parameters.
5. Export HMI project.
6. Export recipe database.
7. Export user database.
8. Save documentation.
9. Verify backup integrity.
10. Store backup securely.

---

# Backup Verification

Verify:

- Files exist
- File sizes are correct
- No corruption detected
- Project opens successfully
- Version numbers match
- Archive is readable

---

# Storage Locations

Recommended locations:

- Engineering workstation
- Company file server
- External encrypted storage
- Cloud backup (if approved)

At least two independent backup copies shall exist.

---

# Restore Preparation

Before restoring:

- Verify backup version
- Verify PLC hardware
- Verify firmware compatibility
- Inform operators
- Stop production
- Record current software version

---

# Restore Procedure

1. Power down the system if required.
2. Restore PLC application.
3. Restore configuration.
4. Restore HMI project.
5. Restore recipes.
6. Restore user database.
7. Verify communication.
8. Restart PLC.
9. Verify diagnostics.
10. Perform functional testing.

---

# Post-Restore Verification

Verify:

- PLC starts correctly
- HMI communicates normally
- All devices are online
- Recipes are available
- Users can log in
- Alarm history is operational
- Runtime counters are valid
- Automatic operation completes successfully

---

# Version Control

Each backup shall include:

- Software Version
- PLC Firmware Version
- HMI Version
- Backup Date
- Engineer Name
- Project Name
- Revision Number

---

# Recovery Testing

Backup files shall be periodically tested by performing a complete restore on a test system.

Recovery testing should verify:

- PLC application integrity
- HMI integrity
- Communication
- Recipe loading
- Alarm functions
- Automatic operation

---

# Backup Security

Backups shall be:

- Protected against unauthorized access
- Readable only by authorized personnel
- Protected against accidental deletion
- Archived according to company policy

---

# Recovery Checklist

Before returning to production:

- PLC operating normally
- Communication verified
- No critical alarms
- Safety functions verified
- Automatic feeding tested
- Documentation updated

---

# Related Documents

- Commissioning_Guide.md
- Maintenance_Guide.md
- Software_Release_Process.md
- Version_History.md

---

# Revision

Version 1.0