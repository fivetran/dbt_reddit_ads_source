# dbt_reddit_ads_source v0.3.0
[PR #7](https://github.com/fivetran/dbt_reddit_ads_source/pull/7) includes the following updates:

## Feature: Conversion Metrics
- Introduces 4 new staging models to bring in conversion metrics across different grains:
  - `stg_reddit_ads__account_conversions_report`
  - `stg_reddit_ads__ad_group_conversions_report`
  - `stg_reddit_ads__ad_conversions_report`
  - `stg_reddit_ads__campaign_conversions_report`
- These models bring in conversions (click-through conversions) and view-through conversions, in addition to total items and total value, for each day and respective grain.
- We use the maximum attribution window when considering conversions and therefore retrieve conversions metrics from the `click_through_conversion_attribution_window_month` and `view_through_conversion_attribution_window_month` fields in the respective source tables. You may bring in additional windows and fields through the `stg_<>_conversions_report` models via the `<entity>_conversions_passthrough_metrics` variables. For information on how to configure these variables, refer to the [README](https://github.com/fivetran/dbt_reddit_ads_source/blob/main/README.md#passing-through-additional-metrics).

## Under the hood
- Added the respective seed data for the new models in addition to updating relevant documentation.
- Added documentation explaining potential discrepancies across reporting grains.

# dbt_reddit_ads_source v0.2.0
[PR #5](https://github.com/fivetran/dbt_reddit_ads_source/pull/5) includes the following updates:
## Feature update 🎉
- Unioning capability! This adds the ability to union source data from multiple reddit_ads connectors. Refer to the [Union Multiple Connectors README section](https://github.com/fivetran/dbt_reddit_ads_source/blob/main/README.md#union-multiple-connectors) for more details.

## Under the hood 🚘
- Updated tmp models to union source data using the `fivetran_utils.union_data` macro. 
- To distinguish which source each field comes from, added `source_relation` column in each staging model and applied the `fivetran_utils.source_relation` macro.
- Updated tests to account for the new `source_relation` column.
- Incorporated the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job.
- Updated the pull request [templates](/.github).
# dbt_reddit_ads_source v0.1.0

## Initial Release
- This is the initial release of this package. 

# 📣 What does this dbt package do?
- Materializes [Reddit Ads staging tables](https://fivetran.github.io/dbt_reddit_ads_source/#!/overview/reddit_ads_source/models/?g_v=1&g_e=seeds) which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/reddit-ads#schemainformation). These staging tables clean, test, and prepare your reddit_ads data from [Fivetran's connector](https://fivetran.com/docs/applications/reddit-ads) for analysis by doing the following:
  - Names columns for consistency across all packages and for easier analysis
  - Adds freshness tests to source data
  - Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
- Generates a comprehensive data dictionary of your Reddit Ads data through the [dbt docs site](https://fivetran.github.io/dbt_reddit_ads_source/).
- These tables are designed to work simultaneously with our [Reddit Ads transformation package](https://github.com/fivetran/dbt_reddit_ads).


For more information refer to the [README](https://github.com/fivetran/dbt_reddit_ads_source/blob/main/README.md).
