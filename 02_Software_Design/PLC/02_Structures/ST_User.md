# ST_User

---

# Purpose

Represents an operator or system user.

This structure stores user identity, authorization level and login information.

---

# Structure

```iecst
TYPE ST_User :
STRUCT

    UserId              : UINT;

    UserName            : STRING[30];

    FullName            : STRING[50];

    PasswordHash        : STRING[128];

    Role                : E_UserRole;

    Enabled             : BOOL;

    LoggedIn            : BOOL;

    LastLogin           : DT;

    LastLogout          : DT;

    FailedLoginCount    : USINT;

    AccountLocked       : BOOL;

    SessionTimeoutMin   : UINT;

END_STRUCT
END_TYPE
```

---

# Updated By

Desktop Application

User Management

---

# Read By

FB_SystemManager

HMI

Desktop Application

Audit System

---

# Description

UserId

Unique user identifier.

---

UserName

Login name.

---

FullName

Operator full name.

---

PasswordHash

Encrypted password.

Plain-text passwords shall never be stored.

---

Role

User permission level.

Example

- Administrator
- Supervisor
- Operator
- Service
- Guest

---

Enabled

Account available.

---

LoggedIn

Current login status.

---

LastLogin

Last successful login.

---

LastLogout

Last logout time.

---

FailedLoginCount

Consecutive failed login attempts.

---

AccountLocked

Account locked due to security policy.

---

SessionTimeoutMin

Automatic logout timeout.

---

# Rules

UserId shall be unique.

Passwords shall always be hashed.

Guest users cannot modify configuration.

Service users may access maintenance functions.

Only administrators may manage users.

---

# Lifetime

Stored permanently in the database.

PLC keeps only the active user information.

---

# Example

```iecst
Users[1]
Users[2]
Users[3]
...
Users[50]
```

---

# Used By

- Login Screen
- User Manager
- Alarm Acknowledgement
- Recipe Manager
- Maintenance
- Audit Log