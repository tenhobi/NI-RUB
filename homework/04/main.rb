# frozen_string_literal: true

require_relative 'my_struct'
# require 'ostruct'

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

def test2
  x = MyStruct.new

  begin
    x.delete_field :something
    puts 'fail'
  rescue StandardError => e
    puts "ok: #{e}"
  end
end

def test3
  struct = MyStruct.new( { secret: 'something' } )
  a = struct.secret
  hash = struct.to_h
  hash[:secret] = 'nope'
  b = struct.secret
  puts 'ok' if a == b
end
