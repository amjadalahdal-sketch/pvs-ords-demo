/*
    PVS ORDS Demo Project
    01_enable_schema.sql

    Purpose:
    Enable the existing Oracle schema for ORDS access.

    Schema base URL:
    http://localhost:8080/ords/pvsdemo/

    If this URL returns 404 but APEX still works, check that the ORDS pool
    uses ORDS_PUBLIC_USER. See ords/00_fix_runtime_user.sql.
*/

BEGIN 
	ORDS.ENABLE_SCHEMA (
		p_enabled 				=> TRUE, 
		p_schema				=> 'ENERGY_DEMO',
		p_url_mapping_type		=> 'BASE_PATH',
		p_url_mapping_pattern	=> 'pvsdemo',
		p_auto_rest_auth		=> FALSE
		); 
		COMMIT; 
	END; 
	/
