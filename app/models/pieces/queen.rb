class Queen < Piece
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

    # can move vertical, horizontal or diagonal
    (x_dist == y_dist) || ((x_dist == 0 || y_dist == 0) && (x_dist > 0 || y_dist > 0))
  end
end
