ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap'
env = ENV['RAILS_ENV'] || 'development'
circle_off = ENV['CIRCLECI'].nil?
Bootsnap.setup(
  cache_dir: 'tmp/cache',
  development_mode: env == 'development',
  load_path_cache: circle_off,
  autoload_paths_cache: circle_off,
  disable_trace: true,
  compile_cache_iseq: true,
  compile_cache_yaml: true
)
