class Pawn < Piece
  def valid_move?(x_dest, y_dest)
    x_dist = (x_dest - x_coord)
    y_dist = (y_dest - y_coord)
    direction = color == 'white' ? -1 : 1
    occupied = game.piece_at(x_dest, y_dest)


    if x_dist.abs == 1 && y_dist == direction && occupied 
      return x_dist.abs == 1 && y_dist == direction
    end
		# #TODO: Refactor such that valid_move? causes no side effects

    if color == 'white'
      if moved
        return y_dist == -1 && x_dist == 0
      else
        return (y_dist == -1 || y_dist == -2) && x_dist == 0
      end
    else
      if moved
        return y_dist == 1 && x_dist == 0
      else
       return (y_dist == 1 || y_dist == 2) && x_dist == 0
      end
    end
  end
end
