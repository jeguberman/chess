require './cursor.rb'
require 'colorize'
require 'colorized_string'
require 'byebug'
require './modules.rb'


class Display
  include DebugDisplay

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

    return display
  end

  def render_hud
    display = "#{@errors}\r\n"
    display << "#{@game.current_player.capitalize}'s turn"
    display << check_alert
    display << "\r\n"
    display << "\r\n" unless $DebugOn
    display << render_graveyards
    display
  end

  def check_alert
    if @board.in_check?(@game.current_player)
      return ": #{@game.current_player.capitalize}'s King is in check!\r\n"
    end
    return ""
  end

  def render_graveyard(color)
    display = ""

    display <<  "  #{color.to_s}: "
    @board.graveyard[color].each do |piece|
      display << MODELS[piece.symbol] + " "
    end
    display << "\r\n" unless $DebugOn
    display
  end

  def render_graveyards
    display = ""
    display << "Graveyards|"
    display << "\r\n" unless $DebugOn
    display << render_graveyard(:white)
    display << render_graveyard(:black)
    display
  end

  def render_view
    display = ""
    display << render_board
    display << render_hud
    display << render_debug_view
  end

  private

  def colorize_tile(row, col)

    sym = MODELS[@board[[row,col]].symbol]
    color = @board[[row,col]].color
    if [row,col] == @cursor.cursor_pos
      return (sym + " ").colorize(background: @cursor.background, color: color)
    end

    even = (row + col).even?
    move = false
    bgc = ""

    if @cursor.selection && @board[@cursor.selection].moves.include?([row,col])
      move = true
    end

    bgc = {
      [false,false] => :light_black,
      [true,false] => :light_white,
      [false,true] => :blue,
      [true,true] => :light_blue
    }[[even,move]]

    if @board.in_check_positions(@game.current_player).include? [row,col]
      bgc = :magenta
    end

    return (sym + " ").colorize(background: bgc, color: color)

  end







end
