module Cookpad
  module Performance
    module NPlusOneDetection
      extend ActiveSupport::Concern

      included do
        around_action :n_plus_one_detection, if: :should_detect_n_plus_ones?
      end

      private

        def should_detect_n_plus_ones?
          ENV["LOG_N_PLUS_ONE_QUERIES"] == "true" ||
            ENV["RAISE_N_PLUS_ONE_QUERIES"] == "true"
        end

        def n_plus_one_detection
          Prosopite.scan
          yield
        ensure
          Prosopite.finish
        end
    end
  end
end
