- dashboard: funnel_explorer
  title: Funnel Explorer
  layout: grid
  rows:
    - elements: [custom_funnel]
      height: 400

  filters:
  
  - name: event_1
    type: field_filter
    explore: all_events
    field: all_events.event_name
    default_value: start_game
  
  - name: event_2
    type: field_filter
    explore: all_events
    field: all_events.event_name
    default_value: reports_view_any_report
  
  - name: event_3
    type: field_filter
    explore: all_events
    field: all_events.event_name
    default_value: list_run_query
  elements:

  - name: custom_funnel
    title: Custom Funnel
    type: looker_column
    model: heap_block
    explore: funnel_explorer
    measures: [funnel_explorer.count_sessions_event1, funnel_explorer.count_sessions_event12,
      funnel_explorer.count_sessions_event123]
    listen:
      event_1: funnel_explorer.event1
      event_2: funnel_explorer.event2
      event_3: funnel_explorer.event3
    sorts: [funnel_explorer.count_sessions_event1 desc]
    limit: 500
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
    show_dropoff: true

