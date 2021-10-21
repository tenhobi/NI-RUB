# frozen_string_literal: true

require_relative 'my_struct'

def test
  struct = MyStruct.new
  struct.name = 'John'
  puts struct.name

  struct[:age] = 42
  puts struct[:age]

  struct.delete_field :age
  struct.each_pair.to_a

  puts struct.each_pair { |key, value| [key.to_s.upcase, value.to_s.upcase] }.to_h
end
