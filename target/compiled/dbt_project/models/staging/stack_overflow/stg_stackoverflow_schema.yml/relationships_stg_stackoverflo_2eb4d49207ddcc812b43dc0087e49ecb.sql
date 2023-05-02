
    
    

with child as (
    select _pk as from_field
    from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_questions`
    where _pk is not null
),

parent as (
    select parent_id as to_field
    from `dazzling-tiger-361615`.`project`.`stg_stackoverflow_answers`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


