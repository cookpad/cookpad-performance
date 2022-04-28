require "spec_helper"

RSpec.describe "Cookpad::Performance::Initialization", initialization_helpers: true do
  before do
    set_environment_variable("LOG_N_PLUS_ONE_QUERIES", nil)
    set_environment_variable("PROFILE", nil)
    set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", nil)
  end

  context "when LOG_N_PLUS_ONE_QUERIES is true" do
    it "sets Prosopite.rails_logger to true" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")

      refresh_object_space!
      load("config/initializers/n_plus_one_detection.rb")

      expect(Prosopite.instance_variable_get(:@rails_logger)).to be_truthy
    end

    it "sets Prosopite prosopite_logger to true" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")

      refresh_object_space!
      load("config/initializers/n_plus_one_detection.rb")

      expect(Prosopite.instance_variable_get(:@prosopite_logger)).to be_truthy
    end

    it "sets Prosopite stderr_logger to false" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")

      refresh_object_space!
      load("config/initializers/n_plus_one_detection.rb")

      expect(Prosopite.instance_variable_get(:@stderr_logger)).to be_falsey
    end

    it "sets Prosopite raise to false" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")
      set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", "false")

      refresh_object_space!
      load("config/initializers/n_plus_one_detection.rb")

      expect(Prosopite.instance_variable_get(:@raise)).to be_falsey
    end
  end

  context "when LOG_N_PLUS_ONE_QUERIES is not set" do
    it "doesn't load Prosopite" do
      ENV.delete("LOG_N_PLUS_ONE_QUERIES")

      refresh_object_space!
      load("config/initializers/n_plus_one_detection.rb")

      expect(defined?(Prosopite)).to be_nil
    end
  end

  context "when RAISE_N_PLUS_ONE_QUERIES is true" do
    it "doesn't load Prosopite" do
      set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", "true")

      refresh_object_space!
      load("config/initializers/n_plus_one_detection.rb")

      expect(defined?(Prosopite)).to eql("constant")
    end
  end

  private

    def refresh_object_space!
      unload_prosopite
      load("cookpad/performance.rb")
    end
end
