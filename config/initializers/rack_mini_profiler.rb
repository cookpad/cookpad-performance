# frozen_string_literal: true

if Cookpad::Performance.rack_mini_profiler? && Rails.env.development?
  if Cookpad::Performance.profile?
    raise StandardError,
      "Can't run Rack::MiniProfiler in PROFILE mode."\
      " Read https://github.com/MiniProfiler/rack-mini-profiler#caching-behavior for more information."
  end
  require "rack-mini-profiler"

  # Initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)
end
