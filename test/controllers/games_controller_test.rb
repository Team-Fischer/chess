require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "not logged in create game" do
    post :create, { :game => { } }
    assert_redirected_to new_user_session_path
  end
  
  test "logged in create game" do
    user = create(:user)
    sign_in user
    assert_difference 'Game.count' do
      post :create, { :game => { :white_user_id => user.id } }
    end
    assert_redirected_to game_path(Game.last.id)
  end
  
  test "join not logged in" do
    white_user = create(:user)
    black_user = create(:user)
    game = create(:game, :white_user_id => white_user.id)

    put :update, :id => game.id, :game => { :black_user_id => black_user.id }
    assert_redirected_to new_user_session_path
  end
  
  test "join logged in" do
    white_user = create(:user)
    black_user = create(:user)
    game = create(:game, :white_user_id => white_user.id)
    sign_in black_user

    put :update, :id => game.id, :game => { :black_user_id => black_user.id }
    assert_redirected_to game_path(Game.last.id)
  end

  test "join same user should fail" do
    white_user = create(:user)
    game = create(:game, :white_user_id => white_user.id)
    sign_in white_user

    put :update, :id => game.id, :game => { :black_user_id => white_user.id }
    assert_redirected_to games_path
    assert_includes flash[:alert], "You can't play against yourself!"
  end
end
