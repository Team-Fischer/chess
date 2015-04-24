require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'create game' do
    game = create(:game)
    game.populate_board

    assert_equal game.pieces.count, 32, 'populate_board should create 32 total pieces'
    assert_equal game.pieces.where(:color => 'black').count, 16, 'populate_board should create 16 black pieces'
    assert_equal game.pieces.where(:color => 'white').count, 16, 'populate_board should create 16 white pieces'
  end
  
  
end
