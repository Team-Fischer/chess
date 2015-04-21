class Game < ActiveRecord::Base
	has_many :users
	has_many :pieces
	
	def initialize
		# Black pieces
		Rook.create(color: black, x_coord: 0, y_coord: 0)
		Knight.create(color: black, x_coord: 1, y_coord: 0)	
		Bishop.create(color: black, x_coord: 2, y_coord: 0)
		Queen.create(color: black, x_coord: 3, y_coord: 0)
		King.create(color: black, x_coord: 4, y_coord: 0)
		Knight.create(color: black, x_coord: 5, y_coord: 0)
		Bishop.create(color: black, x_coord: 6, y_coord: 0)
		Rook.create(color: black, x_coord: 7, y_coord: 0)

		Pawn.create(color: black, x_coord: 0, y_coord: 1)
		Pawn.create(color: black, x_coord: 1, y_coord: 1)	
		Pawn.create(color: black, x_coord: 2, y_coord: 1)
		Pawn.create(color: black, x_coord: 3, y_coord: 1)
		Pawn.create(color: black, x_coord: 4, y_coord: 1)
		Pawn.create(color: black, x_coord: 5, y_coord: 1)
		Pawn.create(color: black, x_coord: 6, y_coord: 1)
		Pawn.create(color: black, x_coord: 7, y_coord: 1)

		
		# White pieces
		Rook.create(color: git brablack, x_coord: 0, y_coord: 7)
		Knight.create(color: black, x_coord: 1, y_coord: 7)	
		Bishop.create(color: black, x_coord: 2, y_coord: 7)
		Queen.create(color: black, x_coord: 3, y_coord: 7)
		King.create(color: black, x_coord: 4, y_coord: 7)
		Knight.create(color: black, x_coord: 5, y_coord: 7)
		Bishop.create(color: black, x_coord: 6, y_coord: 7)
		Rook.create(color: black, x_coord: 7, y_coord: 7)

		Pawn.create(color: black, x_coord: 0, y_coord: 6)
		Pawn.create(color: black, x_coord: 1, y_coord: 6)	
		Pawn.create(color: black, x_coord: 2, y_coord: 6)
		Pawn.create(color: black, x_coord: 3, y_coord: 6)
		Pawn.create(color: black, x_coord: 4, y_coord: 6)
		Pawn.create(color: black, x_coord: 5, y_coord: 6)
		Pawn.create(color: black, x_coord: 6, y_coord: 6)
		Pawn.create(color: black, x_coord: 7, y_coord: 6)
	end

end
