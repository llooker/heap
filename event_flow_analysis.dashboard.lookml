- dashboard: event_flow_analysis
  title: Event Flow Analysis
  layout: grid
  rows:
    - elements: [events_drop_off]
      height: 400
    - elements: [event_flow]
      height: 400
    - elements: [top_5_second_events, top_5_third_events, top_5_fourth_events, top_5_fifth_events]
      height: 400
    - elements: [second_events, third_events, fourth_events, fifth_events]
      height: 400

  filters:

  - name: first_event
    type: field_filter
    explore: all_events
    field: all_events.event_name
    default_value: homepage_click_get_started # modify to desired default first event name value

  - name: date
    type: date_filter
    default_value: 30 days

  elements:

  - name: events_drop_off
    title: Events Drop Off
    type: looker_column
    model: heap_block
    explore: all_events
    measures: [all_events.count, event_flow.event_2_drop_off, event_flow.event_3_drop_off,
      event_flow.event_4_drop_off, event_flow.event_5_drop_off]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 500
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
    show_dropoff: true

  - name: event_flow
    title: Event Flow
    type: table
    model: heap_block
    explore: all_events
    dimensions: [all_events.event_name, event_flow.event_2, event_flow.event_3, event_flow.event_5,
      event_flow.event_4]
    measures: [all_events.count, all_events.count_percent_of_total]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 500
    show_view_names: true
    show_row_numbers: true
    table_theme: gray

  - name: top_5_second_events
    title: Top 5 Second Events
    type: looker_bar
    model: heap_block
    explore: all_events
    dimensions: [event_flow.event_2]
    measures: [all_events.count]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 5
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
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

  - name: top_5_third_events
    title: Top 5 Third Events
    type: looker_bar
    model: heap_block
    explore: all_events
    dimensions: [event_flow.event_3]
    measures: [all_events.count]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 5
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
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

  - name: top_5_fourth_events
    title: Top 5 Fourth Events
    type: looker_bar
    model: heap_block
    explore: all_events
    dimensions: [event_flow.event_4]
    measures: [all_events.count]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 5
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
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

  - name: top_5_fifth_events
    title: Top 5 Fifth Events
    type: looker_bar
    model: heap_block
    explore: all_events
    dimensions: [event_flow.event_5]
    measures: [all_events.count]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 5
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
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

  - name: second_events
    title: Second Events
    type: table
    model: heap_block
    explore: all_events
    dimensions: [event_flow.event_2]
    measures: [all_events.count]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 500
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
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

  - name: third_events
    title: Third Events
    type: table
    model: heap_block
    explore: all_events
    dimensions: [event_flow.event_3]
    measures: [all_events.count]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 500
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
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

  - name: fourth_events
    title: Fourth Events
    type: table
    model: heap_block
    explore: all_events
    dimensions: [event_flow.event_4]
    measures: [all_events.count]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 500
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
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

  - name: fifth_events
    title: Fifth Events
    type: table
    model: heap_block
    explore: all_events
    dimensions: [event_flow.event_5]
    measures: [all_events.count]
    listen:
      first_event: all_events.event_name
      date: all_events.time_date
    sorts: [all_events.count desc]
    limit: 500
    colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
      '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
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
