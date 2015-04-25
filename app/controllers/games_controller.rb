class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def show
    @rows = 8
    @columns = 8
  end

  def create
    @game = Game.create
    redirect_to game_path(@game)
  end


end
