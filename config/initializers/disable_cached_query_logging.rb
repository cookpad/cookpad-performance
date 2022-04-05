if !Rails.env.production? && ENV["DISABLE_CACHED_QUERY_LOGGING"] == "true"
  require "disable_cached_query_logging"
  ActiveSupport::Logger.prepend DisableCachedQueryLogging
end
