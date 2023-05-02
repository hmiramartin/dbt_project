with source as (

    select * from {{ source('raw_airbyte', 'gsheet_data') }}

),

columns as (
    select
        organization,
        repository_account,
        repository_name,
        l1_type,
        l2_type,
        l3_type,
        tags,
        (case open_source_available when 'Yes' then True else False end) as is_open_source_available

    from source


)

select * from columns