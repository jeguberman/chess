
module DebugDisplay

  MODELS = {
    Q: '♛',
    K: '♚',
    B: '♝',
    R: '♜',
    H: '♞',
    P: '♟',
    N: " "
  }

    def selection_info
      if @cursor.selection
        piece = @board[@cursor.selection]
        return "Piece: #{piece.color.to_s} #{MODELS[piece.symbol]} @ #{piece.pos.to_s}\r\nMoves:#{piece.moves}"
      end
      return "\r\n"
    end

    def debug_board
      debug_display = ""
      debug_display = "\r\n  | 0  | 1  | 2  | 3  | 4  | 5  | 6  | 7  |\n\r___________________________________________"

      (0..7).each do |r|
        debug_display_top = ""
        debug_display_bottom = " "
        debug_display << " |" + " " * 5 * 8 + "\r\n"
        debug_display_top << r.to_s +  "|"
        debug_display_bottom << "|"
        (0..7).each do |c|
          ddt, ddb = format_cell_for_debug([r,c])
          debug_display_top << ddt
          debug_display_bottom << ddb
        end
        debug_display << debug_display_top + "\r\n" + debug_display_bottom  + "\r\n"

      end

      return debug_display
    end

    def format_cell_for_debug(position)
      begin
        top_data = " "
        bottom_data = " "
        if @board[position].pos
          @board[position].pos.each do |coord|
            top_data << coord.to_s
          end
          top_data << " "
          bottom_data << MODELS[@board[position].symbol]#.to_s
          bottom_data << "   "
        else
          top_data << "   "
          bottom_data << "    "
        end
      rescue Exception => e
        puts e.message
        puts "error"
      end
      top_data << " "
      return [top_data, bottom_data]
    end

    def render_debug_view
      debug_display = ""
      if $DebugOn
        debug_display << selection_info
        debug_display << debug_board
        return debug_display
      end
      return debug_display
    end
end

module Recorder
  def initialize(*args)
    @record = [:game_start]
    @filepath = "./replays/replay"
    initialize_replay_file
  end

  def initialize_replay_file #truncates the replay file at 0
    if $RecordOn
      File.open(@filepath, "w"){|file| file.puts ":game_start"}
    end
  end

  def save_move(poses) #saves the start and end pos of the current move as an array like string to the replay file
    if $RecordOn
      File.open(@filepath, "a") do |file|
          file.puts(poses.to_s)
      end
    end
  end

  def fastForward #plays out all moves from the replay file
    return unless $ReplayOn

    whiteTurn = true
    IO.foreach(@filepath) do |move|
      next if move == ":game_start\n"
      break if move == ":check_mate\n"
      move = eval move #technically a vulnerability but this is cli chess, not the gui for the hawaiian missile defense system
      save_move([move[0],move[1]])
      @board.move_piece(move[0],move[1])
      whiteTurn = !whiteTurn
    end
      swap_player unless whiteTurn

  end


end

module CheckModule

  def find_king(color) #finds the pos of the current king on the board
    @grid.each_with_index do |row, y|
      row.each_with_index do |piece, x|
        if piece.class == King and piece.color == color
          return ([y,x])
        end
      end
    end
  end

  def in_check?(color) #returns true if current king is in check
    in_check_positions(color).length > 0
  end

  def in_check_positions(color) #returns an array of pieces threatening the current king
    king_pos = find_king(color)
    threats = []
    threats += threat_check(king_pos, color, Pawn)
    threats += threat_check(king_pos, color, Rook)
    threats += threat_check(king_pos, color, Bishop)
    threats += threat_check(king_pos, color, Queen)
    threats += threat_check(king_pos, color, Knight)
    return threats
  end

  def threat_check(king_pos, color, type)#checks if current king is threatened by given piece type
    hypotheses = type.new(color: color, pos: king_pos, board: self).moves
    hypotheses.select! { |coord| self[coord].class == type }
    hypotheses
  end

  def pontificate_check(current_player, start_pos, end_pos)#takes a move and determines if that move will leave the current player in check. If true, throws an error
    mock_board = create_mock_board
    mock_board.move_piece(start_pos, end_pos)
    if mock_board.in_check?(current_player)
      raise PieceMoveError.new("Can not leave your king in check")
    end
  end

  def create_mock_board #creates a mock board for pontificating future moves
    mock_board = Board.new
    @grid.each_with_index do |row, iy|
      row.each_index do |ix|
        if self[[iy,ix]].class != NullPiece
          mock_board[[iy,ix]] = self[[iy,ix]].dup
        else
          mock_board[[iy,ix]] = NullPiece.instance
        end
      end
    end
    return mock_board
  end


end
