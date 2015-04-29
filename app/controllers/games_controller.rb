class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def show
    @game = Game.where(:id => params[:id]).first
  end

  def create
    @game = Game.create
    redirect_to game_path(@game)
  end
end
