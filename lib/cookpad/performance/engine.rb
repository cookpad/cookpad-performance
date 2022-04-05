module Cookpad
  module Performance
    class Engine < ::Rails::Engine
      isolate_namespace Cookpad::Performance

      config.to_prepare do
        return unless Rails.env.development?

        if Performance.log_n_plus_one_queries? || Performance.raise_n_plus_one_queries?
          ActionController::Base.class_eval do
            include NPlusOneDetection
          end
        end
      end
    end
  end
end
