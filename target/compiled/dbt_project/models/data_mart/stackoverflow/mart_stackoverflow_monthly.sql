

with monthly as (
    select
        a.uni_pk,
        timestamp_trunc(a.creation_date_datetime_utc, month) as first_day_of_period,
        extract(month from a.creation_date_datetime_utc) as month,
        extract(quarter from a.creation_date_datetime_utc) as quarter,
        '2022' as year,
        a.organisation as organization_name,
        count(a.uni_pk) as post_count,
            sum(answer_count) as answer_count,
            (sum(answer_count) / count(a.uni_pk)) as avg_answer_count,
            sum(comment_count) as comment_count,
            (sum(comment_count) / count(a.uni_pk)) as avg_comment_count,
            sum(favorite_count) as favorite_count,
            (sum(favorite_count) / count(a.uni_pk)) as avg_favorite_count,
            sum(view_count) as view_count,
            (sum(view_count) / count(a.uni_pk)) as avg_view_count,
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

    FROM `dazzling-tiger-361615`.`project`.`int_stackoverflow_questions` a
    inner join `dazzling-tiger-361615`.`project`.`int_gsheet_snapshot` b
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

    from monthly

)

select * from columns