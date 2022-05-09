require "rails_helper"
require "./app/controllers/concerns/cookpad/performance/n_plus_one_detection"

RSpec.describe Cookpad::Performance::NPlusOneDetection, type: :controller, database: true do
  controller(ActionController::Base) do
    include Cookpad::Performance::NPlusOneDetection
    include TestDatabase
    def index
      test_model.find_by(user_id: 1)
      test_model.find_by(user_id: 2)
      test_model.find_by(user_id: 3)
      head :ok
    end
  end

  it "calls Prosopite around a controller action" do
    require "prosopite"
    set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")
    load_schema!

    expect(Prosopite).to receive(:scan)
    expect(Prosopite).to receive(:finish)

    get :index
  end
end
