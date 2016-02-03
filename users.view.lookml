- view: users
  sql_table_name: main_production.users
  fields:

  - dimension: user_id
    primary_key: true
    type: number
    sql: ${TABLE}.user_id

  - dimension: email
    sql: ${TABLE}.email

  - dimension: handle
    sql: ${TABLE}.handle

  - dimension_group: joindate
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.joindate

  - measure: count
    hidden: true
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - user_id
    - email
    - sessions.count
    - joindate_date