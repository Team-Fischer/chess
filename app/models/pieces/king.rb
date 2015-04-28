class King < Piece
  def valid_move?(x_destination, y_destination)
    x_distance = (x_coord - x_destination).abs
    y_distance = (y_coord - y_destination).abs

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
end
