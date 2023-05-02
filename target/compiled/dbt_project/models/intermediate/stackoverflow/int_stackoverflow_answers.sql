

with stackoverflow_answers as (

    select * from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_answers`
    

),

columns as (

    select
        to_hex(md5(cast(coalesce(cast(answers._pk as STRING), '') || '-' || coalesce(cast(questions.organisation as STRING), '') as STRING))) as uni_pk,
        questions.questions_pk,
        questions.organisation,
        questions.tags,
        answers._pk as answer_pk,
        answers.comment_count,
        answers.community_owned_date_datetime_utc,
        answers.creation_date_datetime_utc,
        answers.favorite_count,
        answers.last_activity_date_datetime_utc,
        answers.last_edit_date_datetime_utc,
        answers.last_editor_display_name,
        answers.last_editor_user_id,
        answers.owner_display_name,
        answers.owner_user_id,
        answers.parent_id,
        answers.score,
        answers.view_count

    from stackoverflow_answers as answers
    inner join
        `dazzling-tiger-361615`.`project`.`int_stackoverflow_questions` as questions on
            questions.questions_pk = answers.parent_id

)


select * from columns