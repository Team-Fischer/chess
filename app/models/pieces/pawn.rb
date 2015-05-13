class Pawn < Piece
<<<<<<< HEAD
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs
    
    if self.moved
      y_dist == 1 && x_dist == 0
    else
      (y_dist == 1 || y_dist == 2) && x_dist == 0
=======

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
>>>>>>> 6f5fff71e3c14d5e2a652c24bc74908b919e7f6f
    end
  end
end
