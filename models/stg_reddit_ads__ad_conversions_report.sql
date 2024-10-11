{{ config(enabled=var('ad_reporting__reddit_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_reddit_ads__ad_conversions_report_base') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_reddit_ads__ad_conversions_report_base')),
                staging_columns=get_ad_conversions_report_columns()
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
        ad_id,
        avg_value,
        click_through_conversion_attribution_window_month as conversions,
        date as date_day,
        event_name,
        total_items,
        total_value,
        view_through_conversion_attribution_window_month as view_through_conversions
        
        {{ fivetran_utils.fill_pass_through_columns('reddit_ads__ad_conversions_passthrough_metrics') }}
    from fields
)

select *
from final
