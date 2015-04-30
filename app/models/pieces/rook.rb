class Rook < Piece
  
  def is_obstructed?(x_dest, y_dest)
    x_distance = (x_dest - x_coord)
    y_distance = (y_dest - y_coord)
    case 
    when x_distance > 0
      for a in ((x_coord + 1)..x_dest)
        if Piece.where(:x_coord => a, :y_coord => y_dest).length > 0
          return true
        else
          return false
        end
      end
    when x_distance < 0
      for a in ((x_dest + 1)..x_coord)
        if Piece.where(:x_coord => a, :y_coord => y_dest).length > 0
          return true
        else
          return false
        end
      end
    when y_distance > 0
      for a in ((y_coord+1)..y_dest)
        if Piece.where(:x_coord => x_dest, :y_coord => a).length > 0
          return true
        else
          return false
        end
      end
    when y_distance < 0
      for a in ((y_dest + 1)..y_coord)
        if Piece.where(:x_coord => x_dest, :y_coord => a).length > 0
          return true
        else
          return false
        end
      end
    end
  end
end


