{{
  config(
    materialized = 'incremental',
    cluster_by = 'github_pk'
  )
}}

with github_data as (

    select
        _pk as github_pk,
        type,
        organisation as repository_account,
        repository_name,
        actor_id,
        created_at_datetime_utc,

    from {{ ref('stg_github_sql') }}

    {% if is_incremental() %}

       where timestamp(created_at_datetime_utc) >= (select max(created_at_datetime_utc) from {{ this }})

    {% endif %}


),

gsheet_data as (

    select
        organization,
        repository_account,
        repository_name
    from {{ ref('stg_gsheet_sql') }}
    where repository_name is not null

),

gsheet_data_null as (

    select
        organization,
        repository_account,
        repository_name
    from {{ ref('stg_gsheet_sql') }}
    where repository_name is null

),

join_with_repo_name as (

    select
        github_data.github_pk as github_pk,
        github_data.type as type,
        github_data.actor_id as actor_id,
        github_data.created_at_datetime_utc as created_at_datetime_utc,
        gsheet_data.organization as organisation,
        gsheet_data.repository_account as repository_account,
        gsheet_data.repository_name as repository_name,
    from gsheet_data
    inner join github_data
        on gsheet_data.repository_account = github_data.repository_account
            and gsheet_data.repository_name = github_data.repository_name

),

join_without_repo_name as (

    select
        github_data.github_pk as github_pk,
        github_data.type as type,
        github_data.actor_id as actor_id,
        github_data.created_at_datetime_utc as created_at_datetime_utc,
        gsheet_data_null.organization as organisation,
        gsheet_data_null.repository_account as repository_account,
        gsheet_data_null.repository_name as repository_name,
    from gsheet_data_null
    inner join github_data
        on gsheet_data_null.repository_account = github_data.repository_account

),

union_all as (

    select
        github_pk,
        type,
        actor_id,
        organisation,
        repository_account,
        repository_name,
        created_at_datetime_utc,

    from join_with_repo_name
    union all
    select
        github_pk,
        type,
        actor_id,
        organisation,
        repository_account,
        repository_name,
        created_at_datetime_utc,

    from join_without_repo_name

),

int_github_table as (

    select distinct * from union_all
    order by created_at_datetime_utc

)

select *
from int_github_table