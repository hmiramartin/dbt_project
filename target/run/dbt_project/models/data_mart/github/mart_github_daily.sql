

  create or replace view `dazzling-tiger-361615`.`project`.`mart_github_daily`
  OPTIONS()
  as 
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
        

            sum(case when type = 'FollowEvent' then 1 else 0 end) as follow_count

         , 

        

            sum(case when type = 'IssuesEvent' then 1 else 0 end) as issues_count

         , 

        

            sum(case when type = 'WatchEvent' then 1 else 0 end) as watch_count

         , 

        

            sum(case when type = 'ForkEvent' then 1 else 0 end) as fork_count

         , 

        

            sum(case when type = 'PushEvent' then 1 else 0 end) as push_count

         , 

        

            sum(case when type = 'PullRequestEvent' then 1 else 0 end) as pr_count

         , 

        

            sum(case when type = 'DeleteEvent' then 1 else 0 end) as delete_count

         , 

        

            sum(case when type = 'PublicEvent' then 1 else 0 end) as public_count

         , 

        

            sum(case when type = 'CreateEvent' then 1 else 0 end) as create_count

         , 

        

            sum(case when type = 'ForkApplyEvent' then 1 else 0 end) as forkapply_count

         , 

        

            sum(case when type = 'GollumEvent' then 1 else 0 end) as gollum_count

         , 

        

            sum(case when type = 'MemberEvent' then 1 else 0 end) as member_count

         , 

        

            sum(case when type = 'GistEvent' then 1 else 0 end) as gist_count

         , 

        

            sum(case when type = 'CommitCommentEvent' then 1 else 0 end) as commit_comment_count

         , 

        

            sum(case when type = 'DownloadEvent' then 1 else 0 end) as download_count

        

        

    FROM `dazzling-tiger-361615`.`project`.`int_github_sql`
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

    select *,15 as total_event_count

    from daily

)

select * from columns;

