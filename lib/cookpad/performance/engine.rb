module Cookpad
  module Performance
    class Engine < ::Rails::Engine
      isolate_namespace Cookpad::Performance

      config.to_prepare do
        return unless Rails.env.development?

        if ENV["LOG_N_PLUS_ONE_QUERIES"] == "true" || ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true"
          ActionController::Base.class_eval do
            include NPlusOneDetection
          end
        end
      end
    end
  end
end
