require 'test_helper'

class PieceTest < ActiveSupport::TestCase
  def setup
    @game = create(:game)
  end
  test 'create king' do
    king = @game.kings.first
    assert king.is_a?(King)
    king2 = King.find_by_game_id(@game.id)
    assert king2.valid?
  end

  test 'create queen' do
    queen = @game.queens.first
    assert queen.is_a?(Queen)
    queen2 = Queen.find_by_game_id(@game.id)
    assert queen2.valid?
  end

  test 'create bishop' do
    bishop = @game.bishops.first
    assert bishop.is_a?(Bishop)
    bishop2 = Bishop.find_by_game_id(@game.id)
    assert bishop2.valid?
  end

  test 'create knight' do
    knight = @game.knights.first
    assert knight.is_a?(Knight)
    knight2 = Knight.find_by_game_id(@game.id)
    assert knight2.valid?
  end

  test 'create rook' do
    rook = @game.rooks.first
    assert rook.is_a?(Rook)
    rook2 = Rook.find_by_game_id(@game.id)
    assert rook2.valid?
  end

  test 'create pawn' do
    pawn = @game.pawns.first
    assert pawn.is_a?(Pawn)
    pawn2 = Pawn.find_by_game_id(@game.id)
    assert pawn2.valid?
  end

  test 'create piece with bad type should fail' do
    oops = build(:piece, type: 'Random')
    assert oops.invalid?
  end

  test 'king move is valid' do
    king = @game.kings.first
    assert_equal true, king.valid_move?((king.x_coord + 1), king.y_coord), '1 space on X axis'
    assert_equal true, king.valid_move?(king.x_coord, (king.y_coord + 1)), '1 space on Y axis'
    assert_equal true, king.valid_move?((king.x_coord + 1), (king.y_coord + 1)), '1 space on X and Y axis'
  end

  test 'king move is not valid' do
    king = @game.kings.first
    assert_equal false, king.valid_move?((king.x_coord + 2), king.y_coord), '2 spaces on X axis'
    assert_equal false, king.valid_move?(king.x_coord, (king.y_coord + 2)), '2 spaces on Y axis'
    assert_equal false, king.valid_move?((king.x_coord + 2), (king.y_coord + 2)), '2 spaces on X and Y axis'
  end

  test 'rook move is valid' do
    rook = @game.rooks.first
    assert_equal true, rook.valid_move?((rook.x_coord + 2), rook.y_coord), 'move on x axis'
    assert_equal true, rook.valid_move?(rook.x_coord, (rook.y_coord + 2)), 'move on y axis'
  end

  test 'rook move is not valid' do
    rook = @game.rooks.first
    assert_equal false, rook.valid_move?((rook.x_coord + 2), (rook.y_coord + 3)), 'move on x and y axis'
  end

  test 'knight move is valid' do
    knight = @game.knights.first
    assert_equal true, knight.valid_move?((knight.x_coord + 2), knight.y_coord + 1), 'move 2 spaces up and 1 to the side'
    assert_equal true, knight.valid_move?((knight.x_coord + 1), knight.y_coord + 2), 'move 1 space up and 2 to the side'
  end

  test 'knight move is not valid' do
    knight = @game.knights.first
    assert_equal false, knight.valid_move?((knight.x_coord + 2), knight.y_coord + 2), 'knight should not be able to move 2 spaces both ways'
    assert_equal false, knight.valid_move?((knight.x_coord + 0), knight.y_coord + 2), 'knight should not be able to move directly horizontally/vertically'
  end

  test 'move is on board' do
    king = @game.kings.first
    assert_equal king.on_board?(7, 7), true, 'king should be on board'
  end

  test 'move is not on board' do
    king = @game.kings.first
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
