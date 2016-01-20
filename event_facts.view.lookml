- explore: event_facts
- view: event_facts
  derived_table:
    sql_trigger_value: select date(convert_timezone('pst', getdate() - interval '3 hours'))
    sortkeys: [event_sequence_number]
    distkey: unique_event_id
    sql: |
      select event_id
            , event_name
            , event_id || '-' || event_name as unique_event_id
            , user_id
            , session_id
            , row_number() over(partition by session_id, user_id order by a."time") as event_sequence_number
      from main_production.all_events as a 

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: event_id
    type: int
    sql: ${TABLE}.event_id

  - dimension: event_name
    type: string
    sql: ${TABLE}.event_name

  - dimension: user_id
    type: int
    sql: ${TABLE}.user_id

  - dimension: session_id
    type: int
    sql: ${TABLE}.session_id

  - dimension: event_sequence_number
    type: int
    sql: ${TABLE}.event_sequence_number