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

  test 'game is full' do
    game = create(:game, :white_user_id => 1, :black_user_id => 2)
    assert game.is_full?, 'the game is full'
  end

  test 'game is not full' do
    game = create(:game, :white_user_id => 1)
    refute game.is_full?, 'the game is not full'
  end    

  test 'piece is at 0,0' do
    game = create(:game)
    assert game.piece_at(0,0)
  end

  test 'piece not at 4,4' do
    game = create(:game)
    refute game.piece_at(4,4)
  end

  test 'First turn goes to white' do
    game = create(:game)
    start = game.player_turn
    assert_equal "white", start, "White has first turn"
  end

  test 'Assign pieces to players' do
    game = create(:game, :white_user_id => 1, :black_user_id => 2)
    assert_equal 16, game.pieces.where(user_id: 1).count, '16 white pieces should connect to white_user_id (1)'
    assert_equal 16, game.pieces.where(user_id: 2).count, '16 black pieces should connect to black_user_id (2)'
  end  

end
