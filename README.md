# Cookpad::Performance

Adds a selection of tools to make performance troubleshooting and profiling easier in development.

## Philosophy

This gem should provide a set of plug-and-play performance monitoring and troubleshooting tools for use in development and test environments.

Each tool should sit behind a feature toggle, and should be explicitly enabled through the use of environment variables.

The gem should not make any changes to the functioning and performance of the application unless a specific feature has explicitly been enabled. This helps us to provide helpful tools that will stay out of your way unless your require them.

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

See [the initializer file](config/initializers/active_record_query_counter.rb) for more information.

### Disable cached query logging

Silence cached ActiveRecord database queries from the Rails application log. Makes it easier to see which unique queries are being executed in the database.

Activate by setting an environment variable called `DISABLE_CACHED_QUERY_LOGGING=true`.

See [the initializer file](config/initializers/disable_cached_query_logging.rb) for more information.

### n+1 detection in Rails logs

Receive warnings in the Rails application logs when an n+1 query is detected.

Activate by setting an environment variable called `LOG_N_PLUS_ONE_QUERIES=true`.

See [the initializer file](config/initializers/n_plus_one_detection.rb) for more information.

### Profile mode

Run your Rails application in a production-like configuration of the development environment.

Activate by setting an environment variable called `PROFILE=true`.

See [the initializer file](config/initializers/profile_mode.rb) for more information.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
