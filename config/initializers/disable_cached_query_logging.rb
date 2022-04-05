if !Rails.env.production? && Cookpad::Performance.disable_cached_query_logging?
  require "disable_cached_query_logging"
  ActiveSupport::Logger.prepend DisableCachedQueryLogging
end
