{% macro brl_to_eur(amount_brl, eur_brl_rate) %}
    ({{ amount_brl }}) / NULLIF({{ eur_brl_rate }}, 0)
{% endmacro %}