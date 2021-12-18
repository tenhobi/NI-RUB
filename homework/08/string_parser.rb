# frozen_string_literal: true

require_relative './grid'
# Parse string for 9x9 sudoku game
class StringParser
  # Static methods will follow
  class << self
    # Return true if passed object
    # is supported by this loader
    def supports?(arg)
      return false unless arg.is_a? String
      return false unless arg.length == 81

      arg.each_char do |c|
        return false unless c.match?(/[.[:digit:]]/)
      end

      true
    end

    # Return Grid object when finished
    # parsing
    def load(arg)
      return false unless supports? arg

      grid = Grid.new(9)
      arg.each_char.map(&:to_i).each_slice(9).with_index do |row, i|
        grid[i] = row
      end
      grid
    end
  end
end
