require_relative './pieces/piece.rb'
require_relative './modules.rb'

class Board
  include CheckModule

  STRONG_PIECE_NAMES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  attr_reader :graveyard

  def initialize
    super
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

  def move_piece(start_pos, end_pos) #moves one piece to another square, taking appropriate action depending on what piece occupies the other square
    start_piece =  self[start_pos]
    end_piece = self[end_pos]

    colors = Set.new( [start_piece.color, end_piece.color])

    if colors == Set.new( [:white, :black] )
      end_piece.set_pos(nil)
      @graveyard[end_piece.color] << end_piece
      self[start_pos] = NullPiece.instance
    else
      end_piece.set_pos(start_pos)
      self[start_pos] = end_piece
    end

    start_piece.set_pos end_pos
    self[end_pos] = start_piece

  end

  def valid_move?(current_player, start_pos, end_pos) #takes two positions and the current player's ID color and returns true if the first position can move to the second position

    if self[start_pos].color != current_player
      raise PieceMoveError.new("Select one of your pieces for start position piece at start position")
    end
    if self[end_pos].color == current_player
      raise PieceMoveError.new("Can't move to space occupied by own piece")
    end
    if !self[start_pos].moves.include?(end_pos)
      raise PieceMoveError.new("Not valid move for piece")
    end
    pontificate_check(current_player, start_pos, end_pos)
    return true
  end











  def in_bounds?(pos) #takes position and returns true if position is on the chess board
    x, y = pos
    return true if ((0..7).include? x ) && ((0..7).include? y)
    return false
  end


  def populate! #populates the board with standard chess layout. Adds pieces in strange positions if $TestsOn variable is true
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

    test_positions


  end

  def test_positions #populate the board with pieces not in starting position
    return unless $TestsOn

    fake_pos = [2,3]
    self[fake_pos] = King.new(color: :black, pos: fake_pos, board: self)

    self[[0,4]]= NullPiece.instance

    fake_pos = [4,1]
    self[fake_pos] = Bishop.new(color: :white, pos: fake_pos, board: self)

    fake_pos = [5,3]
    self[fake_pos] = Rook.new(color: :white, pos: fake_pos, board: self)

    fake_pos = [3,4]
    self[fake_pos] = Pawn.new(color: :white, pos: fake_pos, board: self)

    fake_pos = [3,5]
    self[fake_pos] = Knight.new(color: :white, pos: fake_pos, board: self)


  end

end
