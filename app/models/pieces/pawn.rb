class Pawn < Piece

  def valid_move?(x_destination, y_destination)
    # Jeremy removed .abs from distance calculations
    x_dist = (x_coord - x_destination)
    y_dist = (y_coord - y_destination)

   #Original Code that works
   # if self.moved
   #    y_dist == 1 && x_dist == 0
   # else
   #    (y_dist == 1 || y_dist == 2) && x_dist == 0
   # end

   # Jeremy's suggestion
   # Make sure to include the diagonal capture logic
   # that Harvey added that's on master now
   if color == 'white'
     if moved
       return y_dist == 1 && x_dist == 0
     else
       return (y_dist == 1 || y_dist == 2) && x_dist == 0
     end
   else
     if moved
       return y_dist == -1 && x_dist == 0
     else
       return (y_dist == -1 || y_dist == -2) && x_dist == 0
     end
   end

   # this won't work, because Game doesn't have a color
  #  while Game.where(:color => 'white') do
  #   if self.moved
  #     y_dist == -1 && x_dist == 0
  #   else
  #     (y_dist == -1 || y_dist == -2) && x_dist == 0
  #   end
  #  end

  end
end
