class PiecesController < ApplicationController
  def create
  end

  def destroy
  end

  def update
    @piece = Piece.where(:id => params[:id]).first

    @piece.update_attributes(:x_coord => params[:x_coord], :y_coord => params[:y_coord])
    if @piece.valid?
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
