#!/usr/bin/env ruby

require './board'
require './display'
require './modules'
require 'set'

#global variables
# $DebugOn = false
# $RecordOn = false

#game
class Game
  include Recorder
  attr_reader :current_player
  def initialize
    super
    @board = Board.new
    @cursor = Cursor.new([4,4], @board)
    @current_player = :white
    @display = Display.new(@board, @cursor, self)
  end


  def play
    fastForward
    swap_player if $TestsOn
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
    save_move([start_pos, end_pos])
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
  when "i", "debug_info"
    $DebugOn = true
    break
  when "r", "record"
    $RecordOn = true
    break
  when "p", "replay"
    $ReplayOn = true
    break
  when "t", "tests"
    $TestsOn = true
    break
  when "d", "jump_into_debug"
    debugger
  else
    puts "what is #{arg}?" #no no, it's a joke, I didn't just leave it there
  end
end

Game.new.play
