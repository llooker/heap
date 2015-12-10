- view: session_facts
  derived_table:
    sortkeys: [session_start_time]
    distkey: session_unique_id
    sql_trigger_value: select date(convert_timezone('pst', getdate() - interval '3 hours'))
    sql: |
      SELECT 
        all_events.session_id || '-' || all_events.user_id AS session_unique_id,
        user_id,
        row_number() over( partition by user_id order by min(all_events.time)) as session_sequence_number,
        min(all_events.time) AS session_start_time,
        max(all_events.time) AS session_end_time,
        COUNT(*) AS "all_events.count"
      FROM main_production.all_events AS all_events
      
      GROUP BY 1,2

  fields:

  - dimension: session_unique_id
    type: string
    primary_key: true
    hidden: true
    sql: ${TABLE}.session_unique_id

  - dimension: user_id
    type: int
    hidden: true
    sql: ${TABLE}.user_id

  - dimension: session_sequence_number
    type: int
    sql: ${TABLE}.session_sequence_number
  
  - dimension: is_first_session
    type: yesno
    sql: ${session_sequence_number} = 1

  - dimension_group: session_start_time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_start_time

  - dimension_group: session_end_time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_end_time

  - dimension: all_events_count
    type: int
    sql: ${TABLE}."all_events.count"
  
  - dimension: is_bounced
    type: yesno
    sql: ${all_events_count} = 1

  sets:
    detail:
      - session_unique_id
      - user_id
      - session_sequence_number
      - session_start_time_time
      - session_end_time_time
      - all_events_count

