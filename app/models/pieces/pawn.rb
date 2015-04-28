class Pawn < Piece

  def is_obstructed?(x_dest, y_dest)
    if y_dest > y_coord
      direction = 'positive'
    else
      direction = 'negative'
    end
    
    if (y_coord - y_dest).abs == 1
      if Piece.where(:x_coord => x_dest, :y_coord => y_dest).length > 0
        return true
      else
        return false
      end
    else
      if direction == 'negative'
        2.times do |square|
          return true if Piece.where(:x_coord => x_dest, :y_coord => (y_dest - (square + 1))).length > 0
        end
        return false
      else
        2.times do |square|
          return true if Piece.where(:x_coord => x_dest, :y_coord => (y_dest + (square + 1))).length > 0
        end
        return false
      end
    end
  end
end
