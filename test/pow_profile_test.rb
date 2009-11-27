require 'test/unit'
require "stringio"
require File.join( File.dirname(__FILE__), "..", "pow")

class PowProfileTest < Test::Unit::TestCase
  include Pow
  def setup
    @puts = Pow::Puts
    @writer = StringIO.new
    @temp_defaults_path = File.join(File.dirname(__FILE__), 'DEFAULTS')
    @settings = {:bold => true, :color => :purple}
    Pow.enable
  end

  def teardown
    File.unlink( @temp_defaults_path ) if File.exists?(@temp_defaults_path)
  end

  def test_pow_new_profile_exists_on_save
    profile = Pow::Profile.new( @temp_defaults_path )
    profile.settings = @settings
    profile.save
    assert_equal true, File.exists?( @temp_defaults_path )
  end

  def test_pow_loads_profile
    profile = Pow::Profile.new( @temp_defaults_path )
    profile.settings = @settings
    profile.save
    Pow.load_profile( @temp_defaults_path )
    assert_equal @settings, Pow.defaults
  end
end
