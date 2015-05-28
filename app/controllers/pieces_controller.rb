class PiecesController < ApplicationController
  def create
  end

  def destroy
  end

  def update
    piece = Piece.where(:id => params[:id]).first
    game = Game.where(:id => params[:game_id]).first
    x_dest = params[:x_coord].to_i
    y_dest = params[:y_coord].to_i

    if piece.valid_move?(x_dest, y_dest)
      piece.capture(x_dest, y_dest)
      piece.move_to(x_dest, y_dest)
      game.in_check?(piece.opposite)
      game.next_turn(piece.opposite)
      game.player_turn
      game.update_realtime
      render :json => :success
    else
      render :text => 'invalid', :status => :unprocessable_entity
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:color, :x_coord, :y_coord)
  end
end
