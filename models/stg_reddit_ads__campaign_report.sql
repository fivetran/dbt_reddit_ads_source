
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
        comment_downvotes,
        comment_upvotes,
        comments_page_views,
        conversion_roas,
        cpc,
        ctr,
        day_date, -- renamed in macro
        ecpm,
        impressions,
        region,
        spend,
        video_started,
        video_watched_25_percent,
        video_watched_3_seconds,
        video_watched_50_percent,
        video_watched_5_seconds,
        video_watched_75_percent,
        viewer_comments
    from fields
)

select * from final