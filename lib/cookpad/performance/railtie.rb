module Cookpad
  module Performance
    class Railtie < ::Rails::Railtie
      DEFAULTS_IVAR_NAME = "@defaults".freeze
      private_constant :DEFAULTS_IVAR_NAME

      config.after_initialize do
        if ENV["PROFILE"] && Rails.env.development? && defined?(Webpacker)
          default_config = Webpacker.config.instance_variable_get(DEFAULTS_IVAR_NAME)
          default_config["compile"] = false
          Webpacker.config.instance_variable_set(DEFAULTS_IVAR_NAME, default_config)
        end
      end
    end
  end
end
