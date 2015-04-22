class Game < ActiveRecord::Base
  has_many :users
  has_many :pieces
  delegate :kings, :queens, :bishops, :knights, :rooks, :pawns, to: :pieces
	
	def populate_board
		# Black pieces
		self.rooks.create(color: "black", x_coord: 0, y_coord: 0)
		self.knights.create(color: "black", x_coord: 1, y_coord: 0)	
		self.bishops.create(color: "black", x_coord: 2, y_coord: 0)
		self.queens.create(color: "black", x_coord: 3, y_coord: 0)
		self.kings.create(color: "black", x_coord: 4, y_coord: 0)
		self.knights.create(color: "black", x_coord: 5, y_coord: 0)
		self.bishops.create(color: "black", x_coord: 6, y_coord: 0)
		self.rooks.create(color: "black", x_coord: 7, y_coord: 0)
		self.pawns.create(color: "black", x_coord: 0, y_coord: 1)
		self.pawns.create(color: "black", x_coord: 1, y_coord: 1)	
		self.pawns.create(color: "black", x_coord: 2, y_coord: 1)
		self.pawns.create(color: "black", x_coord: 3, y_coord: 1)
		self.pawns.create(color: "black", x_coord: 4, y_coord: 1)
		self.pawns.create(color: "black", x_coord: 5, y_coord: 1)
		self.pawns.create(color: "black", x_coord: 6, y_coord: 1)
		self.pawns.create(color: "black", x_coord: 7, y_coord: 1)
		# White pieces
		self.rooks.create(color: "white", x_coord: 0, y_coord: 7)
		self.knights.create(color: "white", x_coord: 1, y_coord: 7)	
		self.bishops.create(color: "white", x_coord: 2, y_coord: 7)
		self.queens.create(color: "white", x_coord: 3, y_coord: 7)
		self.kings.create(color: "white", x_coord: 4, y_coord: 7)
		self.knights.create(color: "white", x_coord: 5, y_coord: 7)
		self.bishops.create(color: "white", x_coord: 6, y_coord: 7)
		self.rooks.create(color: "white", x_coord: 7, y_coord: 7)
		self.pawns.create(color: "white", x_coord: 0, y_coord: 6)
		self.pawns.create(color: "white", x_coord: 1, y_coord: 6)	
		self.pawns.create(color: "white", x_coord: 2, y_coord: 6)
		self.pawns.create(color: "white", x_coord: 3, y_coord: 6)
		self.pawns.create(color: "white", x_coord: 4, y_coord: 6)
		self.pawns.create(color: "white", x_coord: 5, y_coord: 6)
		self.pawns.create(color: "white", x_coord: 6, y_coord: 6)
		self.pawns.create(color: "white", x_coord: 7, y_coord: 6)
	end
end
