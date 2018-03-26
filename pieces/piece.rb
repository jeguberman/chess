require 'byebug'
require 'Singleton'
# require './modules'

class Piece
  attr_reader :symbol, :color, :pos
  def initialize(params = {color: :white, pos: [0,0]})
    @symbol = :X
    @color = params[:color]
    @pos = params[:pos]
    @board = params[:board]
  end

  def moves#returns an array of available moves for the selected piece
    raise "move method must be defined per individual piece type"
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
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :Q
  end
end

class King < Piece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :K
  end
end

class Bishop < Piece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :B
  end
end

class Knight < Piece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :H
  end
end

class Rook < Piece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :R
  end
end

class Pawn < Piece
  def initialize(params = {color: :white, pos: [0,0]})
    super(params)
    @symbol = :P
  end
end
