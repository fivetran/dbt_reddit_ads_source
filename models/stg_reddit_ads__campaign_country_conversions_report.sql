
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
        date as date_day,
        account_id,
        campaign_id,
        country,
        avg_value,
        click_through_conversion_attribution_window_day,
        click_through_conversion_attribution_window_month,
        click_through_conversion_attribution_window_week,
        event_name,
        total_items,
        total_value,
        view_through_conversion_attribution_window_day,
        view_through_conversion_attribution_window_month,
        view_through_conversion_attribution_window_week,
        _fivetran_synced
    from fields
)

select *
from final
