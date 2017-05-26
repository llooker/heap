view: funnel_explorer {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT all_events.session_id || '-' || all_events.user_id as session_unique_id
        , MIN(all_events.time) as session_time
        , MIN(
            CASE WHEN
              {% condition event1 %} all_events.event_table_name {% endcondition %}
              THEN all_events.time
              ELSE NULL END
            ) as event1_time
        , MIN(
            CASE WHEN
              {% condition event2 %} all_events.event_table_name {% endcondition %}
              THEN all_events.time
              ELSE NULL END
            ) as event2_time
        , MIN(
            CASE WHEN
              {% condition event3 %} all_events.event_table_name {% endcondition %}
              THEN all_events.time
              ELSE NULL END
            ) as event3_time
      FROM main_production.all_events as all_events
      WHERE {% condition session_date %} all_events.time {% endcondition %}
      GROUP BY 1
       ;;
  }

  filter: event1 {
    suggest_explore: all_events
    suggest_dimension: all_events.event_name
  }

  filter: event2 {
    suggest_explore: all_events
    suggest_dimension: all_events.event_name
  }

  filter: event3 {
    suggest_explore: all_events
    suggest_dimension: all_events.event_name
  }

  filter: event_time {
    type: date_time
  }

  dimension_group: session {
    type: time
    sql: ${TABLE}.session_time ;;
    timeframes: [date, month, week, year]
  }

  dimension: session_unique_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.session_unique_id ;;
  }

  dimension_group: event1 {
    type: time
    timeframes: [time]
    sql: ${TABLE}.event1_time ;;
  }

  dimension_group: event2 {
    type: time
    timeframes: [time]
    sql: ${TABLE}.event2_time ;;
  }

  dimension_group: event3 {
    type: time
    timeframes: [time]
    sql: ${TABLE}.event3_time ;;
  }

  dimension: event1_before_event2 {
    type: yesno
    sql: ${event1_time} < ${event2_time} ;;
    hidden: yes
  }

  dimension: event2_before_event3 {
    type: yesno
    sql: ${event2_time} < ${event3_time} ;;
    hidden: yes
  }

  measure: count_sessions {
    type: count_distinct
    sql: ${session_unique_id} ;;
  }

  measure: count_sessions_event1 {
    type: count_distinct
    sql: ${session_unique_id} ;;
    drill_fields: [session_unique_id]
    filters: {
      field: event1_time
      value: "NOT NULL"
    }
  }

  measure: count_sessions_event12 {
    type: count_distinct
    sql: ${session_unique_id} ;;

    filters: {
      field: event1_time
      value: "NOT NULL"
    }

    filters: {
      field: event2_time
      value: "NOT NULL"
    }

    filters: {
      field: event1_before_event2
      value: "Yes"
    }
  }

  measure: count_sessions_event123 {
    type: count_distinct
    sql: ${session_unique_id} ;;

    filters: {
      field: event1_time
      value: "NOT NULL"
    }

    filters: {
      field: event2_time
      value: "NOT NULL"
    }

    filters: {
      field: event3_time
      value: "NOT NULL"
    }

    filters: {
      field: event1_before_event2
      value: "Yes"
    }

    filters: {
      field: event2_before_event3
      value: "Yes"
    }
  }

  measure: conversion_rate_event_1 {
    description: "Percent of Total Sessions that Convert to Event 1"
    type: number
    sql: 100*(${count_sessions_event1}::float/NULLIF(${count_sessions},0)) ;;
    value_format: "0.00\%"
  }

  measure: conversion_rate_event_2 {
    description: "Percent of Total Sessions that Convert to Event 1 and 2"
    type: number
    sql: 100*(${count_sessions_event12}::float/NULLIF(${count_sessions},0)) ;;
    value_format: "0.00\%"
  }

  measure: conversion_rate_event_1_to_2 {
    description: "Percent of Sessions with Event 1 that convert to Event 2"
    type: number
    sql: 100*(${count_sessions_event12}::float/NULLIF(${count_sessions_event1},0)) ;;
    value_format: "0.00\%"
  }

  measure: conversion_rate_event_3 {
    description: "Percent of Total Sessions that Convert to Event 1, 2, and 3"
    type: number
    sql: 100*(${count_sessions_event123}::float/NULLIF(${count_sessions},0)) ;;
    value_format: "0.00\%"
  }

  measure: conversion_rate_event_1_and_2_to_3 {
    description: "Percent of Sessions with Event 1 and 2 that convert to Event 3"
    type: number
    sql: 100*(${count_sessions_event12}::float/NULLIF(${count_sessions_event1},0)) ;;
    value_format: "0.00\%"
  }
}
