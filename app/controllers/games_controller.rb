class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def show
    @game = Game.where(:id => params[:id]).first
    # @pieces = []
    # @game.pieces.each { |piece| @pieces << piece.attributes }
  end

  def create
    @game = Game.create
    redirect_to game_path(@game)
  end

  private

  def games_params
    params.require(:game).permit(:black_user_id, :white_user_id)
  end

end
