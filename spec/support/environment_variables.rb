module EnvironmentVariableGettersAndSetters
  private
    def set_environment_variable(name, value)
      ENV[name] = value
    end
end

RSpec.configure do |spec|
  spec.include(EnvironmentVariableGettersAndSetters)
end
