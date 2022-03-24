# frozen_string_literal: true
module TestDatabase
  LOG_FILENAME = "./log/test.log"

  def load_schema!
    configure_active_record
    ActiveRecord::Base.connection.instance_eval do
      create_table(:foobars, force: true) do |t|
        t.string :name
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
      ActiveRecord::Base.logger = ActiveSupport::Logger.new(LOG_FILENAME)
      ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
    end
end

RSpec.configure do |config|
  config.include(TestDatabase, database: true)
end
