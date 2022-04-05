module NPlusOneDetection
  extend ActiveSupport::Concern

  included do
    around_action :n_plus_one_detection, if: -> { Cookpad::Performance.log_n_plus_one_queries? }
  end

  private

    def n_plus_one_detection
      Prosopite.scan
      yield
    ensure
      Prosopite.finish
    end
end
