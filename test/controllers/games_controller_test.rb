require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "not logged in create game" do
    post :create, { :game => { } }
    assert_redirected_to new_user_session_path
  end
  
  test "Logged in create game" do
    user = create(:user)
    sign_in user
    assert_difference 'Game.count' do
      post :create, { :game => { :white_user_id => user.id } }
    end
    assert_redirected_to game_path(Game.last.id)
  end
  
  # TODO: Ask Ken about how to write this test
  # test "join not logged in" do
  #   white_user = create(:user)
  #   black_user = create(:user)
  #   sign_in white_user
  #   post :create, { :game => { :white_user_id => white_user.id } }

  #   put :update, { :game => { :id => Game.last.id,
  #                             :black_user_id => black_user.id
  #                           }
  #               }
  #   assert_redirected_to new_user_session_path
  # end
  
  # test "Join logged in" do
  #   user = create(:user)
  #   game = create(:game)
  #   sign_in user
  #   put :update, { :game => { :id => Game.last.id,
  #                           :black_user_id => user.id 
  #                         }
  #               }
  #   assert_redirected_to game_path(Game.last.id)             
  # end
end
