- view: user_facts
  derived_table:
    sortkeys: [first_session]
    distkey: user_id
    sql_trigger_value: select date(convert_timezone('pst', getdate() - interval '3 hours'))
    sql: |
      SELECT 
        sessions.user_id AS user_id,
        min(sessions.time) AS first_session,
        COUNT(*) AS session_count
      FROM main_production.sessions AS sessions
      GROUP BY 1

  fields:

  - dimension: user_id
    primary_key: true
    hidden: true
    type: int
    sql: ${TABLE}.user_id

  - dimension_group: first_session
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_session

  - dimension: session_count
    type: int
    sql: ${TABLE}.session_count
  
  - dimension: session_count_tier
    type: tier
    sql: ${session_count}
    tiers: [2,5,10,20]
    style: integer

  sets:
    detail:
      - user_id
      - first_session_time
      - session_count

