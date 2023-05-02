{% set events = {
    "follow": "FollowEvent",
    "issues": "IssuesEvent",
    "watch": "WatchEvent",
    "fork": "ForkEvent",
    "push": "PushEvent",
    "pr": "PullRequestEvent",
    "delete": "DeleteEvent",
    "public": "PublicEvent",
    "create": "CreateEvent",
    "forkapply": "ForkApplyEvent",
    "gollum": "GollumEvent",
    "member": "MemberEvent",
    "gist": "GistEvent",
    "commit_comment": "CommitCommentEvent",
    "download": "DownloadEvent"
} %}
with daily as (
    select
        github_pk,
        timestamp_trunc(created_at_datetime_utc, day) as first_day_of_period,
        extract(month from created_at_datetime_utc) as month,
        extract(quarter from created_at_datetime_utc) as quarter,
        '2022' as year,
        organisation as organization_name,
        repository_account,
        coalesce(repository_name, repository_account) as repository_name,
        count(github_pk) as event_count,
        count(actor_id) as user_count,
        {% for key, value in events.items()  %}

            sum(case when type = '{{value}}' then 1 else 0 end) as {{key}}_count

        {% if not loop.last %} , {% endif %}

        {% endfor %}

    FROM {{ ref('int_github_sql') }}
    group by
        github_pk,
        first_day_of_period,
        month,
        quarter,
        organization_name,
        repository_account,
        repository_name
),

columns as (

    select *,{{ events|length }} as total_event_count

    from daily

)

select * from columns