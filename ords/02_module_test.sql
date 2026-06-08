/*
    PVS ORDS Demo Project
    02_module_test.sql

    Purpose:
    Create a simple ORDS test endpoint.

    URL:
    http://localhost:8080/ords/pvsdemo/test/ping/
*/

BEGIN
    ORDS.DEFINE_MODULE(
        p_module_name    => 'pvs_demo_test',
        p_base_path      => 'test/',
        p_items_per_page => 25,
        p_status         => 'PUBLISHED',
        p_comments       => 'Test module for PVS ORDS demo'
    );

    ORDS.DEFINE_TEMPLATE(
        p_module_name => 'pvs_demo_test',
        p_pattern     => 'ping/'
    );

    ORDS.DEFINE_HANDLER(
        p_module_name    => 'pvs_demo_test',
        p_pattern        => 'ping/',
        p_method         => 'GET',
        p_source_type    => ORDS.source_type_query_one_row,
        p_source         => q'[
            SELECT
                'OK' AS status,
                'PVS ORDS demo is working' AS message,
                SYSTIMESTAMP AS server_time
            FROM dual
        ]',
        p_items_per_page => 0
    );

    COMMIT;
END;
/
