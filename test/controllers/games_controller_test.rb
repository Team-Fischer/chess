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

  test "can get games index" do
    get :index
    assert_response :success
    assert_template :index
    refute_nil assigns(:games)
  end

  test "can show game logged in" do
    user = create(:user)
    sign_in user
    game = create(:game, :white_user_id => user.id)

    get :show, :id => game.id
    assert_response :success
    assert_template :show
    refute_nil assigns(:game)
  end

  test "can't show game not logged in" do
    user = create(:user)
    game = create(:game, :white_user_id => user.id)

    get :show, :id => game.id
    assert_redirected_to new_user_session_path
  end

  test "get 404 for invalid game id" do
    user = create(:user)
    sign_in user

    get :show, :id => -1
    assert_response :not_found
  end
end
