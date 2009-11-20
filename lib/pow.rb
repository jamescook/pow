module Pow
  # Override puts on include to allow coloring (but also retain existing function)
  def self.included(base)
    base.send(:define_method, :puts){ |*args| Puts.new(*args) }
  end
  CODES = {
          :clear           => 0,
          :reset           => 0, #clear
          :bold            => 1,
          :dark            => 2,
          :italic          => 3,
          :underline       => 4,
          :underscore      => 4,
          :blink           => 5,
          :rapid_blink     => 6,
          :negative        => 7,
          :concealed       => 8,
          :strikethrough   => 9,
          :black           => 30,
          :red             => 31,
          :green           => 32,
          :yellow          => 33,
          :blue            => 34,
          :magenta         => 35,
          :purple          => 35,
          :cyan            => 36,
          :white           => 37,
          :on_black        => 40,
          :on_red          => 41,
          :on_green        => 42,
          :on_yellow       => 43,
          :on_blue         => 44,
          :on_magenta      => 45, 
          :on_purple       => 45, 
          :on_cyan         => 46,
          :on_white        => 47,
          :brown           => [:yellow, :dark],
          :navy            => [:blue, :dark],
          :dark_red        => [:red, :dark],
          :dark_blue       => [:blue, :dark],
          :dark_cyan       => [:cyan, :dark],
          :dark_green      => [:green, :dark],
          :dark_magenta    => [:magenta, :dark],
          :dark_purple     => [:purple, :dark],
          :gray            => [:white, :dark],
          :grey            => [:white, :dark]
          }.freeze

  class Puts  
    attr_accessor :writer
    def initialize(*args)
      options = args[0].is_a?(String) ? {:text => args[0] } : (args[0] || {})
      CODES.keys.each do |key|
        # Color
        self.class.send(:define_method, key.to_sym)       { |*args| Puts.new({:color => key.to_sym, :text => args[0], :misc => args[1]}).out! }
        # Bold
        self.class.send(:define_method, "#{key}!".to_sym) { |*args| Puts.new({:color => key.to_sym, :text => args[0], :bold => true, :misc => args[1]}).out! }
        # Strikethrough
        self.class.send(:define_method, "#{key}_".to_sym) { |*args| Puts.new({:color => key.to_sym, :text => args[0], :strikethrough => true, :misc => args[1]}).out! }
      end     
      # FIXME make this part a method or less fug
      if options[:misc] && options[:misc].is_a?(Hash)
        options[:bold]       ||= options[:misc][:bold]
        options[:negative]   ||= options[:misc][:negative]
        options[:underline]  ||= options[:misc][:underline]
        options[:background] ||= (options[:misc][:background] || options[:misc][:on])
        options[:strikethrough]  ||= options[:misc][:strikethrough]
      end
      @writer = options[:writer] || STDOUT
      @formatted_text = format_string(options)
      out!(@formatted_text)
    end
   
    # Write the coloured text to IO
    def out!(string=nil)
      if string && string != ""
        printf(writer, string)
      end
    end

    def rainbow(*args)
      text = args[0]
      out!(text.to_s.split("").inject(""){|m, word| m+= format_string(:text => word, :bold => true, :newline => "", :color => rainbow_keys.sort_by{|k| rand}[0]) + " "  } + "\n")
    end

    # Feel the painbow
    def painbow(*args)
      text = args[0]
      out!(text.to_s.split("").inject(""){|m, word| m+= format_string(:text => word, :bold => true, :newline => "", :color => painbow_keys.sort_by{|k| rand}[0]) + " "  } + "\n")
    end

    def inspect
      nil
    end

    protected
    def painbow_keys
      [:red, :gray, :white].freeze
    end

    def rainbow_keys
      [:red, :blue, :yellow, :green, :magenta, :cyan, :dark_purple].freeze
    end

    def format_string(options={})
      newline        = options.fetch(:newline){ "\n" }
      color          = options.fetch(:color){ :white }
      text           = options.fetch(:text){ '' }
      bold           = options.fetch(:bold){ false }
      negative       = options.fetch(:negative){ false }
      italic         = options.fetch(:italic){ false }
      underline      = options.fetch(:underline){ false }
      background     = options.fetch(:background){ false }
      concealed      = options.fetch(:concealed){ false }
      strikethrough  = options.fetch(:strikethrough){ false }

      if text != ""
        result = [escape_sequence(color), text, escape_sequence(:reset), newline].join
      end

      if bold
        result.insert(0, escape_sequence(:bold))
      end

      if negative
        result.insert(0, escape_sequence(:negative))
      end

      if underline
        result.insert(0, escape_sequence(:underline))
      end

      if background
        result.insert(0, escape_sequence("on_#{background}".to_sym))
      end

      if concealed
        result.insert(0, escape_sequence(:concealed))
      end

      if strikethrough
        result.insert(0, escape_sequence(:strikethrough))
      end

      return result
    end

    def escape_sequence(code)
      if CODES[code].is_a?(Array)
        sequence = ""
        CODES[code].each do |key|
          sequence << escape_sequence(key)
        end
        return sequence
      else
        return "\e[#{CODES[code]}m"
      end
    end
  end
end

include Pow
