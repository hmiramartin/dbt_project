
    
    

with child as (
    select parent_id as from_field
    from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_answers`
    where parent_id is not null
),

parent as (
    select _pk as to_field
    from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_questions`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


