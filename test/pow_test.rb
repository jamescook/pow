require 'test/unit'
require "stringio"
require File.join( File.dirname(__FILE__), "..", "pow")

class PowTest < Test::Unit::TestCase
  include Pow
  def setup
    @puts = Pow::Puts
    @writer = StringIO.new
  end

  def test_puts
    @puts.new(:text => "TEST", :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[37mTEST\e[0m\n", @writer.gets  # White text
  end

  def test_puts_with_red
    @puts.new(:text => "TEST", :color => :red, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[31mTEST\e[0m\n", @writer.gets
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

  def test_puts_with_strikethrough
    @puts.new(:text => "TEST", :strikethrough => :true, :writer => @writer).out!
    @writer.rewind
    assert_equal "\e[9m\e[37mTEST\e[0m\n", @writer.gets
  end
end
