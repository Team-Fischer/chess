class GamesController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :update, :show]

  def index
    @games = Game.all
  end
  
  def new
    @game = Game.new
  end

  def show
    @game = Game.where(:id => params[:id]).first
    render :text => 'That game does not exist.', :status => :not_found if @game.blank?
  end

  def create
    @game = Game.create(:white_user_id => current_user.id)
    redirect_to game_path(@game)
  end

  def update
    @game = Game.find(params[:id])
    if @game.white_user_id == current_user.id
      flash[:alert] = "You can't play against yourself!"
      redirect_to games_path
    else
      @game.update_attributes(:black_user_id => current_user.id)
      @game.assign_pieces
      redirect_to game_path(@game)
    end
    @game.next_turn
  end

  private

  def games_params
    params.require(:game).permit(:black_user_id, :white_user_id)
  end
end
