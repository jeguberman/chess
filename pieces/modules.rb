class SlidingPiece
  def cardinal_directions
    [
      [-1,0],
      [0,-1],
      [0,1],
      [1,0]
    ]
  end

  def semicardinal_directions
    [
      [1,1],
      [1,-1],
      [-1,-1],
      [-1,1]
    ]
  end
end

class SteppingPiece
end
