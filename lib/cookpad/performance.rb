require "rails"
require "cookpad/performance/version"
require "cookpad/performance/engine"
if ENV["LOG_N_PLUS_ONE_QUERIES"] == "true" || ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true"
  require "prosopite"
end

module Cookpad
  module Performance
  end
end
