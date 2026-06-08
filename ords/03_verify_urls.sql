/*
    PVS ORDS Demo Project
    03_verify_urls.sql

    Purpose:
    Show the exact ORDS routes registered for this schema.
*/

SELECT
    s.parsing_schema,
    s.pattern AS schema_alias,
    s.status AS schema_status,
    m.name AS module_name,
    m.status AS module_status,
    m.uri_prefix,
    t.uri_template,
    h.method,
    REGEXP_REPLACE(
        '/ords/' || s.pattern || '/' || m.uri_prefix || '/' || t.uri_template,
        '/+',
        '/'
    ) AS url_path
FROM user_ords_schemas s
JOIN user_ords_modules m
    ON m.schema_id = s.id
JOIN user_ords_templates t
    ON t.module_id = m.id
JOIN user_ords_handlers h
    ON h.template_id = t.id
ORDER BY m.name, t.uri_template, h.method;
