module Cookpad
  module Performance
    class Engine < ::Rails::Engine
      isolate_namespace Cookpad::Performance

      config.to_prepare do
        if !Rails.env.production? &&
           (ENV["LOG_N_PLUS_ONE_QUERIES"] == "true" ||
             ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true")
          require "app/controllers/concerns/n_plus_one_detection"
          ActionController::Base.include(NPlusOneDetection)
        end
      end
    end
  end
end
