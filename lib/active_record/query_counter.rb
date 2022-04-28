module ActiveRecord
  require "active_support/subscriber"
  class QueryCounter < ActiveSupport::Subscriber
    PAYLOAD_QUERY_TYPE_KEYS = %i(cached async).freeze
    private_constant :PAYLOAD_QUERY_TYPE_KEYS

    LOG_TEMPLATE = <<~STRING.chomp.freeze
      DB query summary: \
      Unique: %{unique} | \
      Async: %{async} | \
      Cached: %{cached} | \
      Total: %{total}
    STRING
    private_constant :LOG_TEMPLATE

    INGORED_QUERY_PREFIXES = [
      "BEGIN",
      "COMMIT",
      "CREATE TABLE",
      "DROP TABLE",
      "PRAGMA",
      "SELECT column_name",
      "SELECT sqlite_version(*)",
      "SELECT name FROM sqlite_master",
      "SELECT sql FROM",
      "SELECT table_name",
      "SELECT `schema_migrations`.`version`",
      "SET  @@SESSION.sql_mode",
      "SET NAME",
      "SHOW FULL FIELDS"
    ].freeze
    private_constant :INGORED_QUERY_PREFIXES

    def self.current
      @_current ||= new
    end

    def sql(event)
      return if INGORED_QUERY_PREFIXES.detect { |s| event.payload[:sql].start_with?(s) }

      increment_counter(type: type_of_event(event))
    end

    def reset_counter
      counter.transform_values! { 0 }
    end

    def report_counts
      LOG_TEMPLATE % counter.merge({ total: counter.values.sum })
    end

    private
    
      def counter
        @_counter ||= Hash.new { |hash, key| hash[key] = 0 }
      end

      def increment_counter(type:)
        counter[type] += 1
      end

      def type_of_event(event)
        PAYLOAD_QUERY_TYPE_KEYS.detect { |key| event.payload[key] } || :unique
      end
  end
end
