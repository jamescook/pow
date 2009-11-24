require "rake"
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "jamescook-pow"
    gemspec.version = "0.1.4"
    gemspec.summary = "puts with colors"
    gemspec.description = "Ruby 'puts' with shell colors."
    gemspec.email = "jamecook@gmail.com"
    gemspec.homepage = "http://github.com/jamescook/pow"
    gemspec.authors = ["James Cook"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

task :default => [:test]

desc "Run tests"
task :test do |t|
  ruby "test/pow_test.rb"
end


