{% macro get_account_conversions_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "account_id", "datatype": dbt.type_string()},
    {"name": "avg_value", "datatype": dbt.type_float()},
    {"name": "click_through_conversion_attribution_window_day", "datatype": dbt.type_int()},
    {"name": "click_through_conversion_attribution_window_month", "datatype": dbt.type_int()},
    {"name": "click_through_conversion_attribution_window_week", "datatype": dbt.type_int()},
    {"name": "date", "datatype": "date"},
    {"name": "event_name", "datatype": dbt.type_string()},
    {"name": "total_items", "datatype": dbt.type_int()},
    {"name": "total_value", "datatype": dbt.type_int()},
    {"name": "view_through_conversion_attribution_window_day", "datatype": dbt.type_int()},
    {"name": "view_through_conversion_attribution_window_month", "datatype": dbt.type_int()},
    {"name": "view_through_conversion_attribution_window_week", "datatype": dbt.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
