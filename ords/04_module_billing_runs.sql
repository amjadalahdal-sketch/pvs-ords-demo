/*
    PVS ORDS Demo Project
    04_module_billing_runs.sql

    Purpose:
    Create first real ORDS endpoint:

    GET /ords/pvsdemo/billing/runs/
*/

BEGIN
    ORDS.DEFINE_MODULE(
        p_module_name    => 'pvs_demo_billing',
        p_base_path      => '/billing/',
        p_items_per_page => 25,
        p_status         => 'PUBLISHED',
        p_comments       => 'Billing API module for PVS ORDS demo'
    );

    ORDS.DEFINE_TEMPLATE(
        p_module_name => 'pvs_demo_billing',
        p_pattern     => 'runs/'
    );

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'pvs_demo_billing',
        p_pattern        => 'runs/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query,
        p_source         => q'[
            SELECT
                billing_run_id AS "billingRunId",
                run_name       AS "runName",
                TO_CHAR(period_from, 'YYYY-MM-DD') AS "periodFrom",
                TO_CHAR(period_to,   'YYYY-MM-DD') AS "periodTo",
                status         AS "status",
                TO_CHAR(created_at, 'YYYY-MM-DD"T"HH24:MI:SS') AS "createdAt",
                created_by     AS "createdBy",
                TO_CHAR(finalized_at, 'YYYY-MM-DD"T"HH24:MI:SS') AS "finalizedAt"
            FROM billing_runs
            ORDER BY billing_run_id DESC
        ]',
        p_items_per_page => 25
    );

    COMMIT;
END;
/