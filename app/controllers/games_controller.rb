class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def show
    @game = Game.where(:id => params[:id]).first
  end

  def create
    @game = Game.create(:white_user_id => current_user)
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(:black_user_id => current_user)    
  end

  private

  def games_params
    params.require(:game).permit(:black_user_id, :white_user_id)
  end

end
