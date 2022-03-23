if defined?(Prosopite) && (Rails.env.development? || Rails.env.test?)
  Prosopite.rails_logger = ENV["LOG_N_PLUS_ONE_QUERIES"] == "true"
  Prosopite.prosopite_logger = true
  Prosopite.stderr_logger = false
  Prosopite.raise = false
end
