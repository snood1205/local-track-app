# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.action_controller.raise_on_missing_callback_actions = true
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.action_view.annotate_rendered_view_with_filenames = true
  config.active_record.migration_error = :page_load
  config.active_record.query_log_tags_enabled = true
  config.active_record.verbose_query_logs = true
  config.active_support.deprecation = :log
  config.consider_all_requests_local = true
  config.eager_load = false
  config.enable_reloading = true
  config.generators.apply_rubocop_autocorrect_after_generate!
  config.i18n.raise_on_missing_translations = true
  config.server_timing = true
end
