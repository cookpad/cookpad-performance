module TestApp
  def test_app
    @_test_app ||= Rails.application || build_test_app
  end

  def build_test_app
    Class.new(Rails::Application) do
      def self.name
        "TestApp"
      end
      config.load_defaults Rails::VERSION::STRING.to_f
    end
  end

  def set_test_app_configuration(*args)
    config_value = args.pop
    config_name = args.pop
    test_app.configure do
      receiver = if args.one?
                   config.public_send(args.first)
                 else
                   config
                 end
      receiver.public_send(:"#{config_name}=", config_value)
    end
  end
end

RSpec.configure do |config|
  config.include(TestApp)
end
