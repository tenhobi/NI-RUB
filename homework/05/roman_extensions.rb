# frozen_string_literal: true

module RomanExtensions
  module Numeric
    def /(other)
      return Roman.new(self / other.value) if other.is_a? Roman

      super
    end
  end

  module Integer
    def roman
      Roman.arabic_to_roman(Roman.new(self).to_i)
    end

    def to_roman
      Roman.new(self)
    end
  end

  module String
    def number
      Roman.roman_to_arabic(self)
    end

    def to_roman
      Roman.new(Roman.roman_to_arabic(self))
    end
  end
end

Float.prepend RomanExtensions::Numeric
Integer.prepend RomanExtensions::Numeric, RomanExtensions::Integer
String.prepend RomanExtensions::String
