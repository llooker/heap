- view: funnel_explorer

# Or, you could make this view a derived table, like this:
  derived_table:
    sql: |
      SELECT all_events.session_id || '-' || all_events.user_id as session_unique_id
        , MIN(
            CASE WHEN
              {% condition event1 %} all_events.event_name {% endcondition %} 
              THEN all_events.time
              ELSE NULL END
            ) as event1_time
        , MIN(
            CASE WHEN
              {% condition event2 %} all_events.event_name {% endcondition %} 
              THEN all_events.time
              ELSE NULL END
            ) as event2_time
        , MIN(
            CASE WHEN
              {% condition event3 %} all_events.event_name {% endcondition %} 
              THEN all_events.time
              ELSE NULL END
            ) as event3_time
      FROM main_production.all_events as all_events
      WHERE {% condition event_time %} all_events.time {% endcondition %} 
      GROUP BY 1

  fields:
    - filter: event1
      suggest_explore: all_events
      suggest_dimension: all_events.event_name
      
    - filter: event2
      suggest_explore: all_events
      suggest_dimension: all_events.event_name

    - filter: event3
      suggest_explore: all_events
      suggest_dimension: all_events.event_name
    
    - filter: event_time
      type: datetime
    
    - dimension: session_unique_id
      type: string
      primary_key: TRUE
      sql: ${TABLE}.session_unique_id

    - dimension: event1
      type: time
      timeframes: [time]
      sql: ${TABLE}.event1_time

    - dimension: event2
      type: time
      timeframes: [time]
      sql: ${TABLE}.event2_time

    - dimension: event3
      type: time
      timeframes: [time]
      sql: ${TABLE}.event3_time
    
    - dimension: event1_before_event2
      type: yesno
      sql: ${event1_time} < ${event2_time}

    - dimension: event2_before_event3
      type: yesno
      sql: ${event2_time} < ${event3_time}

    - measure: count_sessions
      type: count_distinct
      sql: ${session_unique_id}

    - measure: count_sessions_event1
      type: count_distinct
      sql: ${session_unique_id}
      filters: 
        event1_time: NOT NULL
    
    - measure: count_sessions_event12
      type: count_distinct
      sql: ${session_unique_id}
      filters: 
        event1_time: NOT NULL
        event2_time: NOT NULL
        event1_before_event2: TRUE

    - measure: count_sessions_event123  
      type: count_distinct
      sql: ${session_unique_id}
      filters: 
        event1_time: NOT NULL
        event2_time: NOT NULL
        event3_time: NOT NULL
        event1_before_event2: TRUE
        event2_before_event3: TRUE
