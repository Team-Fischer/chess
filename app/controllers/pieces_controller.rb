class PiecesController < ApplicationController

  def create

  end

  def destroy

  end

  def update

  end

  private

    def piece_params
      params.require(:piece).permit(:color, :x_coord, :y_coord)
    end

end
