
    
    

with all_values as (

    select
        public as value_field,
        count(*) as n_records

    from `githubarchive`.`day`.`2022*`
    group by public

)

select *
from all_values
where value_field not in (
    'true'
)


