{% macro m_age_group(age_column) %}

case
    when {{ age_column }} between 1 and 9 then 'Childhood/Early Years'
    when {{ age_column }} between 10 and 12 then 'Early Teens/Pre-Teens'
    when {{ age_column }} between 13 and 19 then 'Teenage Years'
    when {{ age_column }} between 20 and 29 then 'Twenties'
    when {{ age_column }} between 30 and 39 then 'Thirties'
    when {{ age_column }} between 40 and 49 then 'Forties'
    when {{ age_column }} between 50 and 59 then 'Fifties'
    when {{ age_column }} between 60 and 69 then 'Sixties'
    when {{ age_column }} >= 70 then 'Seventy and beyond'
    else 'Unknown or less than 1'
end

{% endmacro %}