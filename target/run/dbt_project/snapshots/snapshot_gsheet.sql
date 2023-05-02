
      

  create or replace table `dazzling-tiger-361615`.`gsheet_snapshot`.`snapshot_gsheet`
  
  
  OPTIONS()
  as (
    

    select *,
        to_hex(md5(concat(coalesce(cast(organization as string), ''), '|',coalesce(cast(CURRENT_TIMESTAMP() as string), '')))) as dbt_scd_id,
        CURRENT_TIMESTAMP() as dbt_updated_at,
        CURRENT_TIMESTAMP() as dbt_valid_from,
        nullif(CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()) as dbt_valid_to
    from (
        



    select * from `dazzling-tiger-361615`.`project`.`stg_gsheet_sql`
    ) sbq



  );
  