- view: all_events
  sql_table_name: main_production.all_events
  fields:

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

  - dimension: destination_url
    sql: ${TABLE}.destination_url

  - dimension: device_type
    sql: ${TABLE}.device_type

  - dimension: domain
    sql: ${TABLE}.domain

  - dimension: environment_id
    sql: ${TABLE}.environment_id

  - dimension: event_id
    type: int
    sql: ${TABLE}.event_id

  - dimension: event_name
    sql: ${TABLE}.event_name

  - dimension: hash
    sql: ${TABLE}.hash

  - dimension: href
    sql: ${TABLE}.href

  - dimension: landing_page
    sql: ${TABLE}.landing_page

  - dimension: library
    sql: ${TABLE}.library

  - dimension: pageview_id
    type: int
    sql: ${TABLE}.pageview_id

  - dimension: pageview_properties
    sql: ${TABLE}.pageview_properties

  - dimension: pageview_time
    sql: ${TABLE}.pageview_time

  - dimension: path
    sql: ${TABLE}.path

  - dimension: phone_model
    sql: ${TABLE}.phone_model

  - dimension: platform
    sql: ${TABLE}.platform

  - dimension: query
    sql: ${TABLE}.query

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: region
    sql: ${TABLE}.region

  - dimension: screen_a11y_id
    sql: ${TABLE}.screen_a11y_id

  - dimension: screen_a11y_label
    sql: ${TABLE}.screen_a11y_label

  - dimension: screen_dimensions
    sql: ${TABLE}.screen_dimensions

  - dimension: search_keyword
    sql: ${TABLE}.search_keyword

  - dimension: selector
    sql: ${TABLE}.selector

  - dimension: session_id
    type: int
    # hidden: true
    sql: ${TABLE}.session_id
  
  - dimension: session_unique_id
#     hidden: true
    type: string
    sql: ${session_id} || '-' || ${user_id}

  - dimension_group: session
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_time

  - dimension: target_a11y_id
    sql: ${TABLE}.target_a11y_id

  - dimension: target_a11y_label
    sql: ${TABLE}.target_a11y_label

  - dimension: target_class
    sql: ${TABLE}.target_class

  - dimension: target_id
    sql: ${TABLE}.target_id

  - dimension: target_ivar
    sql: ${TABLE}.target_ivar

  - dimension: target_selector
    sql: ${TABLE}.target_selector

  - dimension: target_tag
    sql: ${TABLE}.target_tag

  - dimension: target_text
    sql: ${TABLE}.target_text

  - dimension: target_view
    sql: ${TABLE}.target_view

  - dimension_group: time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time

  - dimension: timestamp
    sql: ${TABLE}.timestamp

  - dimension: title
    sql: ${TABLE}.title

  - dimension: type
    sql: ${TABLE}.type

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

  - dimension: view_controller
    sql: ${TABLE}.view_controller

  - measure: count
    type: count
    drill_fields: [app_name, event_name, users.user_id, sessions.session_id, sessions.app_name]

