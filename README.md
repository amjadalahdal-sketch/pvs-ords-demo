# PVS ORDS Demo Project

Small Oracle + ORDS demo project for practicing:

- Oracle SQL
- PL/SQL
- ORDS REST APIs
- JSON
- OpenAPI / Swagger
- Pagination
- Filtering
- Sorting
- Bulk operations
- Git

## ORDS test endpoint

This project exposes a simple ORDS ping endpoint from the `ENERGY_DEMO`
schema.

Run the endpoint scripts as `ENERGY_DEMO`:

1. `ords/01_enable_schema.sql`
2. `ords/02_module_test.sql`
3. `ords/03_verify_urls.sql`

The ping endpoint is:

```text
http://localhost:8080/ords/pvsdemo/test/ping/
```

The OpenAPI/metadata catalog is:

```text
http://localhost:8080/ords/pvsdemo/metadata-catalog/
```

## ORDS 404 troubleshooting

Problem found on this machine:

- `http://localhost:8080/ords/` worked.
- Oracle APEX still worked at `http://localhost:8080/ords/apex`.
- The `ENERGY_DEMO` ORDS metadata existed in `XEPDB1`.
- But `http://localhost:8080/ords/pvsdemo/test/ping/` returned `404`.

Root cause:

The ORDS pool was configured with `db.username = ORDSYS`. That user owns ORDS
metadata, but it is not the runtime user. The runtime pool must use
`ORDS_PUBLIC_USER`, which has `ORDS_RUNTIME_ROLE`. In this environment,
`ORDS_PUBLIC_USER` was also expired.

Solution:

1. As `SYS` in `XEPDB1`, unlock/reset `ORDS_PUBLIC_USER`.
2. Configure the ORDS pool to use `ORDS_PUBLIC_USER`.
3. Restart ORDS.
4. Rerun the endpoint scripts as `ENERGY_DEMO`.

SQL helper:

```text
ords/00_fix_runtime_user.sql
```

ORDS config commands:

```powershell
ords --config C:\ords config set db.username ORDS_PUBLIC_USER
'<ORDS_PUBLIC_USER_PASSWORD>' | ords --config C:\ords config secret --password-stdin db.password
```

After restarting ORDS, verify:

```text
http://localhost:8080/ords/apex
http://localhost:8080/ords/pvsdemo/test/ping/
http://localhost:8080/ords/pvsdemo/metadata-catalog/
```
