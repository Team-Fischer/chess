class Pawn < Piece
<<<<<<< HEAD

  def valid_move?(x_dest, y_dest)
    x_dist = (x_dest - x_coord)
    y_dist = (y_dest - y_coord)

    if x_dist == -1 && y_dist == -1 && game.piece_at(x_dest, y_dest)
      

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
   
#   game.piece_at(x_destination, y_destination) && color != game.piece_at(x_destination, y_destination).color

  end
end
