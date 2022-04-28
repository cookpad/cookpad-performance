require "spec_helper"

RSpec.describe "N+1 Detection", :database, initialization_helpers: true do
  before :all do
    # Might have been unloaded in initialization specs
    require "prosopite"
  end

  before do
    load_schema!
    unload_prosopite
    ENV.delete("LOG_N_PLUS_ONE_QUERIES")
    ENV.delete("RAISE_N_PLUS_ONE_QUERIES")
  end

  it "logs n+1s when LOG_N_PLUS_ONE_QUERIES is true" do
    set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")

    load("config/initializers/n_plus_one_detection.rb")

    expect(Prosopite.instance_variable_get(:@rails_logger)).to be_truthy
  end

  it "doesn't log n+1s when LOG_N_PLUS_ONE_QUERIES is false" do
    set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", "true")
    set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "false")

    load("config/initializers/n_plus_one_detection.rb")

    expect(Prosopite.instance_variable_get(:@rails_logger)).to be_falsey
  end

  it "raises exceptions when RAISE_N_PLUS_ONE_QUERIES is true" do
    set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", "true")

    load("config/initializers/n_plus_one_detection.rb")

    expect(Prosopite.instance_variable_get(:@raise)).to be_truthy
  end

  it "doesn't raise exceptions when RAISE_N_PLUS_ONE_QUERIES is false" do
    set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")

    set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", "false")

    load("config/initializers/n_plus_one_detection.rb")

    expect(Prosopite.instance_variable_get(:@raise)).to be_falsey
  end
end
