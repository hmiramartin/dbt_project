{{
  config(
    materialized = 'incremental',
    cluster_by = 'uni_pk'
  )
}}

with stackoverflow_answers as (

    select * from {{ ref('stg_stackoverflow_answers') }}
    {% if is_incremental() %}
        where
            timestamp(creation_date_datetime_utc) >= (select max(creation_date_datetime_utc) from {{ this }})
    {% endif %}

),

columns as (

    select
        {{ dbt_utils.surrogate_key(['answers._pk','questions.organisation']) }} as uni_pk,
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
        {{ ref('int_stackoverflow_questions') }} as questions on
            questions.questions_pk = answers.parent_id

)


select * from columns