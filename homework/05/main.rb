# frozen_string_literal: true

require_relative 'roman'

def test
  roman = Roman.new(4) # => 4
  roman2 = Roman.new('XII') # => 12

  raise 'x-1' unless Roman.new(roman) == 4
  raise 'x-2' unless Roman.new(roman).is_a? Roman
  raise 'x-3' unless Roman.new(roman2) == 12
  raise 'x-4' unless Roman.new(roman2).is_a? Roman

  raise '0-1' unless roman.to_i == 4
  raise '0-2' unless roman2.to_int == 12

  raise '1-1' unless roman == 4
  raise '1-2' unless roman != 5
  raise '1-3' unless !(roman > roman2)
  raise '1-4' unless roman < roman2

  raise '2-1' unless roman + 1 == 5
  raise '2-2' unless 1 + roman == 5

  raise '3-1' unless roman * 2 == 8
  raise '3-2' unless 2 * roman == 8
  raise '3-3' unless roman / 2 == 2
  raise '3-4' unless roman2 / 4 == 3
  raise '3-5' unless 16 / roman == 4
  raise '3-6' unless 16 - roman == 12
  raise '3-7' unless roman - 2 == 2

  raise '4-1' unless [roman, roman2].min == roman
  raise '4-2' unless [roman, roman2].max == roman2
  raise '4-3' unless (roman..roman2).min == roman
  raise '4-4' unless (roman..roman2).max == roman2

  raise '5' unless (1..100).first(roman) == [1, 2, 3, 4]

  raise '6' unless [Roman.new(1), Roman.new(3), Roman.new(9), 1].sum == 14

  raise '7' unless (Roman.new(1)..Roman.new(5)).to_a == [1, 2, 3, 4, 5]

  raise '8-1' unless roman.to_s == 'IV'
  raise '8-2' unless roman2.to_s == 'XII'

  raise '9-1' unless 6.roman == 'VI'
  raise '9-2' unless 'IV'.number == 4

  raise '10-1' unless 6.to_roman.is_a? Roman
  raise '10-2' unless 'V'.to_roman.is_a? Roman

  raise '11-1' unless 11.1.to_roman == 11
  raise '11-2' unless 11.9.to_roman == 11
  raise '11-3' unless 11.to_roman == 11
end

test
