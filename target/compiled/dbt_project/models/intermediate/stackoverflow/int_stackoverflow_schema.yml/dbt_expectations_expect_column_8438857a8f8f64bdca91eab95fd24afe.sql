with relation_columns as (

        
        select
            cast('_PK' as STRING) as relation_column,
            cast('INT64' as STRING) as relation_column_type
        union all
        
        select
            cast('GSHEET_ID' as STRING) as relation_column,
            cast('STRING' as STRING) as relation_column_type
        union all
        
        select
            cast('TAGS' as STRING) as relation_column,
            cast('STRING' as STRING) as relation_column_type
        union all
        
        select
            cast('CREATION_DATE_DATETIME_UTC' as STRING) as relation_column,
            cast('TIMESTAMP' as STRING) as relation_column_type
        
        
    ),
    test_data as (

        select
            *
        from
            relation_columns
        where
            relation_column = 'CREATION_DATE_DATETIME_UTC'
            and
            relation_column_type not in ('TIMESTAMP')

    )
    select *
    from test_data