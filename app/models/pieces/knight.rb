class Knight < Piece
<<<<<<< HEAD
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

    (x_dist == 2 && y_dist == 1) || (x_dist == 1 && y_dist == 2)
  end

=======
  def is_obstructed?(x_dest, y_dest)
    false
  end
>>>>>>> 6f5fff71e3c14d5e2a652c24bc74908b919e7f6f
end
