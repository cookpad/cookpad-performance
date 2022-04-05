if defined?(Prosopite) && (Rails.env.development? || Rails.env.test?)
  Prosopite.rails_logger = Cookpad::Performance.log_n_plus_one_queries?
  Prosopite.prosopite_logger = true
  Prosopite.stderr_logger = false
  Prosopite.raise = Cookpad::Performance.raise_n_plus_one_queries?
end
