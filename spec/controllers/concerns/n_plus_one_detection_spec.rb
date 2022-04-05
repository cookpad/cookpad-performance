require "rails_helper"
require "./app/controllers/concerns/n_plus_one_detection"

RSpec.describe NPlusOneDetection, type: :controller, database: true do
  controller(ActionController::Base) do
    include NPlusOneDetection
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

    load_schema!

    expect(Cookpad::Performance).to receive(:log_n_plus_one_queries?).and_return(true)
    expect(Prosopite).to receive(:scan)
    expect(Prosopite).to receive(:finish)

    get :index
  end
end
