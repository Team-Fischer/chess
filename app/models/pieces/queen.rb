class Queen < Piece
  def valid_move?(x_destination, y_destination)
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs

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
    puts @spaces.inspect
    @spaces.each do |obs|
    	unless obs[0] == x_coord && obs[1] == y_coord
        	return true if game.piece_at(obs[0], obs[1])
    	end
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

end
