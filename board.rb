require_relative './pieces/piece.rb'

class Board
  STRONG_PIECES = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]

  def initialize
    @grid = Array.new(12){Array.new(12){NullPiece.instance}}
    populate!
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,arg)
    x,y=pos
    @grid[x][y]=arg
  end

  def move_piece(start_pos, end_pos)
    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
  end

  def valid_move?(current_player, start_pos, end_pos)
    raise StandardError.new("No piece at start position") if self[start_pos].color != current_player
    raise StandardError.new("Can't move to space occupied by own piece") if self[end_pos].color == current_player
    return true
  end

  def in_bounds?(pos)
    x, y = pos
    return true if ((0..7).include? x ) && ((0..7).include? y)
    return false
  end


  def populate!
    col = 0
    STRONG_PIECES.each do |piece_class|
      spawn_pos = [0, col]
      self[spawn_pos] = piece_class.new({color: :black, pos: spawn_pos})
      col += 1
    end

    (0..7).each do |col|
      spawn_pos = [1,col]
      self[spawn_pos] = Pawn.new({color: :black, pos: spawn_pos})
    end

    (0..7).each do |col|
      spawn_pos = [6,col]
      self[spawn_pos] = Pawn.new({color: :white, pos: spawn_pos})
    end

    col = 0
    STRONG_PIECES.each do |piece_class|
      spawn_pos = [7, col]
      self[spawn_pos] = piece_class.new({color: :white, pos: spawn_pos})
      col += 1
    end

  end

end
