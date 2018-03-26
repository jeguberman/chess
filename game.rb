require './board'
require './display'

class Game
  attr_reader :current_player
  def initialize
    @board = Board.new
    @cursor = Cursor.new([4,4], @board)
    # @players = [:white, :black]
    @current_player = :white
    @display = Display.new(@board, @cursor, self)
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

  def turn
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
    print @display.render_board
  end

end

Game.new.play
