require_relative './pieces/piece.rb'

class Board
  STRONG_PIECE_NAMES = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]

  attr_reader :graveyard

  def initialize
    @grid = Array.new(12){Array.new(12){NullPiece.instance}}
    populate!
    @graveyard = {
      white: [],
      black: []
    }
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos,arg)
    x,y = pos
    @grid[x][y]=arg
  end

  def move_piece(start_pos, end_pos)
    start_piece =  self[start_pos]
    end_piece = self[end_pos]

    colors = Set.new( [start_piece.color, end_piece.color])

    if colors == Set.new( [:white, :black] )
      end_piece.set_pos(nil)
      @graveyard[end_piece.color] << end_piece
    else
      end_piece.set_pos(start_pos)
      self[start_pos] = end_piece
    end

    start_piece.set_pos end_pos
    self[end_pos] = start_piece

  end

  def valid_move?(current_player, start_pos, end_pos)
    if self[start_pos].color != current_player
      raise StandardError.new("Select one of your pieces for start position piece at start position")
    end
    if self[end_pos].color == current_player
      raise StandardError.new("Can't move to space occupied by own piece")
    end
    if !self[start_pos].moves.include?(end_pos)
      raise StandardError.new("Not valid move for piece")
    end
    return true
  end

  def in_bounds?(pos)
    x, y = pos
    return true if ((0..7).include? x ) && ((0..7).include? y)
    return false
  end


  def populate!
    col = 0
    STRONG_PIECE_NAMES.each do |piece_class|
      spawn_pos = [0, col]
      self[spawn_pos] = piece_class.new({color: :black, pos: spawn_pos, board: self})

      spawn_pos = [7, col]
      self[spawn_pos] = piece_class.new({color: :white, pos: spawn_pos, board: self})

      col += 1
    end

    (0..7).each do |col|
      spawn_pos = [1,col]
      self[spawn_pos] = Pawn.new({color: :black, pos: spawn_pos, board: self})
      spawn_pos = [6,col]
      self[spawn_pos] = Pawn.new({color: :white, pos: spawn_pos, board: self})
    end



    fake_pos = [4,4]
    self[fake_pos] = Pawn.new(color: :white, pos: fake_pos, board: self)
    fake_pos = [3,3]
    self[fake_pos] = Pawn.new(color: :black, pos: fake_pos, board: self)
  end

end
