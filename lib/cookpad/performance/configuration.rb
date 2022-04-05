module Cookpad
  module Performance
    class Configuration
      def self.attr_with_predicate(*names)
        Array(names).each do |name|
          attr_accessor name
          alias_method :"#{name}?", name
        end
      end

      attr_with_predicate :log_n_plus_one_queries
      attr_with_predicate :raise_n_plus_one_queries
      attr_with_predicate :profile
      attr_with_predicate :log_db_query_count
      attr_with_predicate :disable_cached_query_logging
      attr_with_predicate :rack_mini_profiler

      def initialize
        @log_n_plus_one_queries = env_val("LOG_N_PLUS_ONE_QUERIES")
        @raise_n_plus_one_queries = env_val("RAISE_N_PLUS_ONE_QUERIES")
        @profile = env_val("PROFILE")
        @log_db_query_count = env_val("LOG_DB_QUERY_COUNT")
        @disable_cached_query_logging = env_val("DISABLE_CACHED_QUERY_LOGGING")
        @rack_mini_profiler = env_val("RACK_MINI_PROFILER")
      end

      private

        def env_val(name, default: false)
          ENV[name] == "true" || default
        end
    end
  end
end
