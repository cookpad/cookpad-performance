module Cookpad
  module Performance
    module DisableCachedQueryLogging
      CACHE_REGEXP = /\[36mCACHE\s[\w:]+\s(Load|Pluck)+/.freeze

      def add(severity, message = nil, progname = nil, &block)
        super if progname.nil? || !progname&.match?(CACHE_REGEXP)

        # :noop:
      end
    end
  end
end
