if ENV["LOG_N_PLUS_ONE_QUERIES"] == "true" || ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true"
  require "prosopite"

  if Rails.env.development? || Rails.env.test?
    Prosopite.rails_logger = ENV["LOG_N_PLUS_ONE_QUERIES"] == "true"
    Prosopite.prosopite_logger = true
    Prosopite.stderr_logger = false
    Prosopite.raise = ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true"
  end
end
