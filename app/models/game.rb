class Game < ActiveRecord::Base
	has_many :users
	has_many :pieces
	
end
