select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select parent_id
from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_answers`
where parent_id is null



      
    ) dbt_internal_test