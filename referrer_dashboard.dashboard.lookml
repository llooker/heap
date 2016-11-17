- dashboard: referrer_dashboard
  title: Referrer Dashboard
  layout: grid
  rows:
    - elements: [total_sessions, distinct_users, avg_sessions_user, avg_session_dur]
      height: 220
    - elements: [daily_session_user_counts]
      height: 400
    - elements: [device_type_breakdown, conversion_funnel]
      height: 400

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
    default_value: google # modify to desired default mapped referrer domain

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
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
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
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    sorts: [sessions.average_sessions_per_user desc]
    limit: 500
    font_size: medium

  - name: avg_session_dur
    title: Average Session Duration (Minutes)
    type: single_value
    model: heap_block
    explore: sessions
    measures: [session_facts.average_session_duration_minutes]
    listen:
      date: sessions.session_date
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    filters:
      session_facts.session_duration_minutes: <300
    sorts: [session_facts.average_session_duration desc, session_facts.average_session_duration_minutes desc]
    limit: 500

  - name: daily_session_user_counts
    title: Daily Session and User Counts
    type: looker_line
    model: heap_block
    explore: sessions
    dimensions: [sessions.session_date]
    measures: [sessions.count, sessions.count_users]
    listen:
      date: sessions.session_date
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    sorts: [sessions.count desc]
    limit: 100
    column_limit: 50
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
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear

  - name: device_type_breakdown
    title: Device Type Breakdown
    type: looker_bar
    model: heap_block
    explore: sessions
    dimensions: [sessions.device_type]
    measures: [sessions.count]
    listen:
      date: sessions.session_date
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    sorts: [sessions.count desc]
    limit: 100
    column_limit: 50
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
    show_x_axis_ticks: true
    x_axis_scale: auto


  - name: conversion_funnel
    title: Custom Conversion Funnel
    type: looker_column
    model: heap_block
    explore: funnel_explorer
    measures: [funnel_explorer.count_sessions_event1, funnel_explorer.count_sessions_event12,
      funnel_explorer.count_sessions_event123]
    listen:
      date: funnel_explorer.event_time
      device_type: sessions.device_type
      referrer_domain: sessions.referrer_domain_mapped
    filters:
      funnel_explorer.event1: homepage_click_get_started
      funnel_explorer.event2: '"signed^_up"'
      funnel_explorer.event3: '"dashboard^_galleries^_click^_add^_files"'
    sorts: [funnel_explorer.count_sessions_event1 desc]
    limit: 500
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    show_value_labels: true
    label_density: 25
    legend_position: center
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_dropoff: true
