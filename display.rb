require './cursor.rb'
require 'colorize'
require 'colorized_string'
require 'byebug'


class Display

  attr_reader :cursor

  def initialize(board, cursor)
    @board = board
    @cursor = cursor
  end
  def render_board
    display = " 0 1 2 3 4 5 6 7\n\r"
    row_num = -1

    (0..7).each do |r|
      display << r.to_s
      (0..7).each do |c|
        display << colorize_tile(r,c)
      end
      display << "\r\n"
    end
    return display
  end

  private

  def colorize_tile(row, col)
    sym = @board[[row,col]].symbol.to_s
    if [row,col] == @cursor.cursor_pos
      return (sym + " ").colorize(background: @cursor.background, color: :black)
    elsif (row + col).even?
      return (sym + " ").colorize(background: :red, color: :light_blue)
    end
    return (sym + " ").colorize(background: :blue, color: :light_red)
  end

end
