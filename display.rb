require './cursor.rb'
require 'colorize'
require 'colorized_string'
require 'byebug'


class Display

  MODELS = {
    Q: '♛',
    K: '♚',
    B: '♝',
    R: '♜',
    H: '♞',
  	P: '♟',
    N: " "
  }

  attr_reader :cursor, :errors

  def initialize(board, cursor, game)
    @board = board
    @cursor = cursor
    @errors = nil
    @game = game
  end

  def receive_errors(errors)
    @errors = errors
  end

  def render_board
    display = " 0 1 2 3 4 5 6 7\n\r"

    (0..7).each do |r|
      display << r.to_s
      (0..7).each do |c|
        display << colorize_tile(r,c)
      end
      display << "\r\n"
    end
    display << "#{@game.current_player}\r\n"
    display << "#{@errors}\r\n"
    return display
  end

  private

  def colorize_tile(row, col)
    sym = MODELS[@board[[row,col]].symbol]
    color = @board[[row,col]].color
    if [row,col] == @cursor.cursor_pos
      return (sym + " ").colorize(background: @cursor.background, color: color)
    elsif (row + col).even?
      return (sym + " ").colorize(background: :light_black, color: color)
    end
    return (sym + " ").colorize(background: :light_white, color: color)
  end

end
