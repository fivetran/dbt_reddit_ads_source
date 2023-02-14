
with base as (

    select * 
    from {{ ref('stg_reddit_ads__campaign_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_reddit_ads__campaign_tmp')),
                staging_columns=get_campaign_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        account_id,
        configured_status,
        effective_status,
        funding_instrument_id,
        id as campaign_id,
        is_processing,
        name as campaign_name,
        objective
    from fields
)

select * from final
