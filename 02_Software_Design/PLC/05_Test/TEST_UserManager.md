# TEST_UserManager

---

# Purpose

Verify the correct operation of FB_UserManager.

This test validates user authentication, authorization, permission levels, session management, password handling and audit logging.

---

# Preconditions

- PLC powered on
- HMI operational
- User database initialized
- At least one Administrator account available

---

# Test Cases

## TC-001 Administrator Login

### Procedure

1. Enter valid Administrator credentials.
2. Press Login.

### Expected Result

- Login successful.
- UserRole = Administrator.
- Full system access granted.

Result

□ PASS

□ FAIL

---

## TC-002 Operator Login

### Procedure

1. Enter valid Operator credentials.

### Expected Result

- Login successful.
- UserRole = Operator.
- Operator permissions applied.

Result

□ PASS

□ FAIL

---

## TC-003 Invalid Password

### Procedure

1. Enter incorrect password.

### Expected Result

- Login rejected.
- AuthenticationFailed = TRUE.
- Failed login recorded.

Result

□ PASS

□ FAIL

---

## TC-004 Unauthorized Function

### Procedure

1. Login as Operator.
2. Attempt to edit a recipe.

### Expected Result

- Access denied.
- Permission alarm generated.
- Recipe unchanged.

Result

□ PASS

□ FAIL

---

## TC-005 User Logout

### Procedure

1. Login successfully.
2. Press Logout.

### Expected Result

- Session terminated.
- CurrentUser cleared.
- Protected functions disabled.

Result

□ PASS

□ FAIL

---

## TC-006 Session Timeout

### Procedure

1. Login successfully.
2. Leave the HMI inactive until timeout expires.

### Expected Result

- Automatic logout executed.
- Session closed safely.
- Login screen displayed.

Result

□ PASS

□ FAIL

---

## TC-007 Change Password

### Procedure

1. Login as Administrator.
2. Change password.
3. Logout.
4. Login using the new password.

### Expected Result

- Password updated successfully.
- Old password rejected.
- New password accepted.

Result

□ PASS

□ FAIL

---

## TC-008 Create New User

### Procedure

1. Login as Administrator.
2. Create a new Operator account.

### Expected Result

- User stored successfully.
- Assigned permissions saved.
- User available for login.

Result

□ PASS

□ FAIL

---

## TC-009 Delete User

### Procedure

1. Delete an inactive user account.

### Expected Result

- User removed.
- Login no longer possible.
- Audit log updated.

Result

□ PASS

□ FAIL

---

## TC-010 Audit Log Verification

### Procedure

1. Perform multiple login and logout operations.
2. Review audit history.

### Expected Result

- Login time recorded.
- Logout time recorded.
- User ID recorded.
- Event history complete.

Result

□ PASS

□ FAIL

---

# Acceptance Criteria

- Only authenticated users shall access the system.
- User permissions shall be enforced consistently.
- Unauthorized operations shall always be rejected.
- Session timeout shall protect unattended terminals.
- All user activities shall be logged for traceability.
- All test cases shall pass successfully.

---

# Tested Module

FB_UserManager

---

# Related Modules

- FB_RecipeManager
- FB_MaintenanceManager
- FB_SystemManager
- FB_AlarmManager
- HMI
- AquaFeed Manager

---

# Revision

Version 1.0