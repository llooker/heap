- dashboard: sessions_overview
  title: Sessions Overview
  layout: grid
  rows:
    - elements: [total_sessions, distinct_users, avg_sessions_user]
      height: 220
    - elements: [new_sessions]
      height: 400
    - elements: [top_15_external_referers, sessions_by_device]
      height: 400
    - elements: [sessions_by_country, sessions_by_state]
      height: 400

  filters:
  
  - name: date
    title: "Date"
    type: date_filter
    default_value: 30 days

  elements:

  - name: total_sessions
    title: Total Sessions
    type: single_value
    model: heap_block
    explore: sessions
    measures: [sessions.count]
    listen:
      date: sessions.session_date
    sorts: [sessions.count desc]
    limit: 500
    font_size: medium
  
  - name: distinct_users
    title: Distinct Users
    type: single_value
    model: heap_block
    explore: sessions
    measures: [sessions.count_users]
    listen:
      date: sessions.session_date
    sorts: [sessions.count_users desc]
    limit: 500
    font_size: medium
  
  - name: avg_sessions_user
    title: Average Sessions per Distinct User
    type: single_value
    model: heap_block
    explore: sessions
    measures: [sessions.average_sessions_per_user]
    listen:
      date: sessions.session_date
    sorts: [sessions.average_sessions_per_user desc]
    limit: 500
    font_size: medium
  
  - name: new_sessions
    title: New vs Returning Sessions
    type: looker_area
    model: heap_block
    explore: sessions
    dimensions: [sessions.session_date, session_facts.is_first_session]
    pivots: [session_facts.is_first_session]
    measures: [sessions.count]
    listen:
      date: sessions.session_date
    sorts: [sessions.session_date, session_facts.is_first_session]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#5245ed', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: 25
    font_size: medium
    legend_position: center
    y_axis_gridlines: true
    show_view_names: true
    series_labels:
      'No': Returning Session
      'Yes': First Session
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    
  - name: top_15_external_referers
    title: Top 15 External Referrers
    type: looker_bar
    model: heap_block
    explore: sessions
    dimensions: [sessions.referrer_domain_mapped]
    measures: [sessions.count, sessions.count_users]
    filters:
      sessions.referrer: -NULL,-%heapanalytics%
    listen:
      date: sessions.session_date    
    sorts: [sessions.count desc]
    limit: 15
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: 25
    legend_position: center
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    x_axis_label: Referrer
    show_x_axis_ticks: true
    x_axis_scale: auto
  
  - name: sessions_by_device
    title: Session Count by Device Type
    type: looker_line
    model: heap_block
    explore: sessions
    dimensions: [sessions.device_type, sessions.session_date]
    pivots: [sessions.device_type]
    measures: [sessions.count]
    listen:
      date: sessions.session_date
    sorts: [sessions.session_date desc, sessions.device_type]
    limit: 500
    column_limit: 50
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: 25
    legend_position: center
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear

  - name: sessions_by_country
    title: Sessions By Country
    type: looker_geo_choropleth
    model: heap_block
    explore: sessions
    dimensions: [sessions.country]
    measures: [sessions.count]
    filters:
      sessions.country: -NULL
    listen:
      date: sessions.session_date  
    sorts: [sessions.count desc]
    limit: 500
    map: world
    colors: ['#5245ed']
  
  - name: sessions_by_state
    title: Sessions by State (US)
    type: looker_geo_choropleth
    model: heap_block
    explore: sessions
    dimensions: [sessions.region]
    measures: [sessions.count]
    filters:
      sessions.region: -NULL
    listen:
      date: sessions.session_date    
    sorts: [sessions.count desc]
    limit: 500
    map: usa
    show_view_names: true
    colors: ['#5245ed']









