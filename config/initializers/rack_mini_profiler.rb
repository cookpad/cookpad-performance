# frozen_string_literal: true

if ENV["RACK_MINI_PROFILER"] == "true" && Rails.env.development?
  if ENV["PROFILE"] == "true"
    raise StandardError,
      "Can't run Rack::MiniProfiler in PROFILE mode."\
      " Read https://github.com/MiniProfiler/rack-mini-profiler#caching-behavior for more information."
  end
  require "rack-mini-profiler"

  # Initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)
end
