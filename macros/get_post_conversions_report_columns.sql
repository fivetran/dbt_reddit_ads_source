{% macro get_post_conversions_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "avg_value", "datatype": dbt_utils.type_float()},
    {"name": "click_through_conversion_attribution_window_day", "datatype": dbt_utils.type_int()},
    {"name": "click_through_conversion_attribution_window_month", "datatype": dbt_utils.type_int()},
    {"name": "click_through_conversion_attribution_window_week", "datatype": dbt_utils.type_int()},
    {"name": "date", "datatype": "date"},
    {"name": "event_name", "datatype": dbt_utils.type_string()},
    {"name": "post_id", "datatype": dbt_utils.type_string()},
    {"name": "total_items", "datatype": dbt_utils.type_int()},
    {"name": "total_value", "datatype": dbt_utils.type_int()},
    {"name": "view_through_conversion_attribution_window_day", "datatype": dbt_utils.type_int()},
    {"name": "view_through_conversion_attribution_window_month", "datatype": dbt_utils.type_int()},
    {"name": "view_through_conversion_attribution_window_week", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
