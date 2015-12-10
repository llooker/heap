- view: sessions
  sql_table_name: main_production.sessions
  fields:

  - dimension: session_id
    type: int
    sql: ${TABLE}.session_id
  
  - dimension: session_unique_id
    hidden: true
    type: string
    primary_key: true
    sql: ${session_id} || '-' || ${user_id}

  - dimension: app_name
    sql: ${TABLE}.app_name

  - dimension: app_version
    sql: ${TABLE}.app_version

  - dimension: browser
    sql: ${TABLE}.browser

  - dimension: carrier
    sql: ${TABLE}.carrier

  - dimension: city
    sql: ${TABLE}.city

  - dimension: country
    sql: ${TABLE}.country

  - dimension: device_type
    sql: ${TABLE}.device_type

  - dimension: event_id
    type: int
    sql: ${TABLE}.event_id

  - dimension: landing_page
    sql: ${TABLE}.landing_page

  - dimension: library
    sql: ${TABLE}.library

  - dimension: phone_model
    sql: ${TABLE}.phone_model

  - dimension: platform
    sql: ${TABLE}.platform

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: region
    sql: ${TABLE}.region

  - dimension: search_keyword
    sql: ${TABLE}.search_keyword

  - dimension_group: session
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_time

  - dimension_group: time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time

  - dimension: user_id
    type: int
    # hidden: true
    sql: ${TABLE}.user_id

  - dimension: utm_campaign
    sql: ${TABLE}.utm_campaign

  - dimension: utm_content
    sql: ${TABLE}.utm_content

  - dimension: utm_medium
    sql: ${TABLE}.utm_medium

  - dimension: utm_source
    sql: ${TABLE}.utm_source

  - dimension: utm_term
    sql: ${TABLE}.utm_term

  - measure: count
    type: count
    drill_fields: detail*
  
  - measure: count_users
    type: count_distinct
    sql: ${user_id}

  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - session_id
    - app_name

