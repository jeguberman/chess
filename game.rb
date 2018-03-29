require './board'
require './display'
require './modules'
require 'set'

#global variables
$DebugOn = false
# $RecordOn = false

#game
class Game
  attr_reader :current_player
  def initialize
    @board = Board.new
    @cursor = Cursor.new([4,4], @board)
    # @players = [:white, :black]
    @current_player = :white
    @display = Display.new(@board, @cursor, self)
    @record = Record.new
  end

  def play
    until game_over?
      turn
      swap_player
    end
  end

  def game_over?
    return false
  end

  def turn #listens for two position values, verifies the validity of the move, displays errors if the move was invalid and tries again, control is dropped to move_piece
    display_board
    begin
      start_pos = turn_phase
      end_pos = turn_phase
      @board.valid_move?(@current_player, start_pos, end_pos)
    rescue StandardError => errors
      @display.receive_errors(errors.message)
      display_board
      retry
    end
    @display.receive_errors(nil)
    @record.save([start_pos, end_pos])
    @board.move_piece(start_pos, end_pos)
    display_board
  end

  private

  def swap_player
    if @current_player == :white
      @current_player = :black
    else
      @current_player = :white
    end
  end

  def turn_phase
    pos = nil

    until pos
      display_board
      pos = @cursor.get_cursor_pos
    end
    pos
  end

  def game_over?
    return false
  end

  def display_board
    system("clear")
    print @display.render_view
  end

end

ARGV.each do |arg|
  case arg
  when "d", "jump_into_debug"
    debugger
  when "i", "debug_info"
    $DebugOn = true
  when "r", "record"
    $RecordOn = true
  else
    puts "what is #{arg}?" #no no, it's a joke, I didn't just leave it there
  end
end

Game.new.play
