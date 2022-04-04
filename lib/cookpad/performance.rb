if ENV["LOG_N_PLUS_ONE_QUERIES"] == "true" || ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true"
  require "prosopite"
end
require "rails"
require "cookpad/performance/version"
require "cookpad/performance/engine"

module Cookpad
  module Performance
  end
end
