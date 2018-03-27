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
    display << render_debug_board

    return display
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
      [false,false] => :light_white,
      [true,false] => :light_black,
      [false,true] => :light_blue,
      [true,true] => :blue
    }[[even,move]]

    return (sym + " ").colorize(background: bgc, color: color)

  end




  #debugger information

  def selection_info
    if @cursor.selection
      piece = @board[@cursor.selection]
      return "selection_info: Piece: #{MODELS[piece.symbol]} , Color: #{piece.color.to_s}, pos: #{piece.pos.to_s}\r\nMoves:#{piece.moves}"
    end
    return @cursor.selection.to_s + "?!\r\n"
  end

  def render_debug_board
    debug_display = ""


      debug_display << selection_info



    debug_display << "\r\n  | 0  | 1  | 2  | 3  | 4  | 5  | 6  | 7  |\n\r___________________________________________"

    (0..7).each do |r|
      debug_display_top = ""
      debug_display_bottom = " "
      debug_display << " |" + " " * 5 * 8 + "\r\n"
      debug_display_top << r.to_s +  "|"
      debug_display_bottom << "|"
      (0..7).each do |c|
        ddt, ddb = specify_debug_info_for_cell([r,c])
        debug_display_top << ddt
        debug_display_bottom << ddb
      end
      debug_display << debug_display_top + "\r\n" + debug_display_bottom  + "\r\n"

    end

    return debug_display
  end

  def specify_debug_info_for_cell(position)
    begin
      top_data = " "
      bottom_data = " "
      if @board[position].pos
        @board[position].pos.each do |coord|
          top_data << coord.to_s
        end
        top_data << " "
        bottom_data << MODELS[@board[position].symbol]#.to_s
        bottom_data << "   "
      else
        top_data << "   "
        bottom_data << "    "
      end
    rescue Exception => e
      # debugger
      puts e.message
      puts "error"
    end
    top_data << " "
    return [top_data, bottom_data]
  end

end
