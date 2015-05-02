class Bishop < Piece
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

    # move must be diag 
    (x_dist == y_dist)
  end
end
