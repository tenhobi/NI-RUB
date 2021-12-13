# frozen_string_literal: true

# Represent single number in sudoku grid which could
# have 9 possible values unless a values is already
# assigned
class Cell
  attr_accessor :value
  attr_reader :possible

  def initialize(value, dimension)
    @value = 0
    @value = value if value.to_i.positive?
    @possible = []
    @possible = (1..dimension).to_a if @value.zero?
    @dimension = dimension
  end

  # true when value was already assigned
  def filled?
    @value.positive?
  end

  # number of possible values at this position
  def num_possible
    return -1 if filled?

    @possible.size
  end

  # exclude possibility
  # return true if number was deleted
  def exclude(num)
    return true if !filled? && @possible.delete(num)

    false
  end

  def reset
    @value = 0
    @possible = (1..@dimension).to_a
  end

  def to_i
    @value
  end
end
