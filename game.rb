require './board'
require './display'

class Game
  def initialize
    @board = Board.new
    @cursor = Cursor.new([4,4], @board)
    @display = Display.new(@board, @cursor)
    @players = [:white, :black]
    @current_player = @players[0]
  end

  def play

    display_board
    until game_over?
      display_board
      @cursor.get_input
    end

  end

  private

  def game_over?
    return false
  end

  def display_board
    system("clear")
    print @display.render_board
  end

end

Game.new.play
