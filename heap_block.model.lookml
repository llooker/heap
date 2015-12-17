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
      type: left_outer 
      sql_on: ${all_events.session_unique_id} = ${sessions.session_unique_id}
      relationship: many_to_one
    
    - join: session_facts
      view_label: "Sessions"
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
    
    - join: user_facts
      view_label: "Users"
      type: left_outer
      sql_on: ${sessions.user_id} = ${user_facts.user_id}
      relationship: many_to_one
    
    - join: session_facts
      view_label: "Sessions"
      type: left_outer
      sql_on: ${sessions.session_unique_id} = ${session_facts.session_unique_id}
      relationship: one_to_one

- explore: funnel_explorer
  joins: 
    - join: sessions
      type: left_outer
      sql_on: ${funnel_explorer.session_unique_id} = ${sessions.session_unique_id}
      relationship: one_to_one
      
    - join: session_facts
      view_label: "Sessions"
      type: left_outer
      sql_on: ${sessions.session_unique_id} = ${session_facts.session_unique_id}
      relationship: one_to_one 

