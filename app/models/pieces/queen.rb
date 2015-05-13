class Queen < Piece
<<<<<<< HEAD
=======

  def is_obstructed?(x_dest, y_dest)
    @x_distance = (x_dest - x_coord)
    @y_distance = (y_dest - y_coord)
    a = (x_coord..x_dest).to_a
    b = (y_coord..y_dest).to_a
    @spaces = a.zip(b).to_a
    @y = @spaces.length.to_i - 1

    case
    when @x_distance == 1 && @y_distance == 1
      if Piece.where(:x_coord => x_dest, :y_coord => x_dest).length > 0
        return true
      else
        return false
      end
    when @x_distance > 0 && @y_distance > 0
    for x in (@spaces.first.to_i..@y)
      puts x
    if Piece.where(:x_coord => @spaces[x][0], :y_coord => @spaces[x][1]).length > 0
      true
    else
      false
    end
  end

        obstruct 
    when x_distance > 0 && y_distance == 0
    for x_element in (x_coord..x_dest)
     if game.pieces.where(:x_coord => x_element, :y_coord => y_dest).length > 1 
        return true
     else
        return false
      end
    end
    when x_distance > 0 && y_distance < 0
      for x_element in (x_coord..x_dest)
        a << x_element
      end
      (y_coord).downto(y_dest) do y_element
        b << y_element
      end
    spaces_covered = a.zip(b)
      for spaces in spaces_covered
        spaces.each do |obs_pieces|
          if game.pieces.where(:x_coord => spaces[0], :y_coord => spaces[1]).length > 1
            return true
          else
            return false
          end
        end
      end
    when x_distance == 0 && y_distance < 0
    (y_coord).downto(y_dest) do y_element      
     if game.pieces.where(:x_coord => x_dest, :y_coord => y_element).length > 1 
        return true
     else
        return false
      end
    end
    when x_distance < 0 && y_distance < 0
      x_coord.downto(x_dest) do x_element
        a << x_element
      end
      (y_coord).downto(y_dest) do y_element 
        b << y_element
      end
      spaces_covered = a.zip(b)
        for spaces in spaces_covered
          spaces.each do |obs_pieces|
            if game.pieces.where(:x_coord => spaces[0], :y_coord => spaces[1]).length > 1
              return true
            else
              return false
            end
          end
        end
    when x_distance < 0 && y_distance == 0
      for x_element in (x_dest...x_coord)
        if game.pieces.where(:x_coord => x_element, :y_coord => y_dest).length > 1 
          return true
        else
          return false
        end
      end
    when x_distance < 0 && y_distance > 0
      (x_coord).downto(x_dest) do x_element
        a << x_element
      end
      for y_element in (y_coord..y_dest)
        b << y_element
      end
      spaces_covered = a.zip(b)
        for spaces in spaces_covered
          spaces.each do |obs_pieces|
            if game.pieces.where(:x_coord => spaces[0], :y_coord => spaces[1]).length > 1
              return true
            else
              return false
            end
          end
        end
    when x_distance == 0 && y_distance > 0
      for y_element in (y_coord..y_dest)
        if game.pieces.where(:x_coord => x_dest, :y_coord => y_element).length > 1
          return true
        else
          return false
        end
      end
    end
  end
>>>>>>> 6f5fff71e3c14d5e2a652c24bc74908b919e7f6f
end

def valid_move?

  case valid
  when @x_distance.abs = @y_distance.abs
    true
  when @x_distance.abs > 0 && @y_distance.abs == 0
    true
    
  end

end

