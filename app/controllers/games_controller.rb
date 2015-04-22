class GamesController < ApplicationController

	def new
		@game = Game.new
	end

	def show
		
	end

	def create
		@game = Game.create
		redirect_to game_path(@game)
	end	


end
