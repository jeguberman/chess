require_relative './piece.rb'

class Board


  def initialize
    @grid = Array.new(12){Array.new(12){"n"}}
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

  def valid_move?(current_color, start_pos, end_pos)
    raise "No piece at start position" if self[start_pos].color != current_color
    raise "Can't move to space occupied by own piece" if self[end_pos].color == current_color
    return true
  end

  def populate

  end

end
