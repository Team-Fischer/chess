class Bishop < Piece
  def is_obstructed?(x_dest, y_dest)
    x_distance = (x_dest - x_coord)
    y_distance = (y_dest - y_coord)
    a = Array.new
    b = Array.new
    
    case 
    when x_distance > 0 && y_distance > 0
      for x_element in ((x_coord + 1)..x_dest)
        a << x_element
      end
      
      for y_element in ((y_coord + 1)..y_dest)
        b << y_element
      end
      c = a.zip(b)
      if c & (Piece.where(:x_coord => x_element, :y_coord => y_element)) == nil
        false
      else
        true
      end
      
    when x_distance > 0 && y_distance < 0
      for x_element in ((x_coord + 1)..x_dest)
        a << x_element
      end
      
      (y_dest - 1).downto(y_coord) do y_element
        b << y_element
      end
      c = a.zip(b)
      if c & (Piece.where(:x_coord => x_element, :y_coord => y_element)) == nil
        false
      else
        true
      end
      
      
    when x_distance < 0 && y_distance < 0
     (x_dest - 1).downto(x_coord) do x_element
        a << x_element
      end
      
      (y_dest - 1).downto(y_coord) do y_element
        b << y_element
      end
      c = a.zip(b)
      if c & (Piece.where(:x_coord => x_element, :y_coord => y_element)) == nil
        false
      else
        true
      end

    when x_distance < 0 && y_distance > 0
      (x_dest - 1).downto(x_coord) do x_element
        a << x_element
      end
      
      for y_element in (y_coord..y_dest)
        b << y_element
      end
      c = a.zip(b)
      if c & (Piece.where(:x_coord => x_element, :y_coord => y_element)) == nil
        false
      else
        true
      end
    end
  end
end