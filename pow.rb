Dir["lib/pow/**"].each do |file|
  require File.expand_path( file )
end

require "lib/pow.rb"
