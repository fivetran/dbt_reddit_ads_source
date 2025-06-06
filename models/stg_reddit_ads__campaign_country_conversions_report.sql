{{ config(enabled=fivetran_utils.enabled_vars([
    'ad_reporting__reddit_ads_enabled',
    'reddit_ads__using_campaign_country_report',
    'reddit_ads__using_campaign_country_conversions_report'])
) }}

with base as (

    select * 
    from {{ ref('stg_reddit_ads__campaign_country_conversions_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_reddit_ads__campaign_country_conversions_report_tmp')),
                staging_columns=get_campaign_country_conversions_report_columns()
            )
        }}
        {{ fivetran_utils.source_relation(
            union_schema_variable='reddit_ads_union_schemas', 
            union_database_variable='reddit_ads_union_databases') 
        }}
    from base
),

final as (
    
    select 
        source_relation, 
        _fivetran_synced,
        account_id,
        campaign_id,
        date as date_day,
        country,
        lower(event_name) as event_name,
        coalesce(total_items,0) as total_items,
        coalesce(total_value,0) as total_value,
        coalesce(click_through_conversion_attribution_window_month,0) as conversions,
        coalesce(view_through_conversion_attribution_window_month,0) as view_through_conversions

        {{ fivetran_utils.fill_pass_through_columns('reddit_ads__campaign_country_conversions_passthrough_metrics') }}
    from fields
)

select *
from final
