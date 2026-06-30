{% macro clean_id(column_name) %}
    NULLIF(TRIM(REPLACE({{ column_name }}, '"', '')), '')
{% endmacro %}