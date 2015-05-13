class King < Piece
  def valid_move?(x_destination, y_destination)
<<<<<<< HEAD
    move = [(x_coord - x_destination).abs, (y_coord - y_destination).abs]
=======
    x_distance = (self.x_coord - x_destination).abs
    y_distance = (self.y_coord - y_destination).abs
    
    case
    when x_distance == 1 && y_distance == 1
      return true
    when x_distance == 1 && y_distance == 0
      return true
    when x_distance == 0 && y_distance == 1
      return true
    else
      return false
    end      
  end
  
  def is_obstructed?(x_dest, y_dest)
    if Piece.where(:x_coord => x_dest, :y_coord => y_dest).length > 0
      return true
    else
      return false
    end
  end
>>>>>>> 6f5fff71e3c14d5e2a652c24bc74908b919e7f6f

    valid_moves = [[1,1],[1,0],[0,1]]

    valid_moves.include?(move)
  end
end
