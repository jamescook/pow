require 'yaml'
require 'fileutils'

module Pow

  class Profile
    attr_accessor :profile_path, :settings, :name
    attr_reader   :yaml

    def initialize(profile_path=:default)
      @profile_path = (profile_path == :default) ? File.expand_path("~/pow_defaults") : profile_path
      @settings     = read rescue {}
      @name         = "Default"
    end

    def write
      FileUtils.mkdir_p( File.dirname(profile_path) )
      File.open( profile_path, 'wb'){|f| YAML.dump( settings, f ) }
    end
    alias_method :save, :write

    def read
      @yaml = YAML.load_file( profile_path )
    end

    def settings=(val)
      @settings = {:name => name, :settings => val}
    end

    def inspect
      "<Pow::Profile '#{name}'>"
    end

    def preview
      opts = {:text => "Hello world!"}.merge( settings )
      Puts.new( opts ).out!
    end
  end
end
