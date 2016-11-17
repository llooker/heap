- dashboard: sessions_overview
  title: Sessions Overview
  layout: grid
  rows:
    - elements: [total_sessions, distinct_users, avg_sessions_user, avg_session_dur]
      height: 220
    - elements: [new_sessions]
      height: 400
    - elements: [daily_session_cnt_dur, sessions_by_device]
      height: 400
    - elements: [sessions_and_users, top_100_events]
      height: 400
    - elements: [top_15_external_referers, referrer_stats]
      height: 400
    - elements: [sessions_by_country, sessions_by_state]
      height: 400
    - elements: [retention_area]
      height: 400
    - elements: [percent_retention_table]
      height: 250

  filters:

  - name: date
    title: "Date"
    type: date_filter
    default_value: 30 days

  - name: device_type
    type: field_filter
    explore: sessions
    field: sessions.device_type

  - name: referrer_domain
    type: field_filter
    explore: sessions
    field: sessions.referrer_domain_mapped

  elements:

  - name: total_sessions
    title: Total Sessions
    type: single_value
    model: heap_block
    explore: sessions
    measures: [sessions.count]
    listen:
      date: sessions.session_date
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
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
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
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
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    limit: 500
    font_size: medium

  - name: avg_session_dur
    title: Average Session Duration (Minutes)
    type: single_value
    model: heap_block
    explore: sessions
    measures: [session_facts.average_session_duration_minutes]
    listen:
      date: session_facts.session_start_time_date
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    filters:
      session_facts.session_duration_minutes: <300
    limit: 500

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
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
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

  - name: daily_session_cnt_dur
    title: Daily Session Count and Session Duration
    type: looker_column
    model: heap_block
    explore: sessions
    dimensions: [sessions.session_date]
    measures: [session_facts.average_session_duration_minutes, sessions.count]
    listen:
      date: sessions.session_date
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    filters:
      session_facts.session_duration_minutes: <300
    sorts: [sessions.session_date]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: 25
    font_size: medium
    hide_legend: true
    y_axis_gridlines: true
    series_types:
      session_facts.average_session_duration_minutes: line
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_orientation: [right, left]
    y_axis_combined: false


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
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
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

  - name: referrer_stats
    title: External Referrer Stats
    type: table
    model: heap_block
    explore: sessions
    dimensions: [sessions.referrer_domain_mapped]
    measures: [sessions.count, sessions.count_users, session_facts.average_session_duration_minutes]
    filters:
      sessions.referrer: -NULL,-%heapanalytics%
    listen:
      date: sessions.session_date
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    sorts: [sessions.count desc]
    limit: 100
    show_view_names: false
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
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_tick_density_custom: 5
    ordering: none
    show_null_labels: false
    show_row_numbers: true
    table_theme: gray

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
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
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
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
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
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    sorts: [sessions.count desc]
    limit: 500
    map: usa
    show_view_names: true
    colors: ['#5245ed']

  - name: retention_area
    title: User Retention by First Month (Authenticated Users)
    type: looker_area
    model: heap_block
    explore: sessions
    dimensions: [user_facts.first_session_month, sessions.session_month]
    pivots: [user_facts.first_session_month]
    measures: [sessions.count_users]
    listen:
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    filters:
      sessions.session_month: 8 months ago for 8 months
      user_facts.first_session_month: 8 months ago for 8 months
      users.identity: -NULL
    sorts: [sessions.session_month, user_facts.first_session_month]
    limit: 500
    column_limit: 50
    stacking: normal
    colors: ['#F16358', '#E0635E', '#D06464', '#BF656B', '#AF6671', '#9F6777', '#8E687E',
      '#7E6984', '#6E6A8A', '#5D6B91', '#4D6C97', '#3D6D9E']
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
    point_style: none
    interpolation: linear

  - name: percent_retention_table
    title: Retention Table
    type: table
    model: heap_block
    explore: sessions
    dimensions: [user_facts.first_session_month, sessions.session_month]
    pivots: [user_facts.first_session_month]
    measures: [sessions.count_users]
    dynamic_fields:
    - table_calculation: percent_returned
      label: Percent Returned
      expression: 100*(${sessions.count_users}/max(${sessions.count_users}))
      value_format: 0.00\%
    listen:
        device_type: sessions.device_type
        referrer_domain: sessions.referrer_domain_mapped
    filters:
      sessions.session_month: 8 months ago for 8 months
      user_facts.first_session_month: 8 months ago for 8 months
      users.identity: -NULL
    sorts: [sessions.session_month, user_facts.first_session_month]
    limit: 500
    column_limit: 50
    show_view_names: true
    ordering: none
    show_null_labels: false
    color_palette: Tomato to Steel Blue
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    point_style: none
    interpolation: linear
    show_null_points: true
    colors: ['#F16358', '#E0635E', '#D06464', '#BF656B', '#AF6671', '#9F6777', '#8E687E',
      '#7E6984', '#6E6A8A', '#5D6B91', '#4D6C97', '#3D6D9E']
    hidden_fields: [sessions.count_users]
    show_row_numbers: true
    table_theme: gray

  - name: sessions_and_users
    title: Daily Count Sessions and Users
    type: looker_column
    model: heap_block
    explore: sessions
    dimensions: [sessions.session_date]
    measures: [sessions.count_users, sessions.count]
    listen:
      date: sessions.session_date
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    sorts: [sessions.session_date]
    limit: 500
    column_limit: 50
    colors: ['#5245ed', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a', '#706080',
      '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    label_density: 25
    font_size: medium
    legend_position: center
    y_axis_gridlines: true
    show_view_names: true
    series_labels:
      'No': Returning Session
      'Yes': First Session
    series_types:
      sessions.count_users: line
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto

  - name: top_100_events
    title: Top 100 Event Types
    type: table
    model: heap_block
    explore: all_events
    dimensions: [all_events.event_name]
    measures: [all_events.count, sessions.count, all_events.count_users]
    listen:
      date: all_events.time_date
      # device_type: all_events.device_type
      # referrer_domain: all_events.referrer_domain_mapped
    sorts: [all_events.count desc]
    limit: 100
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
    table_theme: gray
