require 'test/unit'
require "stringio"
require File.join( File.dirname(__FILE__), "..", "pow")

class PowTest < Test::Unit::TestCase
  include Pow
  def setup
    @puts = Pow::Puts
    @writer = StringIO.new
    Pow.enable
    Pow.unload_profile  # Prevents users profile from messing up test output
  end

  def test_pow_enable
    Pow.disable
    Pow.enable
    assert_equal true, Pow.enabled?
  end

  def test_pow_disabled
    Pow.enable
    Pow.disable
    assert_equal true, Pow.disabled?
  end

  def test_puts_strips_formatting_when_pow_disabled
    Pow.disable
    @puts.new(:text => "TEST", :bold => true, :writer => @writer).out!
    @writer.rewind
    assert_equal "TEST\n", @writer.gets
  end

  def test_puts
    @puts.new(:text => "TEST", :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[37mTEST\e[0m\n", @writer.gets  # White text
  end

  def test_inspect
    @puts = Pow::Puts.new(:text => "TEST", :writer => @writer)
    @writer.rewind
    assert_equal "\e[37mTEST\e[0m\n\e[0m", @puts.inspect
  end

  # :misc is kind of strange .. Something to do with those dynamic methods added at runtime
  def test_puts_with_misc_options  
    @puts.new(:text => "TEST", :misc => {:bold => true, :underline => true}, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[4m\e[1m\e[37mTEST\e[0m\n", @writer.gets 
  end

  def test_puts_with_bold_default
    Pow.defaults = {:bold => true}
    @puts.new(:text => "TEST", :writer => @writer).out!
    @writer.rewind
    Pow.defaults = {:bold => false}
    assert_equal "\e[1m\e[37mTEST\e[0m\n", @writer.gets
  end

  def test_puts_with_non_string
    @puts.new(:text => 1, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[37m1\e[0m\n", @writer.gets 
  end

  def test_puts_with_match
    @puts.new(:text => "TEST", :match => 'E', :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[37mT\e[31mE\e[37mST\e[0m\n", @writer.gets
  end

  def test_puts_with_red
    @puts.new(:text => "TEST", :color => :red, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[31mTEST\e[0m\n", @writer.gets
  end

  def test_puts_with_red_on_background
    @puts.new(:text => "TEST", :color => :red, :background => :purple, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[45m\e[31mTEST\e[0m\n", @writer.gets #45 purple background, 35 red
  end

  def test_puts_with_dark_color  #brown =  yellow + dark
    @puts.new(:text => "TEST", :color => :brown, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[33m\e[2mTEST\e[0m\n", @writer.gets
  end

  def test_puts_with_bold
    @puts.new(:text => "TEST", :color => :bold, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[1mTEST\e[0m\n", @writer.gets
  end

  def test_puts_with_underscore
    @puts.new(:text => "TEST", :underscore => :true, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[4m\e[37mTEST\e[0m\n", @writer.gets
  end

  def test_puts_with_strikethrough
    @puts.new(:text => "TEST", :strikethrough => :true, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[9m\e[37mTEST\e[0m\n", @writer.gets
  end

  def test_puts_with_negative
    @puts.new(:text => "TEST", :negative => :true, :color => :blue, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[7m\e[34mTEST\e[0m\n", @writer.gets
  end

  def test_puts_painbow
    pretty = Pow::Puts.new(:writer => @writer)
    result = pretty.painbow("TEST")
    assert_match(/\e(.*)/, result) #TODO not a good test .. but these are silly methods anyway
  end

  def test_puts_rainbow
    pretty = Pow::Puts.new(:writer => @writer)
    result = pretty.rainbow("TEST")
    assert_match(/\e(.*)/, result)
  end

  def test_puts_concealed
    @puts.new(:text => "TEST", :concealed => :true, :color => :blue, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[8m\e[34mTEST\e[0m\n", @writer.gets
  end

  def test_rainbow_keys
    assert_equal true, Pow::Puts.new.send(:rainbow_keys).is_a?(Array)
  end

  def test_painbow_keys
    assert_equal true, Pow::Puts.new.send(:painbow_keys).is_a?(Array)
  end
end
