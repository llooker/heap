view: event_flow {
  derived_table: {
    sql_trigger_value: select count(*) from ${event_facts.SQL_TABLE_NAME} ;;
    sortkeys: ["sequence_number_for_event_flow"]
    distribution: "unique_event_id"
    sql: select      a.unique_event_id
            , a.event_id
            , a.session_id
            , a.sequence_number_for_event_flow
            , a.event_name
            , a.user_id
            , b.event_name as event_2
            , c.event_name as event_3
            , d.event_name as event_4
            , e.event_name as event_5

from ${event_facts.SQL_TABLE_NAME} a
left join ${event_facts.SQL_TABLE_NAME} b
on a.sequence_number_for_event_flow + 1 = b.sequence_number_for_event_flow
and a.user_id = b.user_id
and a.session_id = b.session_id
left join ${event_facts.SQL_TABLE_NAME} c
on a.sequence_number_for_event_flow + 2 = c.sequence_number_for_event_flow
and a.user_id = c.user_id
and a.session_id = c.session_id
left join ${event_facts.SQL_TABLE_NAME} d
on a.sequence_number_for_event_flow + 3 = d.sequence_number_for_event_flow
and a.user_id = d.user_id
and a.session_id = d.session_id
left join ${event_facts.SQL_TABLE_NAME} e
on a.sequence_number_for_event_flow + 4 = e.sequence_number_for_event_flow
and a.user_id = e.user_id
and a.session_id = e.session_id
 ;;
  }

  dimension: unique_event_id {
    primary_key: yes
    sql: ${TABLE}.unique_event_id ;;
    hidden: yes
  }

  dimension: session_id {
    hidden: yes
    sql: ${TABLE}.session_id ;;
  }

  dimension: sequence_number_for_event_flow {
    type: number
    hidden: yes
    sql: ${TABLE}.sequence_number_for_event_flow ;;
  }

  dimension: event_name {
    hidden: yes
    sql: ${TABLE}.event_name ;;
  }

  dimension: user_id {
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: event_2 {
    label: "2nd Event"
    sql: ${TABLE}.event_2 ;;
  }

  measure: event_2_drop_off {
    label: "2nd Event Remaining Count"
    type: count

    filters: {
      field: event_2
      value: "-NULL"
    }
  }

  dimension: event_3 {
    label: "3rd Event"
    sql: ${TABLE}.event_3 ;;
  }

  measure: event_3_drop_off {
    label: "3rd Event Remaining Count"
    type: count

    filters: {
      field: event_3
      value: "-NULL"
    }
  }

  dimension: event_4 {
    label: "4th Event"
    sql: ${TABLE}.event_4 ;;
  }

  measure: event_4_drop_off {
    label: "4th Event Remaining Count"
    type: count

    filters: {
      field: event_4
      value: "-NULL"
    }
  }

  dimension: event_5 {
    label: "5th Event"
    sql: ${TABLE}.event_5 ;;
  }

  measure: event_5_drop_off {
    label: "5th Event Remaining Count"
    type: count

    filters: {
      field: event_5
      value: "-NULL"
    }
  }

  set: detail {
    fields: [unique_event_id, session_id, sequence_number_for_event_flow, event_name, user_id, event_2, event_3, event_4, event_5]
  }
}
