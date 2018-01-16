class Piece
  attr_reader :symbol
  def initialize
    @symbol = :X
  end
end

class NullPiece < Piece
  def initialize
    @symbol = :N
  end
end

class Queen < Piece
end

class King < Piece
end

class Bishop < Piece
end

class Knight < Piece
end

class Rook < Piece
end

class Pawn < Piece
end
