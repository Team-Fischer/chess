require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'create game' do
    game = create(:game)
    game.populate_board

    assert_equal game.pieces.count, 32, 'populate_board should create 32 total pieces'
    assert_equal game.pieces.where(:color => 'black').count, 16, 'populate_board should create 16 black pieces'
    assert_equal game.pieces.where(:color => 'white').count, 16, 'populate_board should create 16 white pieces'
    assert_equal game.rooks.count, 4, 'populate_board should create 4 Rooks'
    assert_equal game.knights.count, 4, 'populate_board should create 4 Knights'
    assert_equal game.bishops.count, 4, 'populate_board should create 4 Bishops'
    assert_equal game.pawns.count, 16, 'populate_board should create 16 Pawns'
    assert_equal game.kings.count, 2, 'populate_board should create 2 Kings'
    assert_equal game.queens.count, 2, 'populate_board should create 2 Queens'   
  end
end
