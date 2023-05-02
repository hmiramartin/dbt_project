{% snapshot snapshot_gsheet %}

{{
    config(
      target_database='dazzling-tiger-361615',
      target_schema='gsheet_snapshot',
      unique_key='organization',
      strategy='check',
      check_cols=['organization','repository_account', 'repository_name', 'l1_type', 'l2_type', 'l3_type', 'tags', 'is_open_source_available'],
      invalidate_hard_deletes=True
    )
}}

    select * from {{ ref('stg_gsheet_sql') }}
{% endsnapshot %}