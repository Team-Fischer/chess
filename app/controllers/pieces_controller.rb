class PiecesController < ApplicationController
  def create
  end

  def destroy
  end

  def update
    @piece = Piece.where(:id => params[:id]).first
    x_dest = params[:x_coord]
    y_dest = params[:y_coord]
    
    if @piece.valid_move?(x_dest, y_dest)
      @piece.move_to(x_dest, y_dest)
      render :text => :success
    else
      render :text => :unprocessable_entity
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:color, :x_coord, :y_coord)
  end
end
