{%- macro which_table(table1, table2) -%}
{{ adapter.dispatch('which_table', 'reddit_ads_source')(table1, table2) }}
{%- endmacro %}

{%- macro default__which_table(table1, table2) -%}
    {%- if execute -%}
        {%- set source_relation = adapter.get_relation(
            database=var('reddit_ads_database', target.database),
            schema=var('reddit_ads_schema', 'reddit_ads'),
            identifier=var('reddit_ads_' ~ table1 ~ '_identifier', table1)
            ) -%}
        {{ return(table1 if source_relation is not none else table2) }}
    {%- endif -%}
{%- endmacro -%}