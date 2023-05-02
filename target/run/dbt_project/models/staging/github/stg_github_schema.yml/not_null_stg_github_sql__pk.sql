select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select _pk
from `dazzling-tiger-361615`.`project`.`stg_github_sql`
where _pk is null



      
    ) dbt_internal_test