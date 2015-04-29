require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'create game' do
    game = create(:game)
    assert_equal 32, game.pieces.count, 'populate_board should create 32 pieces'
    assert_equal 16, game.pieces.where(:color => 'black').count, 'populate_board should create 16 black pieces'
    assert_equal 16, game.pieces.where(:color => 'white').count, 'populate_board should create 16 white pieces'
    assert_equal 4, game.rooks.count, 'populate_board should create 4 Rooks'
    assert_equal 4, game.knights.count, 'populate_board should create 4 Knights'
    assert_equal 4, game.bishops.count, 'populate_board should create 4 Bishops'
    assert_equal 16, game.pawns.count, 'populate_board should create 16 Pawns'
    assert_equal 2, game.kings.count, 'populate_board should create 2 Kings'
    assert_equal 2, game.queens.count, 'populate_board should create 2 Queens'
  end
end
