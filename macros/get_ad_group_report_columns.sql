{% macro get_ad_group_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "account_id", "datatype": dbt_utils.type_string()},
    {"name": "ad_group_id", "datatype": dbt_utils.type_string()},    
    {"name": "clicks", "datatype": dbt_utils.type_int()},
    {"name": "comment_downvotes", "datatype": dbt_utils.type_int()},
    {"name": "comment_upvotes", "datatype": dbt_utils.type_int()},
    {"name": "comments_page_views", "datatype": dbt_utils.type_int()},
    {"name": "conversion_roas", "datatype": dbt_utils.type_float()},
    {"name": "cpc", "datatype": dbt_utils.type_float()},
    {"name": "ctr", "datatype": dbt_utils.type_float()},
    {"name": "date", "datatype": "date"},
    {"name": "ecpm", "datatype": dbt_utils.type_float()},
    {"name": "impressions", "datatype": dbt_utils.type_int()},
    {"name": "region", "datatype": dbt_utils.type_string()},
    {"name": "spend", "datatype": dbt_utils.type_int()},
    {"name": "video_started", "datatype": dbt_utils.type_int()},
    {"name": "video_watched_25_percent", "datatype": dbt_utils.type_int()},
    {"name": "video_watched_3_seconds", "datatype": dbt_utils.type_int()},
    {"name": "video_watched_50_percent", "datatype": dbt_utils.type_int()},
    {"name": "video_watched_5_seconds", "datatype": dbt_utils.type_int()},
    {"name": "video_watched_75_percent", "datatype": dbt_utils.type_int()},
    {"name": "viewer_comments", "datatype": dbt_utils.type_int()}
] %}

{% if target.type in ('bigquery', 'spark', 'databricks') %}
    {{ columns.append( {"name": 'date', "datatype": "date", "quote": True, "alias": "day_date" } ) }}

{% else %}
    {{ columns.append( {"name": 'date', "datatype": "date", "alias": "day_date"} ) }}

{% endif %}

{{ return(columns) }}

{% endmacro %}
