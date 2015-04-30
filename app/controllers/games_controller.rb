class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def show
    @game = Game.where(:id => params[:id]).first
    @pieces = Array.new(8) { Array.new(8) }
    @game.pieces.each do |piece|
      @pieces[piece.x_coord][piece.y_coord] = piece
    end
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
