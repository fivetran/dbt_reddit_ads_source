{% macro get_campaign_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "account_id", "datatype": dbt.type_string()},
    {"name": "campaign_id", "datatype": dbt.type_string()},
    {"name": "clicks", "datatype": dbt.type_int()},
    {"name": "comment_downvotes", "datatype": dbt.type_int()},
    {"name": "comment_upvotes", "datatype": dbt.type_int()},
    {"name": "comments_page_views", "datatype": dbt.type_int()},
    {"name": "conversion_roas", "datatype": dbt.type_float()},
    {"name": "cpc", "datatype": dbt.type_float()},
    {"name": "ctr", "datatype": dbt.type_float()},
    {"name": "date", "datatype": "date"},
    {"name": "ecpm", "datatype": dbt.type_float()},
    {"name": "impressions", "datatype": dbt.type_int()},
    {"name": "region", "datatype": dbt.type_string()},
    {"name": "spend", "datatype": dbt.type_int()},
    {"name": "video_started", "datatype": dbt.type_int()},
    {"name": "video_watched_25_percent", "datatype": dbt.type_int()},
    {"name": "video_watched_3_seconds", "datatype": dbt.type_int()},
    {"name": "video_watched_50_percent", "datatype": dbt.type_int()},
    {"name": "video_watched_5_seconds", "datatype": dbt.type_int()},
    {"name": "video_watched_75_percent", "datatype": dbt.type_int()},
    {"name": "viewer_comments", "datatype": dbt.type_int()}
] %}

{% if target.type in ('bigquery', 'spark', 'databricks') %}
    {{ columns.append( {"name": 'date', "datatype": "date", "quote": True, "alias": "date_day" } ) }}

{% else %}
    {{ columns.append( {"name": 'date', "datatype": "date", "alias": "date_day"} ) }}

{% endif %}

{{ return(columns) }}

{% endmacro %}
