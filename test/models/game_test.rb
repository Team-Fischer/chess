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

  test 'should not be in check' do
    game = create(:game)

    refute game.in_check?('white')
  end

  test 'should be in check' do
    game = create(:game)
    queen = game.queens.where(:color => 'black').first
    white_pawn1 = game.pawns.where(:color => 'white', :x_coord => 5).first
    white_pawn2 = game.pawns.where(:color => 'white', :x_coord => 6).first
    black_pawn = game.pawns.where(:color => 'black', :x_coord => 4).first

    # move pieces to 'fools mate' locations - http://en.wikipedia.org/wiki/Fool%27s_mate
    white_pawn1.move_to(5, 5)
    black_pawn.move_to(4, 3)
    white_pawn2.move_to(6, 4)
    queen.move_to(7, 4)

    assert game.in_check?('white')
  end

  test 'cannot move from check' do
    game = create(:game)
    queen = game.queens.where(:color => 'black').first
    white_pawn1 = game.pawns.where(:color => 'white', :x_coord => 5).first
    white_pawn2 = game.pawns.where(:color => 'white', :x_coord => 6).first
    black_pawn = game.pawns.where(:color => 'black', :x_coord => 4).first

    # move pieces to 'fools mate' locations - http://en.wikipedia.org/wiki/Fool%27s_mate
    white_pawn1.move_to(5, 5)
    black_pawn.move_to(4, 3)
    white_pawn2.move_to(6, 4)
    queen.move_to(7, 4)

    refute game.can_move_from_check?('white'), "king cannot uncheck"
  end

  test 'can move from check' do
    game = create(:game)
    queen = game.queens.where(:color => 'black').first
    white_pawn1 = game.pawns.where(:color => 'white', :x_coord => 5).first
    white_pawn2 = game.pawns.where(:color => 'white', :x_coord => 6).first
    white_pawn3 = game.pawns.where(:color => 'white', :x_coord => 4).first
    black_pawn = game.pawns.where(:color => 'black', :x_coord => 4).first

    # position pieces for test
    white_pawn1.move_to(5, 5)
    black_pawn.move_to(4, 3)
    white_pawn2.move_to(6, 4)
    queen.move_to(7, 4)
    white_pawn3.move_to(4, 4)

    assert game.can_move_from_check?('white'), 'king can uncheck'
  end

  test 'cannot capture from check' do
    game = create(:game)
    queen = game.queens.where(:color => 'black').first
    white_pawn1 = game.pawns.where(:color => 'white', :x_coord => 5).first
    white_pawn2 = game.pawns.where(:color => 'white', :x_coord => 6).first
    black_pawn = game.pawns.where(:color => 'black', :x_coord => 4).first

    # position pieces for test
    white_pawn1.move_to(5, 5)
    black_pawn.move_to(4, 3)
    white_pawn2.move_to(6, 4)
    queen.move_to(7, 4)
    # destroy these for simpler test
    game.rooks.where(:color => 'white', :x_coord => 7).first.destroy
    game.pawns.where(:color => 'white', :x_coord => 7).first.destroy
    # need list of checking pieces
    check_pieces = game.in_check?('white')

    refute game.can_capture_from_check?('white', check_pieces), "king cannot uncheck"
  end

  test 'can capture from check' do
    game = create(:game)
    queen = game.queens.where(:color => 'black').first
    white_pawn1 = game.pawns.where(:color => 'white', :x_coord => 5).first
    white_pawn2 = game.pawns.where(:color => 'white', :x_coord => 6).first
    black_pawn = game.pawns.where(:color => 'black', :x_coord => 4).first

    # position pieces for test
    white_pawn1.move_to(5, 5)
    black_pawn.move_to(4, 3)
    white_pawn2.move_to(6, 4)
    queen.move_to(7, 4)
    # destroy this for simpler test
    game.pawns.where(:color => 'white', :x_coord => 7).first.destroy
    # need list of checking pieces
    check_pieces = game.in_check?('white')

    assert game.can_capture_from_check?('white', check_pieces), "king can uncheck"
  end
end
