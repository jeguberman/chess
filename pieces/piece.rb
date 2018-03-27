require 'byebug'
require 'Singleton'
require_relative './modules.rb'

class Piece
  attr_reader :symbol, :color, :pos
  def initialize(params = {color: :white, pos: [0,0]})
    @symbol = :X
    @color = params[:color]
    @pos = params[:pos]
    @board = params[:board]
  end

  def moves#returns an array of available moves for the selected piece
    # raise "move method must be defined per individual piece type"
    ["Oh, shit! You fucked up!"]
  end

  def set_pos(new_pos)
    @pos = new_pos
  end

  private

  def confirm_in_bounds(coord)
    return false  unless @board[coord].color != @color
    return false unless @board.in_bounds? coord
    return true
  end

end

class NullPiece < Piece
  include Singleton
  def initialize
    @color = :blue
    @symbol = :N
  end

  def set_pos(new_pos)
    #NullPieces don't have position, they are singletons, so we had to override the parent
  end

end

class Queen < Piece
  include SlidingPiece

  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    def directions
      [
        [-1,-1],
        [-1,0],
        [-1,1],
        [0,-1],
        [0,1],
        [1,-1],
        [1,0],
        [1,1]
      ]
    end
    @symbol = :Q
  end
end

class Bishop < Piece
  include SlidingPiece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :B
  end

  def directions
    [
      [1,1],
      [1,-1],
      [-1,-1],
      [-1,1]
    ]
  end
end


class Rook < Piece
  include SlidingPiece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :R
  end

  def directions
    [
      [-1,0],
      [0,-1],
      [0,1],
      [1,0]
    ]
  end
end

class King < Piece
  include SteppingPiece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :K
  end

  def directions
    [
      [-1,-1],
      [-1,0],
      [-1,1],
      [0,-1],
      [0,1],
      [1,-1],
      [1,0],
      [1,1]
    ]
  end
end

class Knight < Piece
  include SteppingPiece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :H
  end

  def directions
      [
        [-2,-1],
        [-2,1],
        [-1,-2],
        [-1,2],
        [1,-2],
        [1,2],
        [2,-1],
        [2,1]
      ]
  end
end


class Pawn < Piece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :P
  end

  def moves
    delta = @color == :white ? -1 : 1

    _moves = [ [pos[0] + delta, pos[1]] ]

    if (delta == -1 && pos[0] == 6) || (delta == 1 && pos[0] == 1) #if pawn in starting row
      _moves.push [pos[0] + delta * 2, pos[1]]
    end

    if opponent_in_space? [pos[0] + delta, pos[1] + delta]
      _moves.push [pos[0] + delta, pos[1] + delta]
    end

    if opponent_in_space? [pos[0] + delta, pos[1] - delta]
      _moves.push [pos[0] + delta, pos[1] - delta]
    end

    _moves
  end


  private
  def opponent_in_space?(coord)
    opponent_color = @color == :white ? :black : :white
    @board[coord].color == opponent_color
  end
end
