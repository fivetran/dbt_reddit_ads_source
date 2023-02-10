{% macro get_campaign_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "configured_status", "datatype": dbt_utils.type_string()},
    {"name": "effective_status", "datatype": dbt_utils.type_string()},
    {"name": "funding_instrument_id", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "is_processing", "datatype": "boolean"},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "objective", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
