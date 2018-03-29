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

class Record
  def initialize
    @record = [:game_start]
    @fullname = "./replays/replay"
    File.open(@fullname, "w"){|file| file.puts ":game_start"}
  end

  def save(poses)
    if $RecordOn
      file = File.open(@fullname, "a")
      file.puts(poses.to_s)
    end
  end
end
