{% macro get_account_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "attribution_type", "datatype": dbt_utils.type_string()},
    {"name": "click_attribution_window", "datatype": dbt_utils.type_string()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "time_zone_id", "datatype": dbt_utils.type_string()},
    {"name": "view_attribution_window", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
