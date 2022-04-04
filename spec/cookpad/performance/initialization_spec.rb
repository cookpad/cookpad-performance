require "spec_helper"

RSpec.describe "Cookpad::Performance::Initialization" do
  before do
    set_environment_variable("LOG_N_PLUS_ONE_QUERIES", nil)
    set_environment_variable("PROFILE", nil)
    set_environment_variable("RAISE_N_PLUS_ONE_QUERIES", nil)
    set_environment_variable("RACK_MINI_PROFILER", nil)
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

  context "when LOG_N_PLUS_ONE_QUERIES is false" do
    it "doesn't load Prosopite" do
      set_environment_variable("LOG_N_PLUS_ONE_QUERIES", "false")

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

  context "when RACK_MINI_PROFILER and PROFILE are both true" do
    it "raises an exception" do
      set_environment_variable("RACK_MINI_PROFILER", "true")
      set_environment_variable("PROFILE", "true")

      refresh_object_space!

      expect do
        load("config/initializers/rack_mini_profiler.rb")
      end.to raise_error(StandardError)
    end
  end

  context "when RACK_MINI_PROFILER is true" do
    it "loads rack mini profiler" do
      set_environment_variable("RACK_MINI_PROFILER", "true")
      build_test_app
      refresh_object_space!

      load("config/initializers/rack_mini_profiler.rb")

      rmp = $LOADED_FEATURES.find do |file|
        file.end_with?("rack-mini-profiler.rb")
      end
      expect(rmp).to be_present
      expect(defined?(Rack::MiniProfiler)).to eql("constant")
    end
  end

  context "when RACK_MINI_PROFILER is false" do
    it "doesn't load rack mini profiler" do
      skip "Don't know how to test this in complete isolation?"
      set_environment_variable("RACK_MINI_PROFILER", "false")
      build_test_app
      refresh_object_space!

      load("config/initializers/rack_mini_profiler.rb")

      rmp = $LOADED_FEATURES.find do |file|
        file.end_with?("rack-mini-profiler.rb")
      end
      expect(rmp).to be_nil
      expect(defined?(Rack::MiniProfiler)).to be_nil
    end
  end

  private

    def unload_prosopite
      $LOADED_FEATURES.delete_if { |filename| filename.end_with?("prosopite.rb") }
      Object.send(:remove_const, :Prosopite) if defined?(Prosopite)
    end

    # def unload_rack_mini_profiler
    #   $LOADED_FEATURES.delete_if { |filename| filename.include?("rack-mini") }
    #   Rack.send(:remove_const, :MiniProfiler) if defined?(Rack::MiniProfiler)
    #   Rack.send(:remove_const, :MiniProfilerRails) if defined?(Rack::MiniProfilerRails)
    #   Rack.send(:remove_const, :MiniProfilerRailsMethods) if defined?(Rack::MiniProfilerRailsMethods)
    # end

    def refresh_object_space!
      unload_prosopite
      # unload_rack_mini_profiler
      load("cookpad/performance.rb")
    end
end
