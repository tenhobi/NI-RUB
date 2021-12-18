# frozen_string_literal: true

# Contains sudoku game board
class Grid
  include Enumerable

  # Create Sudoku game grid of given dimension
  def initialize(dimension)
    @array = Array.new(dimension) { Array.new(dimension, nil) }
  end

  # Return string with game board in a console friendly format
  # @return [String]
  # @param [Integer] width
  def to_s(width = 3)
    s = StringIO.new
    @array.each_slice(width) do |block_rows|
      s << "---------+---------+---------\n"
      block_rows.each do |row|
        row.each_slice(width).with_index do |block_cells, i|
          block_cells.each do |cell|
            s << " #{cell.to_i.zero? ? ' ' : cell.to_i} "
          end
          s << '|' unless i == (row.length - 1) % width
        end
        s << "\n"
      end
    end
    s << "---------+---------+---------\n"
    s.string
  end

  # First element in the sudoku grid
  def first
    @array[0][0]
  end

  # Last element in the sudoku grid
  def last
    @array[rows - 1][cols - 1]
  end

  # Return value at given position
  def value(x, y)
    @array[x][y].to_i
  end

  # Marks number +number+ which shouldn't be at position [x, y]
  def exclude(x, y, number)
    @array[x][y].exclude(number)
  end

  # True when there is already a number
  def filled?(x, y)
    @array[x][y].to_i != 0
  end

  # True when no game was loaded
  def empty?
    each.any?(&:nil?)
  end

  # Yields elements in given row
  def row_elems(x, &block)
    return enum_for(:row_elems, x) unless block_given?

    @array[x].each(&block)
  end

  # Yields elements in given column
  def col_elems(y, &block)
    return enum_for(:col_elems, y) unless block_given?

    @array.each do |row|
      block.call(row[y])
    end
  end

  # Yields elements from block which is
  # containing element at given position
  def block_elems(x, y, &block)
    return enum_for(:block_elems, x, y) unless block_given?

    block_number = (x / 3.to_f).floor * 3 + (y / 3.to_f).floor
    block(block_number, &block)
  end

  def block(block_number, &block)
    return enum_for(:block, block_number) unless block_given?

    x = Array.new(3, Array.new(3))
    block_row = @array.each_slice(3).drop(block_number / 3).first
    block_row.each.with_index do |row, i|
      x[i] = row.each_slice(3).drop(block_number % 3).first
    end

    x.each do |row|
      row.each(&block)
    end
  end

  # With one argument return row, with 2, element
  # at given position
  def [](*args)
    case args.length
    when 1
      @array[args[0]]
    when 2
      @array[args[0]][args[1]]
    end
  end

  # With one argument sets row, with 2 element
  def []=(*args)
    case args.length
    when 2 # row index + array
      @array[args[0]] = args[1].map { |value| Cell.new(value, cols) }
    when 3 # row, column, data
      @array[args[0]][args[1]] = Cell.new(args[2], cols)
    end
  end

  # Return number of missing numbers in grid
  def missing
    each.sum do |cell|
      cell.to_i.zero? ? 1 : 0
    end
  end

  # Number of filled cells
  def filled
    @array.sum
  end

  # Number of rows in this sudoku
  def rows
    @array.length
  end

  # Number of columns in this sudoku
  def cols
    @array[0].length
  end

  # Iterates over all elements, left to right, top to bottom
  def each(&block)
    return enum_for(:each) unless block_given?

    @array.each do |row|
      row.each(&block)
    end
  end

  # Return true if no filled number break sudoku rules
  def valid?
    (0...rows).each do |i|
      return false unless row_elems(i).map(&:to_i).group_by(&:to_i).except(0).all? { |_key, value| value.count == 1 }
    end

    (0...cols).each do |i|
      return false unless col_elems(i).map(&:to_i).group_by(&:to_i).except(0).all? { |_key, value| value.count == 1 }
    end

    (0..8).each do |i|
      return false unless block(i).map(&:to_i).group_by(&:to_i).except(0).all? { |_key, value| value.count == 1 }
    end

    true
  end

  # Serialize grid values to a one line string
  def solution
    puts each.map(&:to_i).join('')
    each.map(&:to_i).join('')
  end
end
