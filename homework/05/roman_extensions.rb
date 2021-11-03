# frozen_string_literal: true

module RomanExtensions
  module Numeric
    def roman
      Roman.arabic_to_roman(Roman.new(self))
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

Numeric.prepend RomanExtensions::Numeric
String.prepend RomanExtensions::String
