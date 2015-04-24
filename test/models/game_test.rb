require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'create game' do
    game = create(:game)
    game.populate_board

    assert_equal game.pieces.count, 32, 'populate_board should create 32 total pieces'
    assert_equal game.pieces.where(:color => 'black').count, 16, 'populate_board should create 16 black pieces'
    assert_equal game.pieces.where(:color => 'white').count, 16, 'populate_board should create 16 white pieces'
    assert_equal game.pieces.where(:type => 'Rook').count, 4, 'populate_board should create 4 Rooks'
    assert_equal game.pieces.where(:type => 'Knight').count, 4, 'populate_board should create 4 Knights'
    assert_equal game.pieces.where(:type => 'Bishop').count, 4, 'populate_board should create 4 Bishops'
    assert_equal game.pieces.where(:type => 'Pawn').count, 16, 'populate_board should create 16 Pawns'
    assert_equal game.pieces.where(:type => 'King').count, 2, 'populate_board should create 2 Kings'
    assert_equal game.pieces.where(:type => 'Queen').count, 2, 'populate_board should create 4 Queens'   
  end
end
