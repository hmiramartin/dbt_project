
    
    

with dbt_test__target as (

  select _pk as unique_field
  from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_answers`
  where _pk is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


