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
  def solve
    #_solve_recursion
    _solve_iteration
    @grid
  end

  def solution
    @grid.solution
  end

  protected

  # inspired by
  # - https://blog.cloudboost.io/sudoku-solver-ruby-recursive-implementation-backtracking-technique-b69582427353
  # - https://codereview.stackexchange.com/questions/99337/sudoku-solver-in-ruby
  # - https://codereview.stackexchange.com/questions/37723/ruby-sudoku-solver
  # - https://medium.com/isian-blog/solving-sudoku-with-ruby-82ad6d82263d
  # - http://rubyquiz.com/quiz43.html
  def _solve_iteration
    i = 0

    empty_positions = []

    (0...@grid.rows).each do |row|
      (0...@grid.cols).each do |col|
        empty_positions << [row, col] unless @grid.filled?(row, col)
      end
    end

    while i < empty_positions.length
      row = empty_positions[i][0]
      column = empty_positions[i][1]
      number = @grid[row][column].to_i + 1
      found = false

      while !found && number <= 9
        if _check_value(row, column, number)
          found = true
          @grid[row][column] = number
          i += 1
        else
          number += 1
        end
      end

      unless found
        @grid[row][column] = 0
        i -= 1
      end
    end
  end

  def _check_value(row, column, number)
    return false if @grid.row_elems(row).any? { |cell| cell.to_i == number }
    return false if @grid.col_elems(column).any? { |cell| cell.to_i == number }
    return false if @grid.block_elems(row, column).any? { |cell| cell.to_i == number }

    true
  end

  # No idea why this bulls*** doesn't work... :'(
  def _solve_recursion
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

    @grid[empty_cell_coords[0], empty_cell_coords[1]].reset

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

    if @grid[empty_cell_coords[0], empty_cell_coords[1]].possible.count.zero?
      #@grid[empty_cell_coords[0], empty_cell_coords[1]] = 0
      puts "#{empty_cell_coords[0]}, #{empty_cell_coords[1]} = 0"
    else
      @grid[empty_cell_coords[0], empty_cell_coords[1]].possible.each do |guess|
        @grid[empty_cell_coords[0], empty_cell_coords[1]].value = guess
        puts "#{empty_cell_coords[0]}, #{empty_cell_coords[1]} = #{guess}"
        _solve_recursion

        @grid[empty_cell_coords[0], empty_cell_coords[1]] = 0
      end
    end
  end

  def load(game)
    PARSERS.each do |p|
      return p.load(game) if p.supports?(game)
    end
    raise "input '#{game}' is not supported yet"
  end
end
