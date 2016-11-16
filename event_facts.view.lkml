view: event_facts {
  derived_table: {
    # update trigger value to desired frequency and timezone
    sql_trigger_value: select date(convert_timezone('pst', getdate() - interval '3 hours')) ;;
    sortkeys: ["event_sequence_number"]
    distribution: "unique_event_id"
    sql: WITH
        event_count AS (
            SELECT
              event_table_name
              , COUNT(*) AS cardinality
            FROM main_production.all_events
            WHERE TIME > DATEADD('day', - 30, GETDATE())
            GROUP BY 1
        )
        , all_events AS (
            SELECT
              DISTINCT all_events.event_id
              , all_events.user_id AS user_id
              , all_events.session_id
              , all_events.event_table_name AS event_name
              , all_events.TIME AS occurred_at
              , event_count.cardinality
            FROM main_production.all_events AS all_events
            LEFT JOIN event_count
              ON all_events.event_table_name = event_count.event_table_name
        )
        , events AS (
            SELECT
               all_events.event_id
              , all_events.event_name
              , ROW_NUMBER() OVER(PARTITION BY all_events.session_id, all_events.user_id ORDER BY all_events.occurred_at) AS sequence_number_for_event_flow
            FROM all_events
            INNER JOIN (
                  SELECT
                    event_id
                    , user_id
                    , MIN(cardinality) AS cardinality
                  FROM all_events
                  GROUP BY 1,2
            ) AS event
                ON all_events.cardinality = event.cardinality
                AND all_events.event_id = event.event_id
                AND all_events.user_id = event.user_id
        )
      SELECT a.event_id
            , a.event_table_name AS event_name
            , a.event_id || '-' || a.event_table_name AS unique_event_id
            , a.user_id
            , a.session_id
            , events.sequence_number_for_event_flow AS sequence_number_for_event_flow
            , ROW_NUMBER() OVER(PARTITION BY a.session_id, a.user_id ORDER BY a."time") AS event_sequence_number
      FROM main_production.all_events AS a
      LEFT JOIN events
        ON events.event_id = a.event_id
        AND events.event_name = a.event_table_name
       ;;
  }

  measure: count {
    type: count
    drill_fields: [event_name, count]
  }

  dimension: unique_event_id {
    primary_key: yes
    sql: ${TABLE}.unique_event_id ;;
  }

  dimension: event_id {
    type: number
    sql: ${TABLE}.event_id ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: session_id {
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension: event_sequence_number {
    type: number
    sql: ${TABLE}.event_sequence_number ;;
  }

  dimension: sequence_number_for_event_flow {
    type: number
    hidden: yes
    sql: ${TABLE}.sequence_number_for_event_flow ;;
  }
}
