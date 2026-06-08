/*
    PVS ORDS Demo Project
    00_fix_runtime_user.sql

    Purpose:
    Repair the common ORDS 404 case where the ORDS pool is not using the
    runtime user.

    Run as SYS in XEPDB1, then update the ORDS pool configuration:

        ords --config C:\ords config set db.username ORDS_PUBLIC_USER
        '<password>' | ords --config C:\ords config secret --password-stdin db.password

    Restart ORDS after changing the pool configuration.
*/

ACCEPT ords_public_user_password CHAR PROMPT 'New ORDS_PUBLIC_USER password: ' HIDE

ALTER USER ORDS_PUBLIC_USER
    IDENTIFIED BY "&ords_public_user_password"
    ACCOUNT UNLOCK;

SELECT username, account_status
FROM dba_users
WHERE username IN ('ORDS_PUBLIC_USER', 'ORDSYS', 'APEX_PUBLIC_USER')
ORDER BY username;

SELECT grantee, granted_role
FROM dba_role_privs
WHERE grantee IN ('ORDS_PUBLIC_USER', 'ORDSYS')
ORDER BY grantee, granted_role;

UNDEFINE ords_public_user_password
