- connection: heap_redshift

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: all_events
  joins:
    - join: users
      type: left_outer 
      sql_on: ${all_events.user_id} = ${users.user_id}
      relationship: many_to_one

    - join: sessions
      view_label: "Sessions"
      type: left_outer 
      sql_on: ${all_events.session_unique_id} = ${sessions.session_unique_id}
      relationship: many_to_one
    
    - join: session_facts
      type: left_outer
      sql_on: ${sessions.session_unique_id} = ${session_facts.session_unique_id}
      relationship: one_to_one

- explore: users

- explore: sessions
  joins:
    - join: users
      type: left_outer 
      sql_on: ${sessions.user_id} = ${users.user_id}
      relationship: many_to_one
    
    - join: session_facts
      view_label: "Sessions"
      type: left_outer
      sql_on: ${sessions.session_unique_id} = ${session_facts.session_unique_id}
      relationship: one_to_one

- explore: funnel_explorer