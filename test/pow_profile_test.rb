require 'test/unit'
require "stringio"
require File.join( File.dirname(__FILE__), "..", "pow")

class PowProfileTest < Test::Unit::TestCase
  include Pow
  def setup
    @puts = Pow::Puts
    @writer = StringIO.new
    @temp_defaults_path = File.join(File.dirname(__FILE__), 'DEFAULTS')
    @settings = {:bold => false, :color => :purple}
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
    profile.settings = {:color => :red, :bold => false}
    profile.save
    Pow.load_profile( @temp_defaults_path )
    assert_equal profile.settings[:settings], Pow.defaults
  end
  
  def test_pow_inspect
    assert_equal "<Pow::Profile 'Default'>", Pow.profile.inspect
  end

  def test_pow_preview
    assert_equal "\e[31mHello world!\e[0m\n\e[0m", Pow.profile.preview # Basic .. white
  end
end
