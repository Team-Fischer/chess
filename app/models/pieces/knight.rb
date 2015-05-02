class Knight < Piece
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

    (x_dist == 4 && y_dist == 1) || (x_dist == 1 && y_dist == 4)
  end

  def glyph
    'knight'
  end

end
