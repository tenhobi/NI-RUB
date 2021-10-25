require_relative 'roman'

def test
  roman = Roman.new(4) # => 4
  roman2 = Roman.new('XII') # => 12

  puts roman.to_i # => 4
  puts roman2.to_int # => 12

  puts '--- 1'
  puts roman == 4 # => true
  puts roman == 5 # => false
  puts roman > roman2 # => false
  puts roman < roman2 # => true

  puts '--- 2'
  puts roman + 1 # => 5
  puts 1 + roman # => 5

  puts '--- 3'
  puts roman * 2 # => 8
  puts 2 * roman # => 8
  puts roman / 2 # => 2
  puts roman2 / 4 # => 3
  puts 16 / roman # => 4

  puts '--- 4'
  puts [roman, roman2].min # => roman
  puts [roman, roman2].max # => roman2
  puts (roman..roman2).min # => roman
  puts (roman..roman2).max # => roman2

  puts '--- 5'
  p (1..100).first(roman) # => 1, 2, 3, 4

  puts '--- 6'
  p [Roman.new(1), Roman.new(3), Roman.new(9)].sum # => 13

  puts '--- 7'
  p (Roman.new(1)..Roman.new(5)).to_a # => 1, 2, 3, 4, 5

  puts '--- 8'
  puts roman.to_s # => 'IV'
  puts roman2.to_s # => 'XII'

  puts '--- 9'
  puts 6.roman # => 'VI'
  puts 'IV'.number # => 4

  puts '--- 10'
  p 6.to_roman # => Roman
  p 'V'.to_roman # => Roman
end

test
