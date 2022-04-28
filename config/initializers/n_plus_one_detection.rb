if (ENV["LOG_N_PLUS_ONE_QUERIES"] == "true" || ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true") &&
  (Rails.env.development? || Rails.env.test?)
  require "prosopite"
  Prosopite.rails_logger = ENV["LOG_N_PLUS_ONE_QUERIES"] == "true"
  Prosopite.prosopite_logger = true
  Prosopite.stderr_logger = false
  Prosopite.raise = ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true"
end
