# frozen_string_literal: true

#
# Available Rake tasks:
#
# $ rake -T
# rake integration:docker[regexp,action]   # Run tests with kitchen-docker
# rake integration:vagrant[regexp,action]  # Run tests with kitchen-vagrant
#
# More info at https://github.com/ruby/rake/blob/master/doc/rakefile.rdoc
#

require 'rubocop/rake_task'
require 'foodcritic'
require 'bundler/audit/task'
require 'bundler/setup'

task :build do
  RuboCop::RakeTask.new
  FoodCritic::Rake::LintTask.new
  Bundler::Audit::Task.new

  Rake::Task['rubocop'].invoke
  Rake::Task['foodcritic'].invoke
  Rake::Task['bundle:audit'].invoke
end

desc 'Run Test Kitchen integration tests'
namespace :integration do
  desc 'Run integration tests with kitchen-vagrant'
  task :vagrant do
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each { |instance| instance.test(:always) }
  end

  desc 'Run integration tests with kitchen-docker'
  task :docker, [:instance] do |_t, args|
    args.with_defaults(instance: 'default-ubuntu-1404')
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    loader = Kitchen::Loader::YAML.new(local_config: '.kitchen.docker.yml')
    instances = Kitchen::Config.new(loader: loader).instances
    # Travis CI Docker service does not support destroy:
    instances.get(args.instance).verify
  end
end

task default: %w[integration:vagrant]
