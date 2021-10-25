require_relative 'roman_extensions'

class Roman
  include Comparable

  def initialize(number)
    case number
    when Numeric
      @number = number.to_i
    when String
      @number = self.class.roman_to_arabic(number)
    else
      raise ArgumentError, 'Not a valid arabic or roman number'
    end

    self.class.check_limit(@number)
  end

  def coerce(other)
    case other
    when Numeric
      [self, other]
    else
      raise TypeError, "#{self.class} can't be coerced into #{other.class}"
    end
  end

  def value
    @number
  end

  def <=>(other)
    case other
    when Roman
      value <=> other.value
    when Numeric
      value <=> other
    else
      raise TypeError, 'Dunno what to do'
    end
  end

  def succ
    self.class.new(value + 1)
  end

  def +(other)
    case other
    when Roman
      self.class.new(value + other.value)
    when Numeric
      self.class.new(value + other)
    else
      raise TypeError, 'Dunno what to do'
    end
  end

  def *(other)
    case other
    when Roman
      self.class.new(value * other.value)
    when Numeric
      self.class.new(value * other)
    else
      raise TypeError, 'Dunno what to do'
    end
  end

  def /(other)
    case other
    when Roman
      raise ArgumentError, 'Cannot divide by zero' if other.value.zero?

      self.class.new(value / other.value)
    when Numeric
      raise ArgumentError, 'Cannot divide by zero' if other.zero?

      self.class.new(value / other)
    else
      raise TypeError, 'Dunno what to do'
    end
  end

  def to_i
    value.to_i
  end
  alias to_int to_i

  def to_s
    self.class.arabic_to_roman(value)
  end

  class << self
    ROMAN_ARABIC_TRANSFORMATION = {
      'M' => 1000,
      'CM' => 900,
      'D' => 500,
      'CD' => 400,
      'C' => 100,
      'XC' => 90,
      'L' => 50,
      'XL' => 40,
      'X' => 10,
      'IX' => 9,
      'V' => 5,
      'IV' => 4,
      'I' => 1
    }.freeze

    ROMAN_CHECK_ORDER = %w[CM M CD D XC C XL L IX X IV V I].freeze

    def roman_to_arabic(roman)
      raise ArgumentError, 'Argument is not a string', self unless roman.is_a? String

      sum = 0
      max_index_in_hash = -1
      ROMAN_CHECK_ORDER.each do |letter|
        letter_value = ROMAN_ARABIC_TRANSFORMATION[letter]

        roman = roman.gsub(letter).with_index do |capture, i|
          index_in_hash = ROMAN_ARABIC_TRANSFORMATION.find_index { |k, _| k == letter }
          capture_index = roman.index(capture)

          if max_index_in_hash > index_in_hash || capture_index != 0
            raise ArgumentError, 'Invalid roman number ordering'
          end

          if max_index_in_hash == index_in_hash
            raise ArgumentError, 'Repeating of roman letter overflow' if letter.size == 1 && i > 2
            raise ArgumentError, 'No repeating for double-size letters' if letter.size > 1
          end

          sum += letter_value
          max_index_in_hash = index_in_hash
          ''
        end
      end

      raise ArgumentError, 'Invalid roman number' unless roman.empty?

      sum
    end

    def arabic_to_roman(number)
      roman_builder = ''
      ROMAN_ARABIC_TRANSFORMATION.each do |pair|
        letter = pair[0]
        letter_value = pair[1]

        while number >= letter_value
          roman_builder += letter
          number -= letter_value
        end
      end
      roman_builder
    end

    def check_limit(number)
      raise RangeError, "Number #{number} is out of range" if (number <= 0) || (number > 4000)
    end
  end
end
