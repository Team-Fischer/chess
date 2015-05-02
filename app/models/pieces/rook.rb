class Rook < Piece
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

    # distance must be 0 in one direction and >0 in the other
    (x_dist == 0 || y_dist == 0) && (x_dist > 0 || y_dist > 0)
  end

  def glyph
    'tower'
  end
end
