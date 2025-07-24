{% macro convert_microcurrency(value) %}
    {{ return(adapter.dispatch('convert_microcurrency', 'reddit_ads_source') (value)) }}
{% endmacro %}

{% macro default__convert_microcurrency(value) %}
    coalesce(cast({{ value }} as {{ dbt.type_numeric() }}) / 10000000, 0)
{% endmacro %}
