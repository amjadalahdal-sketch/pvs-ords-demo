/*
    PVS ORDS Demo Project
    Existing Schema Reference

    This ORDS demo uses the existing Energy Data Management database schema.

    Main existing tables:
    - ENERGY_CUSTOMERS
    - ENERGY_METERING_POINTS
    - ENERGY_METERS
    - ENERGY_CONSUMPTION
    - ENERGY_TARIFFS
    - BILLING_RUNS
    - BILLING_ITEMS

    Existing PL/SQL packages:
    - PKG_ENERGY_CORE
    - PKG_ENERGY_BILLING
    - PKG_ENERGY_SECURITY

    Goal of this project:
    Add a direct ORDS REST API layer on top of the existing Oracle database
    without using Spring Boot, Angular, or APEX.
*/