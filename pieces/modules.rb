module SlidingPiece
  def moves
    _moves = []
    directions.each do |delta_direction|
      coord = [pos[0]+delta_direction[0], pos[1]+delta_direction[1]]
      while confirm_in_bounds(coord)
        _moves.push coord
        break if @board[coord].symbol != :N
        coord = [coord[0]+delta_direction[0], coord[1]+delta_direction[1]]
      end
    end

    return _moves
  end
end


module SteppingPiece
  def moves
    # puts "spm"
    # debugger
    _moves = []
    directions.each do |delta_direction|
      coord = [pos[0]+delta_direction[0], pos[1]+delta_direction[1]]
      _moves.push coord if confirm_in_bounds coord
    end
    return _moves
  end
end
