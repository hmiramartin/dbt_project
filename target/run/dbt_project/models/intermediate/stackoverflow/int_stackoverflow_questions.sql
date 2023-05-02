

  create or replace table `dazzling-tiger-361615`.`project`.`int_stackoverflow_questions`
  
  cluster by uni_pk
  OPTIONS()
  as (
    

with stackoverflow_questions as (

    select * from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_questions`
    

),

gsheet_tags as (

    select
        organization,
        tags
    from
        `dazzling-tiger-361615`.`project`.`stg_gsheet_sql`, unnest (split(tags, ', ')) as tags
        where tags is not null
),

questions_tags as (

    select
        _pk,
        tags
    from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_questions`, unnest(tags) as tags

),

matched_tags as (

    select distinct
        questions_tags._pk as questions_pk,
        gsheet_tags.organization as organisation
    from gsheet_tags
    inner join questions_tags
        on gsheet_tags.tags = questions_tags.tags
),

columns as (

    select
        to_hex(md5(cast(coalesce(cast(matched_tags.organisation as STRING), '') || '-' || coalesce(cast(matched_tags.questions_pk as STRING), '') as STRING))) as uni_pk,
        matched_tags.questions_pk as questions_pk,
        matched_tags.organisation as organisation,
        stackoverflow_questions.title,
        stackoverflow_questions.body,
        stackoverflow_questions.accepted_answer_id,
        stackoverflow_questions.answer_count,
        stackoverflow_questions.comment_count,
        stackoverflow_questions.community_owned_date_datetime_utc,
        stackoverflow_questions.creation_date_datetime_utc,
        stackoverflow_questions.favorite_count,
        stackoverflow_questions.last_activity_date_datetime_utc,
        stackoverflow_questions.last_edit_date_datetime_utc,
        stackoverflow_questions.last_editor_display_name,
        stackoverflow_questions.last_editor_user_id,
        stackoverflow_questions.owner_display_name,
        stackoverflow_questions.owner_user_id,
        stackoverflow_questions.parent_id,
        stackoverflow_questions.post_type_id,
        stackoverflow_questions.score,
        stackoverflow_questions.tags,
        stackoverflow_questions.view_count
    from stackoverflow_questions
    inner join matched_tags
        on matched_tags.questions_pk = stackoverflow_questions._pk

)

select * from columns
  );
  