with source as (

    select * from `bigquery-public-data`.`stackoverflow`.`posts_questions`
),

columns as (

    select
        id as _pk,
        title,
        body,
        accepted_answer_id,
        answer_count,
        comment_count,
        community_owned_date as community_owned_date_datetime_utc,
        creation_date as creation_date_datetime_utc,
        favorite_count,
        last_activity_date as last_activity_date_datetime_utc,
        last_edit_date as last_edit_date_datetime_utc,
        last_editor_display_name,
        last_editor_user_id,
        owner_display_name,
        owner_user_id,
        parent_id,
        post_type_id,
        score,
        split(tags, '|') as tags,
        view_count

    from source

)

select * from columns as questions
    where exists(select answers.parent_id from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_answers` as answers
    where questions._pk = answers.parent_id)
    AND creation_date_datetime_utc BETWEEN "2022-01-01 00:00:00" AND "2022-12-31 23:59:59"