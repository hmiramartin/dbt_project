

  create or replace view `dazzling-tiger-361615`.`project`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `dazzling-tiger-361615`.`project`.`my_first_dbt_model`
where id = 1;

