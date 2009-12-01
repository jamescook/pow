require "rake"
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "jamescook-pow"
    gemspec.version = "0.1.6"
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
  Dir[ File.join(File.dirname(File.expand_path(__FILE__)), "test", "**") ].each do |test_file|
    ruby test_file
  end
end


