require 'rubocop/rake_task'
require 'foodcritic'
require 'bundler/audit/task'

task :build do
  RuboCop::RakeTask.new
  FoodCritic::Rake::LintTask.new
  Bundler::Audit::Task.new

  Rake::Task['rubocop'].invoke
  Rake::Task['foodcritic'].invoke
  Rake::Task['bundle:audit'].invoke
end
