class Rook < Piece
<<<<<<< HEAD
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

    # distance must be 0 in one direction and >0 in the other
    (x_dist == 0 || y_dist == 0) && (x_dist > 0 || y_dist > 0)
  end

  def glyph
    'tower'
=======
  
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
>>>>>>> 6f5fff71e3c14d5e2a652c24bc74908b919e7f6f
  end
end


