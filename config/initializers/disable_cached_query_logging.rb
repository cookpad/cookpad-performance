if !Rails.env.production? && ENV["DISABLE_CACHED_QUERY_LOGGING"] == "true"
  require "cookpad/performance/disable_cached_query_logging"
  ActiveSupport::Logger.prepend Cookpad::Performance::DisableCachedQueryLogging
end
