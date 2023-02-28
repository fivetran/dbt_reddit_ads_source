{{ config(enabled=var('ad_reporting__reddit_ads_enabled', True)) }}

with base as (

    select * 
    from {{ ref('stg_reddit_ads__post_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_reddit_ads__post_report_tmp')),
                staging_columns=get_post_report_columns()
            )
        }}
    from base
),

final as (
    
    select 
        account_id,
        post_id,
        clicks,
        comment_downvotes,
        comment_upvotes,
        comments_page_views,
        conversion_roas,
        cpc,
        ctr,
        date as date_day,
        ecpm,
        impressions,
        region,
        (spend/1000000) as spend,
        video_started,
        video_watched_25_percent,
        video_watched_3_seconds,
        video_watched_50_percent,
        video_watched_5_seconds,
        video_watched_75_percent,
        viewer_comments
    from fields
)

select *
from final