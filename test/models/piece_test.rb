require 'test_helper'

class PieceTest < ActiveSupport::TestCase
  test 'create king' do
    game = create(:game)
    king = game.kings.first
    assert king.is_a?(King)
    king2 = King.find_by_game_id(game.id)
    assert king2.valid?
  end
  test 'create queen' do
    game = create(:game)
    queen = game.queens.first
    assert queen.is_a?(Queen)
    queen2 = Queen.find_by_game_id(game.id)
    assert queen2.valid?
  end
  test 'create bishop' do
    game = create(:game)
    bishop = game.bishops.first
    assert bishop.is_a?(Bishop)
    bishop2 = Bishop.find_by_game_id(game.id)
    assert bishop2.valid?
  end
  test 'create knight' do
    game = create(:game)
    knight = game.knights.first
    assert knight.is_a?(Knight)
    knight2 = Knight.find_by_game_id(game.id)
    assert knight2.valid?
  end
  test 'create rook' do
    game = create(:game)
    rook = game.rooks.first
    assert rook.is_a?(Rook)
    rook2 = Rook.find_by_game_id(game.id)
    assert rook2.valid?
  end
  test 'create pawn' do
    game = create(:game)
    pawn = game.pawns.first
    assert pawn.is_a?(Pawn)
    pawn2 = Pawn.find_by_game_id(game.id)
    assert pawn2.valid?
  end
  test 'create piece with bad type should fail' do
    game = create(:game)
    oops = build(:piece, type: 'Random')
    assert oops.invalid?
  end
  test 'king move is valid' do
    game = create(:game)
    king = game.kings.first
    assert_equal true, king.valid_move?((king.x_coord + 1), king.y_coord), '1 space on X axis'
    assert_equal true, king.valid_move?(king.x_coord, (king.y_coord + 1)), '1 space on Y axis'
    assert_equal true, king.valid_move?((king.x_coord + 1), (king.y_coord + 1)), '1 space on X and Y axis'
  end
  test 'king move is not valid' do
    game = create(:game)
    king = game.kings.first
    assert_equal false, king.valid_move?((king.x_coord + 2), king.y_coord), '2 spaces on X axis'
    assert_equal false, king.valid_move?(king.x_coord, (king.y_coord + 2)), '2 spaces on Y axis'
    assert_equal false, king.valid_move?((king.x_coord + 2), (king.y_coord + 2)), '2 spaces on X and Y axis'
  end
  test 'move is on board' do
    game = create(:game)
    king = game.kings.first
    assert_equal king.on_board?(7, 7), true, 'king should be on board'
  end
  test 'move is not on board' do
    game = create(:game)
    king = game.kings.first
    assert_equal king.on_board?(8, 8), false, 'king should not be on board'
  end
  test 'Rook glyph is tower' do
    rook = create(:rook)
    assert_equal 'tower', rook.glyph, 'Rook glyph should be tower'
  end
  test 'King glyph is king' do
    king = create(:king)
    assert_equal 'king', king.glyph, 'King glyph should be king'
  end
end
