# frozen_string_literal: true

require "active_record"

# rubocop:disable Rails/ApplicationRecord
module TestDatabase
  def establish_connection
    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
  end

  def load_schema!
    configure_active_record
    ActiveRecord::Base.connection.instance_eval do
      create_table(:foobars, force: true) do |t|
        t.string :name
        t.string :user_id
        t.timestamps
      end
    end
  end

  def test_model
    Class.new(ActiveRecord::Base) do
      self.table_name = "foobars"
      def self.name
        "FooBar"
      end
    end
  end

  private

    def configure_active_record
      FileUtils.mkdir("./log") unless Dir.exist?("./log")
      ActiveRecord::Base.logger = ActiveSupport::Logger.new("./log/test.log")
      establish_connection
    end
end
# rubocop:enable Rails/ApplicationRecord

RSpec.configure do |config|
  config.include(TestDatabase, database: true)
  config.before(:all, database: true) do
    establish_connection
  end
end
