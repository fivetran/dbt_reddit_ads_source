# dbt_reddit_ads_source v0.6.0
[PR #14](https://github.com/fivetran/dbt_reddit_ads_source/pull/14) includes the following updates:

## Breaking Change
- To align with the [Fivetran Reddit Ads Connector schema](https://fivetran.com/docs/connectors/applications/reddit-ads#schemainformation), updated the source referenced by `stg_reddit_ads__account_tmp` from `ACCOUNT` to `BUSINESS_ACCOUNT`.
- Added the `reddit_ads__using_business_account` variable to control which source is used. 
  - For Quickstart users, this variable is set automatically.
  - For dbt Core users, this variable is `true` by default, but you can set the variable to `false` in your `dbt_project.yml` to fall back to using `ACCOUNT` instead of `BUSINESS_ACCOUNT`.

## Documentation
- Added documentation for `BUSINESS_ACCOUNT`.

## Under the Hood
- Added seed `reddit_ads_business_account_data`.
- Updated the seed column types in `integration_tests/dbt_project.yml`.

# dbt_reddit_ads_source v0.5.0

[PR #13](https://github.com/fivetran/dbt_reddit_ads_source/pull/13) includes the following updates:

## Breaking Change for dbt Core < 1.9.6
> *Note: This is not relevant to Fivetran Quickstart users.*

Migrated `freshness` from a top-level source property to a source `config` in alignment with [recent updates](https://github.com/dbt-labs/dbt-core/issues/11506) from dbt Core. This will resolve the following deprecation warning that users running dbt >= 1.9.6 may have received:

```
[WARNING]: Deprecated functionality
Found `freshness` as a top-level property of `reddit_ads` in file
`models/src_reddit_ads.yml`. The `freshness` top-level property should be moved
into the `config` of `reddit_ads`.
```

**IMPORTANT:** Users running dbt Core < 1.9.6 will not be able to utilize freshness tests in this release or any subsequent releases, as older versions of dbt will not recognize freshness as a source `config` and therefore not run the tests.

If you are using dbt Core < 1.9.6 and want to continue running Reddit Ads freshness tests, please elect **one** of the following options:
  1. (Recommended) Upgrade to dbt Core >= 1.9.6
  2. Do not upgrade your installed version of the `reddit_ads_source` package. Pin your dependency on v0.4.1 in your `packages.yml` file.
  3. Utilize a dbt [override](https://docs.getdbt.com/reference/resource-properties/overrides) to overwrite the package's `reddit_ads` source and apply freshness via the [old](https://github.com/fivetran/dbt_reddit_ads_source/blob/v0.4.1/models/src_reddit_ads.yml#L11-L13) top-level property route. This will require you to copy and paste the entirety of the `src_reddit_ads.yml` [file](https://github.com/fivetran/dbt_reddit_ads_source/blob/v0.4.1/models/src_reddit_ads.yml#L4-L505) and add an `overrides: reddit_ads_source` property.

## Under the Hood
- Updated the package maintainer PR template.

# dbt_reddit_ads_source v0.4.1
[PR #11](https://github.com/fivetran/dbt_reddit_ads_source/pull/11) includes the following updates:

## Bug Fix
- Updates the uniqueness test of the recently introduced `stg_reddit_ads__campaign_country_conversions_report` model to include `event_name`. This is aligned with the other `*_conversions_report` tables in this package.

# dbt_reddit_ads_source v0.4.0
[PR #10](https://github.com/fivetran/dbt_reddit_ads_source/pull/10) includes the following updates:

## Schema Changes
4 new models • 0 possible breaking changes

| Data Model                                                   | Change type | Old name | New name | Notes                                           |
|--------------------------------------------------------------|-------------|----------|----------|-------------------------------------------------|
| [`stg_reddit_ads__campaign_country_report`](https://fivetran.github.io/dbt_reddit_ads/#!/model/model.reddit_ads.stg_reddit_ads__campaign_country_report) | New Staging Model   | | | Uses `CAMPAIGN_COUNTRY_REPORT` source table |
| [`stg_reddit_ads__campaign_country_conversions_report`](https://fivetran.github.io/dbt_reddit_ads/#!/model/model.reddit_ads.stg_reddit_ads__campaign_country_conversions_report) | New Staging Model   | | | Uses `CAMPAIGN_COUNTRY_CONVERSIONS_REPORT` source table       |
| [`stg_reddit_ads__campaign_country_report_tmp`](https://fivetran.github.io/dbt_reddit_ads/#!/model/model.reddit_ads.stg_reddit_ads__campaign_country_report_tmp) | New Temp Model   | | | Uses `CAMPAIGN_COUNTRY_REPORT` source table |
| [`stg_reddit_ads__campaign_country_conversions_report_tmp`](https://fivetran.github.io/dbt_reddit_ads/#!/model/model.reddit_ads.stg_reddit_ads__campaign_country_conversions_report_tmp) | New Temp Model   | | | Uses `CAMPAIGN_COUNTRY_CONVERSIONS_REPORT` source table       |

## Features
- Added the following vars to enable/disable the new sources. See the [README](https://github.com/fivetran/dbt_reddit_ads_source/blob/main/README.md#Step-4-Enable-disable-models-and-sources) for more details.
  - `reddit_ads__using_campaign_country_report`
    - Default is `true`. 
    - Will disable `stg_reddit_ads__campaign_country_report` and `stg_reddit_ads__campaign_country_conversions_report` if false.
  - `reddit_ads__using_campaign_country_conversions_report`
    - Default is `true`. 
    - Will disable `stg_reddit_ads__campaign_country_conversions_report` if false.
- Added the following vars to allow bringing additional metrics. Refer to the [README](https://github.com/fivetran/dbt_pinterest_ads/blob/main/README.md#passing-through-additional-metrics) for more details.
  - `reddit_ads__campaign_country_passthrough_metrics`
    - Passes additional metrics to `stg_reddit_ads__campaign_country_report`
  - `reddit_ads__campaign_country_conversions_passthrough_metrics`
    - Passes additional metrics to `stg_reddit_ads__campaign_country_conversions_report`

## Under the Hood
- Added `get_*_columns` macros for new sources
- Added seed data for testing new sources

## Documentation
- Updated dbt documentation to reflect new tables and column additions.
- Corrected references to connectors and connections in the README. ([#9](https://github.com/fivetran/dbt_reddit_ads_source/pull/9))

# dbt_reddit_ads_source v0.3.0
[PR #7](https://github.com/fivetran/dbt_reddit_ads_source/pull/7) includes the following **BREAKING CHANGE** updates:

## Feature: Conversion Metrics
- Introduces 4 new staging models to bring in conversion metrics (click-through conversions, view-through conversions, total value, and total items) across different dimensions:
  - `stg_reddit_ads__account_conversions_report`
  - `stg_reddit_ads__ad_group_conversions_report`
  - `stg_reddit_ads__ad_conversions_report`
  - `stg_reddit_ads__campaign_conversions_report`
> Note: If you would like to include conversion metrics, please ensure you have the `account_conversions_report`, `ad_group_conversions_report`, `ad_conversions_report`, and `campaign_conversions_report` source tables syncing in your Reddit Ads connector(s). Otherwise, the package will run successfully but produce `null` conversion metric values.

- Introduces the `<entity>_conversions_passthrough_metrics` variables to allow additional fields from the source `*_conversion_report` tables. We use the maximum attribution window when considering conversions and therefore retrieve conversions metrics from the `click_through_conversion_attribution_window_month` (conversions) and `view_through_conversion_attribution_window_month` (view_through_conversions) fields from the respective source tables. For information on how to configure these variables to bring in additional windows and fields into the `stg_<entity>_conversions_report` models, refer to the [README](https://github.com/fivetran/dbt_reddit_ads_source/tree/main?tab=readme-ov-file#passing-through-additional-metrics).

## Under the hood
- Coalesces each pre-existing metrics (ie `clicks`, `impressions`, and `spend`) with `0` to avoid the complications of `null` in downstream aggregations.
- Adds the respective seed data for the new models in addition to updating relevant documentation.
- Adds documentation explaining potential discrepancies across reporting grains.

## Contributors
- [Seer Interactive](https://www.seerinteractive.com/?utm_campaign=Fivetran%20%7C%20Models&utm_source=Fivetran&utm_medium=Fivetran%20Documentation)

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
