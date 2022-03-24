require "spec_helper"
require "active_record/railtie"
require "cookpad/performance/disable_cached_query_logging"

RSpec.describe Cookpad::Performance::DisableCachedQueryLogging, :database do
  before do
    load_schema!
    store_current_logger
    test_logger_class.prepend(Cookpad::Performance::DisableCachedQueryLogging)
    ActiveRecord::Base.logger = test_logger_class.new(stub_io)
  end

  after do
    ActiveRecord::Base.logger = old_logger
  end

  it "isn't include in ActiveSupport::Logger by default" do
    expect(ActiveSupport::Logger.included_modules).not_to include(Cookpad::Performance::DisableCachedQueryLogging)
  end

  it "filters out cached Load queries" do
    test_model.cache do
      test_model.find_by(id: 1)
      test_model.find_by(id: 1)
    end

    expect(stub_io.tap(&:rewind).each_line.count).to eql(1)
    expect(stub_io.tap(&:rewind).read).not_to include("CACHE")
  end

  it "filters out cached Pluck queries" do
    test_model.cache do
      test_model.pluck(:id)
      test_model.pluck(:id)
    end

    expect(stub_io.tap(&:rewind).each_line.count).to eql(1)
    expect(stub_io.tap(&:rewind).read).not_to include("CACHE")
  end

  it "doesn't filter non-cached queries" do
    test_model.cache do
      test_model.count
      test_model.count
    end

    expect(stub_io.tap(&:rewind).each_line.count).to eql(2)
  end

  it "doesn't filter out other queries with the term CACHE" do
    test_model.find_by(name: "Name with CACHE in it")

    expect(stub_io.tap(&:rewind).each_line.count).to eql(1)
    expect(stub_io.tap(&:rewind).read).to include("CACHE")
  end

  private

    def test_logger_class
      @_test_logger_class ||= ActiveSupport::Logger.dup
    end

    def old_logger
      @_old_logger ||= ActiveRecord::Base.logger
    end
    alias_method :store_current_logger, :old_logger

    def stub_io
      @_stub_io ||= StringIO.new
    end
end