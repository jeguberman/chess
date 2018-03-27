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

  private

  def confirm_in_bounds(coord)
    # debugger
    return false  unless @board[coord].color != @color
    return false unless @board.in_bounds? coord
    return true
  end

end

class SteppingPiece
  def moves
    _moves = []
    directions.map do |delta|
      coord = [pos[0]+delta[0], pos[1]+delta[1]]
      _moves.push coord if @board.in_bounds? coord
    end

  end
end
