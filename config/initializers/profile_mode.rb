if ENV["PROFILE"] == "true" && Rails.env.development?
  Rails.application.configure do
    config.cache_classes = true
    config.eager_load = true

    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
    config.log_level = :info

    config.active_record.verbose_query_logs = false
    config.active_record.migration_error = false

    config.public_file_server.enabled = true
    config.public_file_server.headers = {
      "Cache-Control" => "max-age=315360000, public",
      "Expires" => "Tue, 31 Dec 2030 23:55:55 GMT"
    }
    config.assets.js_compressor = Uglifier.new(harmony: true)
    config.assets.compile = false
    config.assets.digest = true
    config.assets.debug = false

    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.action_mailer.perform_caching = true

    config.action_view.cache_template_loading = true
    config.action_view.annotate_rendered_view_with_filenames = false

    config.log_tags = [:request_id]
  end
end
