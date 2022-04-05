require "rails"
require "cookpad/performance/version"
require "cookpad/performance/engine"
require "cookpad/performance/configuration"

module Cookpad
  module Performance
    class << self
      def method_missing(method_name, ...)
        if configuration.respond_to?(method_name)
          configuration.public_send(method_name, ...)
        else
          super
        end
      end

      def respond_to_missing?(method_name, inclue_private = false)
        configuration.respond_to?(method_name) || super
      end

      def reset_configuration!
        remove_instance_variable(:@_configuration) if defined?(@_configuration)
      end

      private

        def configuration
          @_configuration ||= Configuration.new
        end
    end
  end
end

if Cookpad::Performance.log_n_plus_one_queries? || Cookpad::Performance.raise_n_plus_one_queries?
  require "prosopite"
end
