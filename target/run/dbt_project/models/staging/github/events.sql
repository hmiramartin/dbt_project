

  create or replace view `dazzling-tiger-361615`.`project`.`events`
  OPTIONS()
  as with source as (

   SELECT * FROM `githubarchive`.`day`.`2022*`

    ),
columns as (
SELECT  id as _pk,
        type,
        public as is_public,
        payload,
        repo,
        actor,
        org,
        created_at as created_at_datetime_utc,
        id,
        other
FROM source
    )

SELECT * FROM columns;

