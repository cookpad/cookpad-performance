if ENV["LOG_DB_QUERY_COUNT"] == "true"
  require "active_record/query_counter"
  ActiveSupport::Notifications.subscribe(/sql/, ActiveRecord::QueryCounter.current)
  ActionController::Base.class_eval do
    around_action :report_active_record_queries_count

    private

      def report_active_record_queries_count
        ActiveRecord::QueryCounter.current.reset_counter
        yield
        logger.info(ActiveRecord::QueryCounter.current.report_counts)
      end
  end
end
