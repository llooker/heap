view: user_facts {
  derived_table: {
    sortkeys: ["first_session"]
    distribution: "user_id"
    # update trigger value to desired frequency and timezone
    sql_trigger_value: select date(convert_timezone('pst', getdate() - interval '3 hours')) ;;
    sql: SELECT
        sessions.user_id AS user_id,
        min(sessions.time) AS first_session,
        max(sessions.time) as latest_session,
        COUNT(*) AS session_count
      FROM main_production.sessions AS sessions
      GROUP BY 1
       ;;
  }

  dimension: user_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: first_session {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_session ;;
  }

  dimension_group: latest_session {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.latest_session ;;
  }

  dimension: days_between_first_and_latest_session {
    type: number
    sql: ${latest_session_date} - ${first_session_date} ;;
  }

  dimension: days_between_first_and_latest_session_tier {
    type: tier
    style: integer
    sql: ${days_between_first_and_latest_session} ;;
    tiers: [1, 8, 15, 22, 31, 46, 91]
  }

  dimension: months_between_first_and_latest_session_tier {
    type: tier
    style: integer
    sql: ${days_between_first_and_latest_session}/30 ;;
    tiers: [0, 1, 11]
  }

  dimension: session_count {
    type: number
    sql: ${TABLE}.session_count ;;
  }

  dimension: session_count_tier {
    type: tier
    sql: ${session_count} ;;
    tiers: [2, 5, 10, 20]
    style: integer
  }
}
