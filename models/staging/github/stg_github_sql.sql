with source as (

    select * from {{ source('day', 'grouped_year') }}

),

columns as (

    select distinct
        id as _pk,
        type,
        public as is_public,
        repo.id as repo_id,
        split(repo.name, '/')[SAFE_OFFSET(0)] as organisation,
        split(repo.name, '/')[SAFE_OFFSET(1)] as repository_name,
        repo.url as repo_url,
        actor.id as actor_id,
        actor.login as actor_login,
        actor.url as actor_url,
        org.id as org_id,
        org.login as org_login,
        org.url as org_url,
        created_at as created_at_datetime_utc,
        other

    from source

)

select * from columns