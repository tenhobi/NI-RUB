require_relative 'my_struct'

struct = MyStruct.new

begin
  puts struct.name
rescue
  puts "no [name] field #1"
end

struct.name = "John"
puts struct.name
struct[:age] = 42
puts struct[:age]


struct.delete_field :age

p struct.each_pair.to_a
