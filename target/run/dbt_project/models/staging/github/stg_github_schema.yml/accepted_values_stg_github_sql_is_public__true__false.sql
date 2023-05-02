select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        is_public as value_field,
        count(*) as n_records

    from `dazzling-tiger-361615`.`project`.`stg_github_sql`
    group by is_public

)

select *
from all_values
where value_field not in (
    'True','False'
)



      
    ) dbt_internal_test