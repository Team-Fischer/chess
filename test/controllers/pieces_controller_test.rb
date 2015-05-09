require 'test_helper'

class PiecesControllerTest < ActionController::TestCase
  test "should move piece" do
    game = create(:game)
    pawn = game.pawns.first

    put :update, :game_id => game.id,
                 :id => pawn.id,
                 :x_coord => pawn.x_coord,
                 :y_coord => pawn.y_coord + 1

    assert_response :success
  end

  test "should not move piece" do
    game = create(:game)
    pawn = game.pawns.first

    put :update, :game_id => game.id,
                 :id => pawn.id,
                 :x_coord => pawn.x_coord,
                 :y_coord => pawn.y_coord + 3

    assert_response :unprocessable_entity
  end
end
