- view: sessions
  sql_table_name: main_production.sessions
  fields:

  - dimension: session_id
    primary_key: true
    type: int
    sql: ${TABLE}.session_id

  - dimension: app_name
    sql: ${TABLE}.app_name

  - dimension: app_version
    sql: ${TABLE}.app_version

  - dimension: browser
    sql: ${TABLE}.browser

  - dimension: carrier
    sql: ${TABLE}.carrier

  - dimension: city
    sql: ${TABLE}.city

  - dimension: country
    sql: ${TABLE}.country

  - dimension: device_type
    sql: ${TABLE}.device_type

  - dimension: event_id
    type: int
    sql: ${TABLE}.event_id

  - dimension: landing_page
    sql: ${TABLE}.landing_page

  - dimension: library
    sql: ${TABLE}.library

  - dimension: phone_model
    sql: ${TABLE}.phone_model

  - dimension: platform
    sql: ${TABLE}.platform

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: region
    sql: ${TABLE}.region

  - dimension: search_keyword
    sql: ${TABLE}.search_keyword

  - dimension_group: session
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.session_time

  - dimension_group: time
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time

  - dimension: user_id
    type: int
    # hidden: true
    sql: ${TABLE}.user_id

  - dimension: utm_campaign
    sql: ${TABLE}.utm_campaign

  - dimension: utm_content
    sql: ${TABLE}.utm_content

  - dimension: utm_medium
    sql: ${TABLE}.utm_medium

  - dimension: utm_source
    sql: ${TABLE}.utm_source

  - dimension: utm_term
    sql: ${TABLE}.utm_term

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    detail:
    - session_id
    - app_name
    - users.user_id
    - about_click_on_profile_picture.count
    - about_click_on_team_member_s_github.count
    - about_click_on_twitter_handle.count
    - about_page_clicks.count
    - about_view_about_page.count
    - account_settings_add_teammate.count
    - account_settings_click_on_account.count
    - account_settings_click_on_account_part_1_.count
    - account_settings_click_on_account_part_2_.count
    - account_settings_click_on_data_management.count
    - account_settings_click_on_docs.count
    - account_settings_click_on_exclude_ips.count
    - account_settings_click_on_hide_custom_event.count
    - account_settings_click_on_latest_updates.count
    - account_settings_click_on_payment.count
    - account_settings_click_on_projects.count
    - account_settings_click_on_teammates.count
    - account_settings_click_on_usage.count
    - account_settings_click_usage_tab.count
    - account_settings_remove_teammate.count
    - account_settings_save_ip_filter.count
    - account_settings_unhide_custom_event.count
    - adwords_page_view.count
    - all_events.count
    - analysis_run_query_mobile_.count
    - analyze_click_on_calculating_.count
    - analyze_click_on_export.count
    - analyze_click_on_funnels.count
    - analyze_click_on_graph.count
    - analyze_click_on_list.count
    - analyze_click_on_retention.count
    - analyze_click_reset.count
    - analyze_click_run_query.count
    - analyze_click_run_query_new_.count
    - analyze_click_run_query_old_.count
    - analyze_save_a_report.count
    - analyze_toggle_sample_checkbox.count
    - analyze_view_any_analysis_view.count
    - any_app_page_view.count
    - badge_click_badge_on_embed.count
    - badge_view_badge_page.count
    - blog.count
    - blog_view_any_blog_post.count
    - blog_view_aws_costs.count
    - blog_view_building_ios_integration.count
    - blog_view_cs_vs_ts_post.count
    - blog_view_event_visualizer.count
    - blog_view_lateral_joins.count
    - blog_view_line_graph.count
    - blog_view_partial_indexes.count
    - blog_view_postgres_arrays_part_1_.count
    - blog_view_postgres_arrays_part_2_.count
    - blog_view_postgres_posts.count
    - blog_view_pricing.count
    - blog_view_snapshots.count
    - click_contact_us_button.count
    - click_on_customer_success_job.count
    - click_on_email_settings.count
    - click_on_option.count
    - click_on_save_button.count
    - click_on_sign_up.count
    - click_sign_up_pricing_.count
    - clicked_customer_story_donors_choose.count
    - clicked_on_get_started.count
    - compare_view_a_comparison_page.count
    - complete_info_view_complete_info_old_.count
    - contact_us.count
    - contact_us_button.count
    - contact_us_button_pricing_page.count
    - contact_us_button_pricing_page_.count
    - contact_us_hootsuite.count
    - contact_us_pricingpage_.count
    - customer_stories_view_customer_stories.count
    - customers_view_customers_page.count
    - customers_viewed_case_study.count
    - dashboard_click_project_dropdown.count
    - dashboard_view_any_dashboard_page.count
    - dashboard_view_dashboard.count
    - dashboard_view_demo_dashboard_old_.count
    - dashboard_view_welcome_page.count
    - datablog_click_on_what_is_heap_.count
    - datablog_submit_subscribe_form.count
    - datablog_the_case_for_uber_s_deceptive_data.count
    - datablog_view_ab_tests.count
    - datablog_view_anomalies_5_7_14_.count
    - datablog_view_anscombe_s_quartet.count
    - datablog_view_any_post.count
    - datablog_view_average_revenue.count
    - datablog_view_herbalife.count
    - datablog_view_misleading_visualizations.count
    - define_click_cohorts_old_.count
    - define_click_on_events.count
    - define_click_on_new_definition_old_.count
    - define_click_on_save_as_new_definition.count
    - define_click_set_property.count
    - defined_events_define_event.count
    - defined_events_define_event_old_.count
    - defined_events_define_new_event_segment.count
    - defined_events_remove_event.count
    - defined_events_remove_event_from_definitions_dropdown_.count
    - defined_events_search_on_filter_events.count
    - defined_events_search_on_filter_events_magic_.count
    - demo_video_finished.count
    - demo_video_paused.count
    - demo_video_played.count
    - dig_into_lastseen_data.count
    - docs_click_drag_heap_bookmarklet.count
    - docs_click_on_download_ios_manually.count
    - docs_click_on_sidebar_link.count
    - docs_view_any_doc.count
    - docs_view_custom_api.count
    - docs_view_getting_started.count
    - docs_view_installation.count
    - docs_view_sse.count
    - docs_view_technical_details.count
    - dorianj_test.count
    - dropdown_filter_change_.count
    - email_sent_invitation_email.count
    - email_unsubscribe_from_drip_emails_old_.count
    - emailed_reports_open_menu.count
    - emailed_reports_remove_recipient.count
    - engagement_query_view_report_combo.count
    - entered_telephone_number.count
    - error_sentry_error_parse_rawdefinedevent_combo_has_deleted_symbol.count
    - ev_change_on_launch_web.count
    - ev_click_exit_old_.count
    - ev_click_on_launch_on_ios_old_.count
    - ev_click_on_launch_web.count
    - ev_click_on_launch_web_old_.count
    - ev_launch_web_all_.count
    - ev_open_page_from_dropdown_old_.count
    - ev_start_from_page_old_.count
    - ev_submit_on_define_ios_event_old_.count
    - ev_view_visualizer.count
    - ev_watch_ios_demo_video_old_.count
    - ev_web_launch_failed.count
    - events_click_on_define_event_new_.count
    - events_click_on_define_event_old_.count
    - events_click_on_duplicate_event_old_.count
    - events_click_on_track_api.count
    - events_update_event_definition.count
    - execute_query.count
    - features_click_on_event_visualizer.count
    - features_click_on_event_visualizer_old_.count
    - features_click_on_funnels_old_.count
    - features_click_on_graph_learn_more.count
    - features_view_ios_ev_page.count
    - footer_click_on_about.count
    - footer_click_on_blog_link.count
    - footer_click_on_jobs.count
    - footer_click_on_sign_up_button_old_.count
    - funnel_view_any_funnel_view.count
    - geetanjali_click_pricing.count
    - give_me_the_endpoint.count
    - graph_click_add_event_button.count
    - graph_click_on_pie_chart.count
    - graph_click_on_unique.count
    - graph_preview_click_analyze_this_event_.count
    - graph_toggle_cumulative_graph_old_.count
    - graph_view_graph.count
    - group_by_click_add_group_by_button.count
    - header_click_account.count
    - header_click_documents.count
    - hello.count
    - help_center_search.count
    - help_clicked_info_icon_old_.count
    - help_open_help_modal_combo_.count
    - help_open_help_modal_current_.count
    - help_open_help_modal_old_as_of_9_4_15_.count
    - history_click_on_delete_history_entry.count
    - history_view_history_entry.count
    - homepage_click_learn_more_old_.count
    - homepage_click_on_hello_mail_to_old_.count
    - homepage_click_on_read_more_customer_stories.count
    - homepage_click_on_sign_up_button_old_.count
    - homepage_click_signup_button_old_.count
    - homepage_play_video_old_.count
    - homepage_show_more_tweets_old_.count
    - homepage_submit_email_form_old_.count
    - homepage_view_from_niket_signature.count
    - homepage_view_homepage_.count
    - homepage_view_homepage_via_facebook_retargeting.count
    - homepage_view_homepage_via_referral.count
    - homepage_viewed_any_homepage.count
    - insight_demo_click_on_sign_up.count
    - install_app.count
    - install_click_on_instructions_snippet.count
    - install_email_colleague.count
    - install_view_install_page.count
    - internal_switch_user.count
    - jobs_click_to_team_page.count
    - jobs_viewed_customer_success_job.count
    - jobs_viewed_jobs_page.count
    - jobs_viewed_writer_job.count
    - learn_more_click_on_ev.count
    - learn_more_click_on_learn_more_any_.count
    - learn_more_click_on_users.count
    - list_click_on_export.count
    - list_click_on_n_events_.count
    - list_click_on_next_page.count
    - list_click_show_more.count
    - list_define_event.count
    - list_define_event_new_.count
    - list_define_event_old_.count
    - list_hide_undefined_events.count
    - list_run_query.count
    - list_show_undefined_events.count
    - login_any_login.count
    - login_mobile_login.count
    - login_view_login_page.count
    - logout.count
    - marketing_pages_any_pageview.count
    - matt_soft_delete_test.count
    - navigation_click_on_any_link.count
    - navigation_click_on_customers.count
    - navigation_click_on_features.count
    - navigation_click_on_features_old_.count
    - navigation_click_on_go_to_dashboard_old_.count
    - navigation_click_on_open_dashboard.count
    - navigation_click_on_pricing.count
    - navigation_click_on_sign_up.count
    - niket_signature.count
    - nk_click_sign_up_on_pricing_page.count
    - nk_demo_click_sign_up.count
    - payment_submit_payment_form.count
    - payment_view_payment_page.count
    - pircing_page_sign_up.count
    - populate_report.count
    - populate_report_reportid_not_defined.count
    - pricing_click_on_contact_us.count
    - pricing_click_on_customers.count
    - pricing_click_on_get_it_for_free.count
    - pricing_click_on_signup_cta.count
    - pricing_click_on_users_feature.count
    - pricing_click_on_users_icon.count
    - pricing_page.count
    - pricing_submit_email_form_old_.count
    - pricing_view_pricing_page.count
    - ps_demo_sign_up_from_pricing_page.count
    - raygun_error.count
    - recruiting_viewed_heap_challenge.count
    - recruiting_viewed_helenora_heapenson.count
    - recruiting_viewed_herbert_heapenson.count
    - referral_email_referral.count
    - referral_open_referral_program_all_.count
    - referral_open_referral_program_heart_.count
    - referral_open_referral_program_settings_.count
    - referral_tweet.count
    - reports_view_a_funnel_report.count
    - reports_view_a_graph_report.count
    - reports_view_a_list_report.count
    - reports_view_a_retention_report.count
    - reports_view_any_report.count
    - reset_password_view_reset_password.count
    - retention_define_cohort_old_.count
    - segments_update_segment_definition.count
    - send_feedback.count
    - send_report_email.count
    - send_transactional_email.count
    - sentry_error.count
    - sign_up.count
    - sign_up_change_company_name.count
    - sign_up_click_start_using_heap.count
    - sign_up_enter_company_name.count
    - sign_up_enter_email.count
    - sign_up_enter_phone.count
    - sign_up_from_pricing_page.count
    - sign_up_on_pricing_page_.count
    - sign_up_page_entered_email.count
    - sign_up_submit_sign_up_form.count
    - sign_up_submit_sign_up_form_combo_.count
    - sign_up_view_signup_page.count
    - signup_from_pricing_page.count
    - signup_on_pricing.count
    - signup_on_pricing_page_.count
    - signup_pricing_page_.count
    - start_game.count
    - status_viewed_status_page.count
    - suggested_event_change.count
    - suggested_event_click.count
    - suggested_event_other.count
    - suggested_event_pageview.count
    - suggested_event_submit.count
    - suggested_events_click_on_suggested_event.count
    - talk_to_us_click_on_dismiss.count
    - talk_to_us_click_talk_to_us.count
    - talk_to_us_submit_feedback.count
    - talk_to_us_type_message.count
    - test_123.count
    - test_broken_combo.count
    - test_pageview_stuff.count
    - test_xss.count
    - tour_close_tour_all_.count
    - tour_close_tour_checklist_.count
    - tour_close_tour_tooltip_.count
    - tour_next_page.count
    - tour_reinitiate_tour.count
    - tour_step_1_events_.count
    - tour_step_2_segments_.count
    - tour_step_3_funnels_.count
    - tour_step_4_list_.count
    - tour_step_5_graph_.count
    - unity_demo_clicked_sign_up.count
    - unity_demo_view_pricing_page.count
    - view_event_page_or_visualize.count
    - view_pricing_page.count
    - viewed_homepage_referral.count
    - viewed_jobs_page.count
    - viewed_redshift_sql_page.count
    - your_documents_new_document.count

