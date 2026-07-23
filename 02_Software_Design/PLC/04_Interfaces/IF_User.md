# IF_User

---

# Purpose

Defines the standard software interface for user authentication and authorization.

This interface provides a common user management model for the PLC, HMI and AquaFeed Manager.

---

# Inputs

| Name | Type | Description |
|------|------|-------------|
| Login | BOOL | Requests user login. |
| Logout | BOOL | Requests user logout. |
| Username | STRING[32] | User name. |
| Password | STRING[32] | User password. |
| Reset | BOOL | Clears the current session. |

---

# Outputs

| Name | Type | Description |
|------|------|-------------|
| LoggedIn | BOOL | User is authenticated. |
| UserLevel | UINT | Current authorization level. |
| UserName | STRING[32] | Logged in user name. |
| PermissionGranted | BOOL | Requested operation is permitted. |
| SessionActive | BOOL | User session is active. |
| AlarmCode | UINT | Active authentication alarm code. |

---

# User Levels

| Level | Description |
|------:|-------------|
| 0 | Guest |
| 1 | Operator |
| 2 | Supervisor |
| 3 | Service |
| 4 | Administrator |

---

# State Flow

```text
Logged Out
      │
Login
      │
Authentication
      │
Logged In
      │
Authorized Operation
      │
Logout
      │
Logged Out
```

Authentication failure

```text
Login
    │
Invalid Credentials
    │
Access Denied
    │
Retry
```

---

# Rules

- Only one user session shall be active at a time.
- User permissions shall be verified before executing restricted operations.
- Logout shall immediately invalidate the active session.
- Failed authentication attempts shall generate an alarm event.
- `AlarmCode` shall be zero when authentication is successful.

---

# Used By

- FB_UserManager
- FB_SystemManager
- FB_RecipeManager
- FB_MaintenanceManager
- HMI
- AquaFeed Manager