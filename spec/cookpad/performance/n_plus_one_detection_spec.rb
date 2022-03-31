require "spec_helper"
require "prosopite"

RSpec.describe "N+1 Detection", :database do
  before do
    load_schema!
  end

  it "logs n+1s when LOG_N_PLUS_ONE_QUERIES is true" do
    set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")
    load("config/initializers/n_plus_one_detection.rb")

    expect(Prosopite.instance_variable_get(:@rails_logger)).to be(true)
  end

  it "doesn't log n+1s when LOG_N_PLUS_ONE_QUERIES is false" do
    set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "false")
    load("config/initializers/n_plus_one_detection.rb")

    expect(Prosopite.instance_variable_get(:@rails_logger)).to be(false)
  end

  it "raises exceptions when RAISE_N_PLUS_ONE_QUERIES is true" do
    set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", "true")
    load("config/initializers/n_plus_one_detection.rb")

    expect(Prosopite.instance_variable_get(:@raise)).to be(true)
  end

  it "doesn't raise exceptions when RAISE_N_PLUS_ONE_QUERIES is false" do
    set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", "false")
    load("config/initializers/n_plus_one_detection.rb")

    expect(Prosopite.instance_variable_get(:@raise)).to be(false)
  end
end
