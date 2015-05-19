class King < Piece
  def valid_move?(x_destination, y_destination)
    move = [(x_coord - x_destination).abs, (y_coord - y_destination).abs]

    valid_moves = [[1,1],[1,0],[0,1]]

    valid_moves.include?(move) && !obstructed_piece?(x_destination, y_destination)
  end
end
