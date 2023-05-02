with gsheet as(

 select
        organization as organisation,
        repository_account,
        repository_name,
        l1_type,
        l2_type,
        l3_type,
        tags,
        is_open_source_available

    from `dazzling-tiger-361615`.`gsheet_snapshot`.`snapshot_gsheet`
    where dbt_valid_to is null

)

select * from gsheet