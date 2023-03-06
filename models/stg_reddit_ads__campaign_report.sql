{{ config(enabled=var('ad_reporting__reddit_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_reddit_ads__campaign_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_reddit_ads__campaign_report_tmp')),
                staging_columns=get_campaign_report_columns()
            )
        }}
    from base
),

final as (
    
    select 
        account_id,
        campaign_id,
        clicks,
        date as date_day,
        impressions,
        region,
        (spend/1000000) as spend
        
        {{ fivetran_utils.fill_pass_through_columns('reddit_ads__campaign_passthrough_metrics') }}
    from fields
)

select *
from final