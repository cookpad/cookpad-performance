require "spec_helper"
require "active_support/logger"
require "active_support/railtie"
require "active_record/railtie"
require "active_record/query_counter"

RSpec.describe "ActiveRecord::QueryCounter", :database do
  before do
    subscribe!
  end

  after do
    unsubscribe!
    reset!
  end

  it "logs the number of unique queries" do
    load_schema!
    test_model.cache do
      test_model.first
      test_model.first
    end
    logged_output = ActiveRecord::QueryCounter.current.report_counts

    expect(logged_output).to include("Unique: 1")
  end

  it "logs the number of cached queries" do
    load_schema!
    test_model.cache do
      test_model.first
      test_model.first
    end
    logged_output = ActiveRecord::QueryCounter.current.report_counts

    expect(logged_output).to include("Cached: 1")
  end

  it "logs the number of async queries" do
    skip "Don't know how to get async working in test"
    load_schema!
    test_model.create
    test_model.all.load_async
    logged_output = ActiveRecord::QueryCounter.current.report_counts

    expect(logged_output).to include("Async: 1")
  end

  it "logs the total number of queries" do
    load_schema!
    test_model.cache do
      test_model.first
      test_model.first
    end
    test_model.all.load_async
    logged_output = ActiveRecord::QueryCounter.current.report_counts

    expect(logged_output).to include("Total: 3")
  end

  private

    def counter
      ActiveRecord::QueryCounter.current
    end

    def unsubscribe!
      ActiveSupport::Notifications.unsubscribe(subscriber)
    end

    def subscriber
      @_subscriber ||= ActiveSupport::Notifications.subscribe(/sql/, counter)
    end

    def reset!
      counter.reset_counter
    end

    alias_method :subscribe!, :subscriber
end