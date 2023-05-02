{% set posts = [ 'answer_count', 'comment_count', 'favorite_count', 'view_count' ] %}

with daily as (
    select
        a.uni_pk,
        timestamp_trunc(a.creation_date_datetime_utc, day) as first_day_of_period,
        extract(month from a.creation_date_datetime_utc) as month,
        extract(quarter from a.creation_date_datetime_utc) as quarter,
        '2022' as year,
        a.organisation as organization_name,
        count(a.uni_pk) as post_count,
        {%- for post in posts %}
            sum({{ post }}) as {{ post }},
            (sum({{ post }}) / count(a.uni_pk)) as avg_{{ post }}
        {%- if not loop.last -%}, {%- endif -%}
        {%- endfor %},
        sum(case when a.accepted_answer_id IS NOT NULL then 1
            else 0 end) / count(a.uni_pk) as accepted_answer_count,
        sum(case when a.accepted_answer_id = 0 then 1 end) as no_answer_count,
        sum(case when a.accepted_answer_id = 0 then 1 end) / count(a.uni_pk) as avg_no_answer_count,
        (sum(a.score)/count(a.uni_pk)) as avg_score,
        (SELECT COUNT(1) FROM (
            SELECT * FROM unnest(split(b.tags, ', ')) INTERSECT DISTINCT
            SELECT * FROM unnest(a.tags))) AS tags_count,
        max(a.last_activity_date_datetime_utc) as last_activity_datetime_utc,
        max(a.last_edit_date_datetime_utc) as last_edit_datetime_utc

    FROM {{ ref('int_stackoverflow_questions') }} a
    inner join {{ ref('int_gsheet_snapshot') }} b
        on a.organisation = b.organisation

    group by
        uni_pk,
        first_day_of_period,
        month,
        quarter,
        organization_name,
        score,
        tags_count

),

columns as (

    select *

    from daily

)

select * from columns