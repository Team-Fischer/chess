class Knight < Piece
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

    (x_dist == 2 && y_dist == 1) || (x_dist == 1 && y_dist == 2)
  end

  def is_obstructed?(x_destination, y_destination)
  	obstructed = game.piece_at(x_destination, y_destination)

  	if obstructed
  		if obstructed.color == self.color
  			return true
  		end
  	end
  end

end
