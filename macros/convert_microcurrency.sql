{% macro convert_microcurrency(value) %}
    {{ return(adapter.dispatch('convert_microcurrency', 'reddit_ads_source') (value)) }}
{% endmacro %}

{% macro default__convert_microcurrency(value) %}

    /* This macro converts a microcurrency value (e.g., BIGINT like 1234567 = $1.234567) into a dollar-denominated NUMERIC.
    Why cast everything to {{ dbt.type_numeric() }}:
    - The `value` is often a BIGINT, so casting ensures precision-safe division.
    - `1000000` and '0' are INT literals, which some warehouses would promote the division to FLOAT if not cast — risking precision loss.*/

    coalesce(
        cast({{ value }} as {{ dbt.type_numeric() }}) / cast(1000000 as {{ dbt.type_numeric() }}),
        cast(0 as {{ dbt.type_numeric() }})
    )
{% endmacro %}
