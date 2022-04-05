require "spec_helper"
require "action_controller"
require "action_view"
require "active_record"
require "rspec/rails"

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.before do
    build_test_app
  end
end
