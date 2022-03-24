# Cookpad::Performance

Adds a selection of tools to make performance troubleshooting and profiling easier in development.

## Installation

Add this line to your application's Gemfile:

```ruby
group :development, :test do
  gem "cookpad-performance"
end
```

And then execute:
```bash
$ bundle
```

## Included tools

### ActiveRecord query counter

Log the total number of unique queries, cached queries, and async queries at the foot of each request in the Rails application log.

Activate by setting an environment variable called `LOG_DB_QUERY_COUNT=true`.

See [the initializer file](/blob/main/config/initializers/active_record_query_counter.rb) for more information.

### Disable cached query logging

Silence cached ActiveRecord database queries from the Rails application log. Makes it easier to see which unique queries are being executed in the database.

Activate by setting an environment variable called `DISABLE_CACHED_QUERY_LOGGING=true`.

See [the initializer file](/blob/main/config/initializers/disable_cached_query_logging.rb) for more information.

### n+1 detection in Rails logs

Receive warnings in the Rails application logs when an n+1 query is detected.

Activate by setting an environment variable called `LOG_N_PLUS_ONE_QUERIES=true`.

See [the initializer file](/blob/main/config/initializers/n_plus_one_detection.rb) for more information.

### Profile mode

Run your Rails application in a production-like configuration of the development environment.

Activate by setting an environment variable called `PROFILE=true`.

See [the initializer file](/blob/main/config/initializers/profile_mode.rb) for more information.

### Rack Mini Profiler

Includes the [rack-mini-profiler](https://github.com/MiniProfiler/rack-mini-profiler) gem.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
