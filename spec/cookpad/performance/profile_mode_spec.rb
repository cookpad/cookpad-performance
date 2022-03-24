require "spec_helper"
require "active_support/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "uglifier"

RSpec.describe "Profile mode" do
  context "when ENV variable PROFILE is 'true'" do
    before do
      set_environment_variable("RAILS_ENV", "development")
      set_environment_variable("PROFILE", "true")
    end

    it "sets cache_classes to true" do
      set_test_app_configuration(:cache_classes, false)

      expect { load_initializer! }.to change {
        test_app.config.cache_classes
      }.from(false).to(true)
    end

    it "sets eager_load to true" do
      set_test_app_configuration(:eager_load, false)

      expect { load_initializer! }.to change {
        test_app.config.eager_load
      }.from(false).to(true)
    end

    it "sets log_level to :info" do
      set_test_app_configuration(:log_level, :debug)

      expect { load_initializer! }.to change {
        test_app.config.log_level
      }.from(:debug).to(:info)
    end

    it "sets active_record.verbose_query_logs to false" do
      set_test_app_configuration(:active_record, :verbose_query_logs, true)

      expect { load_initializer! }.to change {
        test_app.config.active_record.verbose_query_logs
      }.from(true).to(false)
    end

    it "sets active_record.migration_error to false" do
      set_test_app_configuration(:active_record, :migration_error, true)

      expect { load_initializer! }.to change {
        test_app.config.active_record.migration_error
      }.from(true).to(false)
    end

    it "sets public_file_server.enabled to true" do
      set_test_app_configuration(:public_file_server, :enabled, false)

      expect { load_initializer! }.to change {
        test_app.config.public_file_server.enabled
      }.from(false).to(true)
    end

    it "sets public_file_server.headers to Hash of values" do
      set_test_app_configuration(:public_file_server, :headers, {})

      expect { load_initializer! }.to change {
        test_app.config.public_file_server.headers
      }.from({}).to({
        "Cache-Control" => "max-age=315360000, public",
        "Expires" => "Tue, 31 Dec 2030 23:55:55 GMT"
      })
    end

    it "sets assets.js_compressor to Uglifier.new(harmony: true)" do
      set_test_app_configuration(:assets, :js_compressor, nil)

      expect { load_initializer! }.to change {
        test_app.config.assets.js_compressor
      }.from(nil)
      expect(test_app.config.assets.js_compressor).to be_a(Uglifier)
    end

    it "sets assets.compile to false" do
      set_test_app_configuration(:assets, :compile, true)

      expect { load_initializer! }.to change {
        test_app.config.assets.compile
      }.from(true).to(false)
    end

    it "sets assets.debug to false" do
      set_test_app_configuration(:assets, :debug, true)

      expect { load_initializer! }.to change {
        test_app.config.assets.debug
      }.from(true).to(false)
    end

    it "sets assets.digest to true" do
      set_test_app_configuration(:assets, :digest, false)

      expect { load_initializer! }.to change {
        test_app.config.assets.digest
      }.from(false).to(true)
    end

    it "sets action_controller.perform_caching to true" do
      set_test_app_configuration(:action_controller, :perform_caching, false)

      expect { load_initializer! }.to change {
        test_app.config.action_controller.perform_caching
      }.from(false).to(true)
    end

    it "sets action_mailer.perform_caching to true" do
      set_test_app_configuration(:action_mailer, :perform_caching, false)

      expect { load_initializer! }.to change {
        test_app.config.action_mailer.perform_caching
      }.from(false).to(true)
    end

    it "sets action_controller.enable_fragment_cache_logging to true" do
      set_test_app_configuration(:action_controller, :enable_fragment_cache_logging, false)

      expect { load_initializer! }.to change {
        test_app.config.action_controller.enable_fragment_cache_logging
      }.from(false).to(true)
    end

    it "sets action_view.cache_template_loading to true" do
      set_test_app_configuration(:action_view, :cache_template_loading, false)

      expect { load_initializer! }.to change {
        test_app.config.action_view.cache_template_loading
      }.from(false).to(true)
    end

    it "sets action_view.annotate_rendered_view_with_filenames to false" do
      set_test_app_configuration(:action_view, :annotate_rendered_view_with_filenames, true)

      expect { load_initializer! }.to change {
        test_app.config.action_view.annotate_rendered_view_with_filenames
      }.from(true).to(false)
    end

    it "sets log_tags to [:request_id]" do
      set_test_app_configuration(:log_tags, [])

      expect { load_initializer! }.to change {
        test_app.config.log_tags
      }.from([]).to([:request_id])
    end
  end

  private

    def load_initializer!
      load("config/initializers/profile_mode.rb")
    end
end
