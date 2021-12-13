# frozen_string_literal: true

require_relative './grid'
require_relative './string_parser'

# Basic sudoku solver
class Sudoku
  PARSERS = [StringParser].freeze

  EXCLUDE = proc do |enum, val|
    enum.each do |e|
      e.exclude(val)
    end
  end

  def initialize(game)
    @grid = load(game)
  end

  # Return true when there is no missing number
  def solved?
    !@grid.nil? && @grid.missing.zero?
  end

  # Solves sudoku and returns 2D Grid
  # ---------+---------+---------
  #        6 |       2 | 8
  #     5    | 1  3    |    2
  #  4     2 | 5       | 9     1
  # ---------+---------+---------
  #  9       |    7    | 5  4
  #     2    | 8     1 |    9
  #     8  7 |    5    |       2
  # ---------+---------+---------
  #  2     8 |       9 | 3     5
  #     4    |    1  8 |    7
  #        3 | 6       | 1
  # ---------+---------+---------
  def solve
    _solve
    puts @grid.to_s
  end

  protected

  def _solve
    raise 'invalid game given' unless @grid.valid?
    return if @grid.missing.zero?

    # find next empty cell
    empty_cell_coords = nil
    (0...@grid.rows).each do |row|
      (0...@grid.cols).each do |col|
        unless @grid.filled?(row, col)
          empty_cell_coords = [row, col]
          break
        end
      end

      break unless empty_cell_coords.nil?
    end

    # exclude values
    @grid.row_elems(empty_cell_coords[0]).each do |cell|
      @grid.exclude(empty_cell_coords[0], empty_cell_coords[1], cell.to_i)
    end
    @grid.col_elems(empty_cell_coords[1]).each do |cell|
      @grid.exclude(empty_cell_coords[0], empty_cell_coords[1], cell.to_i)
    end
    @grid.block_elems(empty_cell_coords[0], empty_cell_coords[1]).each do |cell|
      @grid.exclude(empty_cell_coords[0], empty_cell_coords[1], cell.to_i)
    end

    # guess value
    @grid[empty_cell_coords[0], empty_cell_coords[1]].possible.each do |guess|
      @grid[empty_cell_coords[0], empty_cell_coords[1]].value = guess
      puts "#{empty_cell_coords[0]}, #{empty_cell_coords[1]} = #{guess}"
      _solve

      break if @grid.missing.zero?

      @grid[empty_cell_coords[0], empty_cell_coords[1]] = 0
      puts "#{empty_cell_coords[0]}, #{empty_cell_coords[1]} = 0"
    end

    puts "wooo #{@grid.missing.zero?}"
  end

  def load(game)
    PARSERS.each do |p|
      return p.load(game) if p.supports?(game)
    end
    raise "input '#{game}' is not supported yet"
  end
end
