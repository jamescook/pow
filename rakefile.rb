begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "jamescook-pow"
    gemspec.version = "0.1.0"
    gemspec.summary = "puts with colors"
    gemspec.description = "'puts' with shell colors."
    gemspec.email = "jamecook@gmail.com"
    gemspec.homepage = "http://github.com/jamescook/pow"
    gemspec.authors = ["James Cook"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
