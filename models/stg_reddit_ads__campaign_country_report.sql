
with base as (

    select * 
    from {{ ref('stg_reddit_ads__campaign_country_report_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_reddit_ads__campaign_country_report_tmp')),
                staging_columns=get_campaign_country_report_columns()
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
        app_install_metrics_add_payment_info,
        app_install_metrics_add_to_cart,
        app_install_metrics_app_launch,
        app_install_metrics_completed_tutorial,
        app_install_metrics_install,
        app_install_metrics_level_achieved,
        app_install_metrics_purchase,
        app_install_metrics_search,
        app_install_metrics_sign_up,
        app_install_metrics_spend,
        app_install_metrics_spend_credits,
        app_install_metrics_view_content,
        clicks,
        comment_downvotes,
        comment_upvotes,
        comments_page_views,
        conversion_roas,
        cpc,
        ctr,
        ecpm,
        gallery_item_caption,
        gallery_item_id,
        impressions,
        legacy_click_conversions_attribution_window_day,
        legacy_click_conversions_attribution_window_month,
        legacy_click_conversions_attribution_window_week,
        legacy_view_conversions_attribution_window_day,
        legacy_view_conversions_attribution_window_month,
        legacy_view_conversions_attribution_window_week,
        priority,
        region,
        spend,
        video_fully_viewable_impressions,
        video_plays_expanded,
        video_plays_with_sound,
        video_started,
        video_viewable_impressions,
        video_watched_100_percent,
        video_watched_10_seconds,
        video_watched_25_percent,
        video_watched_3_seconds,
        video_watched_50_percent,
        video_watched_5_seconds,
        video_watched_75_percent,
        video_watched_95_percent,
        viewable_impressions,
        viewer_comments,
        _fivetran_synced
    from fields
)

select *
from final
