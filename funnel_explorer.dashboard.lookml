- dashboard: funnel_explorer
  title: Funnel Explorer
  layout: grid
  rows:
    - elements: [custom_funnel]
      height: 400
    - elements: [trending_event_1_conversion]
      height: 400
    - elements: [trending_event_2_conversion]
      height: 400
    - elements: [trending_event_3_conversion]
      height: 400

  filters:

  - name: event_1
    type: field_filter
    explore: all_events
    field: all_events.event_name
    default_value: homepage_click_get_started # modify to desired default first event name value

  - name: event_2
    type: field_filter
    explore: all_events
    field: all_events.event_name
    default_value: signed_up # modify to desired default second event name value

  - name: event_3
    type: field_filter
    explore: all_events
    field: all_events.event_name
    default_value: dashboard_galleries_click_add_files # modify to desired third event name value

  - name: date
    type: date_filter
    default_value: 30 days

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
      date: funnel_explorer.session_date
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
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

  - name: trending_event_1_conversion
    title: Trending Conversion Rates Event 1
    type: looker_line
    model: heap_block
    explore: funnel_explorer
    dimensions: [funnel_explorer.session_date]
    measures: [funnel_explorer.conversion_rate_event_1]
    listen:
      event_1: funnel_explorer.event1
      event_2: funnel_explorer.event2
      event_3: funnel_explorer.event3
      date: funnel_explorer.session_date
    sorts: [funnel_explorer.session_date]
    limit: 500
    show_value_labels: true
    label_density: '8'
    label_color: [black]
    colors: ['#5245ed', '#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    font_size: '12'
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

  - name: trending_event_2_conversion
    title: Trending Conversion Rates Event 2
    type: looker_line
    model: heap_block
    explore: funnel_explorer
    dimensions: [funnel_explorer.session_date]
    measures: [funnel_explorer.conversion_rate_event_2]
    colors: ['#ed6168', '#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    listen:
      event_1: funnel_explorer.event1
      event_2: funnel_explorer.event2
      event_3: funnel_explorer.event3
      date: funnel_explorer.session_date
    sorts: [funnel_explorer.session_date]
    limit: 500
    show_value_labels: true
    label_density: '8'
    label_color: [black]
    font_size: '12'
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

  - name: trending_event_3_conversion
    title: Trending Conversion Rates Event 3
    type: looker_line
    model: heap_block
    explore: funnel_explorer
    dimensions: [funnel_explorer.session_date]
    measures: [funnel_explorer.conversion_rate_event_3]
    colors: ['#1ea8df', '#353b49', '#49cec1', '#b3a0dd', '#db7f2a',
      '#706080', '#a2dcf3', '#776fdf', '#e9b404', '#635189']
    listen:
      event_1: funnel_explorer.event1
      event_2: funnel_explorer.event2
      event_3: funnel_explorer.event3
      date: funnel_explorer.session_date
    sorts: [funnel_explorer.session_date]
    limit: 500
    show_value_labels: true
    label_density: '8'
    label_color: [black]
    font_size: '12'
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
