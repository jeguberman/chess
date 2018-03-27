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

class King < Piece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :K
  end

  def directions
    [
      [1,1],
      [1,-1],
      [-1,-1],
      [-1,1],
      [-1,0],
      [0,-1],
      [0,1],
      [1,0]
    ]
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

class Knight < Piece
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

class Pawn < Piece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :P
  end
end
