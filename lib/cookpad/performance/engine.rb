module Cookpad
  module Performance
    class Engine < ::Rails::Engine
      isolate_namespace Cookpad::Performance

      config.to_prepare do
        if !Rails.env.production? &&
           (ENV["LOG_N_PLUS_ONE_QUERIES"] == "true" ||
             ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true")
          ActionController::Base.include(NPlusOneDetection)
        end
      end
    end
  end
end
