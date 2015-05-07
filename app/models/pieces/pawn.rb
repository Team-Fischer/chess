class Pawn < Piece
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs
    
    if self.moved
      y_dist == 1 && x_dist == 0
    else
      (y_dist == 1 || y_dist == 2) && x_dist == 0
    end
  end
end
