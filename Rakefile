require "bundler/gem_tasks"
desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems  -r ./lib/console.rb"
end

desc "Run all tests"
task :test do
  sh "rspec ./spec"
end