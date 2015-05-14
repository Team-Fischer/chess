class Queen < Piece
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

<<<<<<< Updated upstream
    # can move vertical, horizontal or diagonal
    (x_dist == y_dist) || ((x_dist == 0 || y_dist == 0) && (x_dist > 0 || y_dist > 0))
  end

  def obstructed_piece?(x_destination, y_destination)
	x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs  	

    if x_dist == y_dist
    	obstructed_diagonal(x_destination, y_destination)
    elsif y_dist == 0
    	obstructed_horiz(x_destination, y_destination)
    else 
    	obstructed_vert(x_destination, y_destination)
    end

  end

  def obstructed_diagonal(x_destination, y_destination)
  	game = Game.where(:id => self.game_id).first

	if x_coord > x_destination 
		a = (x_destination..x_coord).to_a
	else
		a = (x_coord..x_destination).to_a
	end

	if y_coord > y_destination
    	b = (y_destination..y_coord).to_a
    else
    	b = (y_coord..y_destination).to_a
    end

    @spaces = a.zip(b).to_a
    @spaces.each do |obs|
    	unless obs[0] == x_coord && obs[1] == y_coord
        	return true if game.piece_at(obs[0], obs[1])
    	end
=======
  def is_obstructed?(x_destination, y_destination)
    @x_distance = (x_destination - x_coord)
    @y_distance = (y_destination - y_coord)
    a = (x_coord..x_destination).to_a
    b = (y_coord..y_destination).to_a
    @spaces = a.zip(b).to_a
    @y = @spaces.length.to_i - 1

    if @x_distance == 1 && @y_distance == 1
      if Piece.where(:x_coord => x_destination, :y_coord => x_destination).length > 0
        return true
      else
        return false
      end
    end
    if @x_distance > 0 && @y_distance > 0
      @spaces.each_with_index do |x, x_index|
        print Piece.where(:x_coord => @spaces[x_index][0].to_i, :y_coord => @spaces[x_index][1].to_i)
        return true if Piece.where(:x_coord => @spaces[x_index][0].to_i, :y_coord => @spaces[x_index][1].to_i).length > 0
      end 
        return false
      end
case
    when @x_distance > 0 && @y_distance == 0
    for x_element in (x_coord..x_destination)
     if game.pieces.where(:x_coord => x_element, :y_coord => y_destination).length > 1 
        return true
     else
        return false
      end
    end
    when @x_distance > 0 && @y_distance < 0
      for x_element in (x_coord..x_destination)
        a << x_element
      end
      (y_coord).downto(y_destination) do y_element
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
    when @x_distance == 0 && @y_distance < 0
    (y_coord).downto(y_destination) do y_element      
     if game.pieces.where(:x_coord => x_destination, :y_coord => y_element).length > 1 
        return true
     else
        return false
      end
    end
    when @x_distance < 0 && @y_distance < 0
      x_coord.downto(x_destination) do x_element
        a << x_element
      end
      (y_coord).downto(y_destination) do y_element 
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
    when @x_distance < 0 && @y_distance == 0
      for x_element in (x_destination...x_coord)
        if game.pieces.where(:x_coord => x_element, :y_coord => y_destination).length > 1 
          return true
        else
          return false
        end
      end
    when @x_distance < 0 && @y_distance > 0
      (x_coord).downto(x_destination) do x_element
        a << x_element
      end
      for y_element in (y_coord..y_destination)
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
    when @x_distance == 0 && @y_distance > 0
      for y_element in (y_coord..y_destination)
        if game.pieces.where(:x_coord => x_destination, :y_coord => y_element).length > 1
          return true
        else
          return false
        end
      end
>>>>>>> Stashed changes
    end
    return false
  end

  def obstructed_horiz(x_destination, y_destination)
  	game = Game.where(:id => self.game_id).first
	if x_coord > x_destination 
		a = (x_destination..x_coord).to_a
	else
		a = (x_coord..x_destination).to_a
	end
		a.each do |obs|
			unless obs == x_coord && y_coord == y_destination
				return true if game.piece_at(obs, y_destination)
			end
		end
		return false
	end


  def obstructed_vert(x_destination, y_destination)
  	game = Game.where(:id => self.game_id).first
	if y_coord > y_destination
    	b = (y_destination..y_coord).to_a
    else
    	b = (y_coord..y_destination).to_a
    end
    	b.each do |obs|
    		unless x_coord == x_destination && obs == y_coord
    			return true if game.piece_at(x_destination, obs)
    		end
    	end
    	return false
 	end
 end

