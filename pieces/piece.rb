require 'byebug'
require 'Singleton'
# require './modules'

class Piece
  attr_reader :symbol, :color, :pos
  def initialize(params = {color: :white, pos: [0,0]})
    @symbol = :X
    @color = params[:color]
    @pos = params[:pos]
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @color = :blue
    @symbol = :N
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
