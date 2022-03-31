require "spec_helper"

RSpec.describe "Cookpad::Performance::Initialization" do
  before do
    set_environment_variable("LOG_N_PLUS_ONE_QUERIES", nil)
    set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", nil)
  end

  context "when LOG_N_PLUS_ONE_QUERIES is true" do
    it "sets Prosopite.rails_logger to true" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")

      refresh_object_space!

      expect(Prosopite.instance_variable_get(:@rails_logger)).to be_truthy
    end

    it "sets Prosopite prosopite_logger to true" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")

      refresh_object_space!

      expect(Prosopite.instance_variable_get(:@prosopite_logger)).to be_truthy
    end

    it "sets Prosopite stderr_logger to false" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")

      refresh_object_space!

      expect(Prosopite.instance_variable_get(:@stderr_logger)).to be_falsey
    end

    it "sets Prosopite raise to false" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "true")
      set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", "false")

      refresh_object_space!

      expect(Prosopite.instance_variable_get(:@raise)).to be_falsey
    end
  end

  context "when LOG_N_PLUS_ONE_QUERIES is false" do
    it "doesn't load Prosopite" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "false")

      refresh_object_space!

      expect(defined?(Prosopite)).to be_nil
    end
  end

  context "when RAISE_N_PLUS_ONE_QUERIES is true" do
    it "doesn't load Prosopite" do
      set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", "true")

      refresh_object_space!

      expect(defined?(Prosopite)).to eql("constant")
    end
  end

  private

    def refresh_object_space!
      $LOADED_FEATURES.delete_if { |filename| filename.end_with?("prosopite.rb") }
      Object.send(:remove_const, :Prosopite) if defined?(Prosopite)
      load("cookpad/performance.rb")
      load("config/initializers/n_plus_one_detection.rb")
    end
end
