require "spec_helper"

RSpec.describe "Cookpad::Performance::Initialization" do
  it "sets Prosopite prosopite_logger to true" do
    load "config/initializers/n_plus_one_detection.rb"

    expect(Prosopite.instance_variable_get(:@prosopite_logger)).to be_truthy
  end

  it "sets Prosopite stderr_logger to false" do
    load "config/initializers/n_plus_one_detection.rb"

    expect(Prosopite.instance_variable_get(:@stderr_logger)).to be_falsey
  end

  it "sets Prosopite raise to false" do
    load "config/initializers/n_plus_one_detection.rb"

    expect(Prosopite.instance_variable_get(:@raise)).to be_falsey
  end

  context "when LOG_N_PLUS_ONE_QUERIES is true" do
    it "sets Prosopite.rails_logger to true" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")
      load "config/initializers/n_plus_one_detection.rb"

      expect(Prosopite.instance_variable_get(:@rails_logger)).to be_truthy
    end
  end

  context "when LOG_N_PLUS_ONE_QUERIES is false" do
    it "sets Prosopite.rails_logger to false" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "false")
      load "config/initializers/n_plus_one_detection.rb"

      expect(Prosopite.instance_variable_get(:@rails_logger)).to be_falsey
    end
  end
end