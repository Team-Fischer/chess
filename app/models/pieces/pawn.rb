class Pawn < Piece
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

    if y_coord == 1 || 6
    	y_dist == 2
    else
    	y_dist == 1
    end
  end

end
