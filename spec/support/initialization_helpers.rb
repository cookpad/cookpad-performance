module InitializationHelpers

  private

    def unload_prosopite
      $LOADED_FEATURES.delete_if { |filename| filename.end_with?("prosopite.rb") }
      Object.send(:remove_const, :Prosopite) if defined?(Prosopite)
    end
end

RSpec.configure do |config|
  config.include(InitializationHelpers, initialization_helpers: true)
end
