require "bundler/setup"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

task default: :spec

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"
