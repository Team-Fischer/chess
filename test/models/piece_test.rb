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
    color = 'black'
    king = @game.kings.find_by_color(color)
    king.move_to(4, 4)
    # remove pieces that are obstructions
#    @game.pieces.where(:color => color, :x_coord => 5).destroy_all
#    @game.pawns.where(:color => color, :x_coord => 4).destroy_all

    assert king.valid_move?((king.x_coord + 1), king.y_coord), '1 space on X axis'
    assert king.valid_move?(king.x_coord, (king.y_coord + 1)), '1 space on Y axis'
    assert king.valid_move?((king.x_coord + 1), (king.y_coord + 1)), '1 space on X and Y axis'
  end

  test 'king move is not valid' do
    king = @game.kings.first
    refute king.valid_move?((king.x_coord + 2), king.y_coord), '2 spaces on X axis'
    refute king.valid_move?(king.x_coord, (king.y_coord + 2)), '2 spaces on Y axis'
    refute king.valid_move?((king.x_coord + 2), (king.y_coord + 2)), '2 spaces on X and Y axis'
  end

  test 'king move is obstructed' do
    king = @game.kings.find_by_color('black')
    refute king.valid_move?((king.x_coord + 1), king.y_coord), '1 spaces on X axis'
    refute king.valid_move?(king.x_coord, (king.y_coord + 1)), '1 spaces on Y axis'
    refute king.valid_move?((king.x_coord + 1), (king.y_coord + 1)), '1 spaces on X and Y axis'
  end

  test 'rook move is valid' do
    rook = @game.rooks.first
    assert rook.valid_move?((rook.x_coord + 2), rook.y_coord), 'move on x axis'
    assert rook.valid_move?(rook.x_coord, (rook.y_coord + 2)), 'move on y axis'
  end

  test 'rook move is not valid' do
    rook = @game.rooks.first
    refute rook.valid_move?((rook.x_coord + 2), (rook.y_coord + 3)), 'move on x and y axis'
  end

  test 'bishop move is valid' do
    bishop = @game.bishops.where(:color => 'black', :x_coord => 2).first
    # remove obstructing pawn
    @game.pawns.where(:color => 'black', :x_coord => 3).destroy_all
    assert bishop.valid_move?((bishop.x_coord + 2), bishop.y_coord + 2), 'move is diag'
  end

  test 'bishop move is not valid' do
    bishop = @game.bishops.first
    refute bishop.valid_move?(bishop.x_coord, (bishop.y_coord + 3)), 'move on x axis'
  end

  test 'bishop move is obstructed' do
    bishop = @game.bishops.first
    refute bishop.valid_move?(bishop.x_coord + 2, (bishop.y_coord + 2)), 'move on x axis'
  end

  test 'knight move is valid' do
    knight = @game.knights.first
    assert knight.valid_move?((knight.x_coord + 2), knight.y_coord + 1), 'move 2 spaces up and 1 to the side'
    assert knight.valid_move?((knight.x_coord + 1), knight.y_coord + 2), 'move 1 space up and 2 to the side'
  end

  test 'knight move is not valid' do
    knight = @game.knights.first
    refute knight.valid_move?((knight.x_coord + 2), knight.y_coord + 2), 'knight should not be able to move 2 spaces both ways'
    refute knight.valid_move?((knight.x_coord + 0), knight.y_coord + 2), 'knight should not be able to move directly horizontally/vertically'
  end

  test 'queen move is valid' do
    queen = @game.queens.first
    queen.move_to(4, 4)
    assert queen.valid_move?((queen.x_coord + 1), (queen.y_coord + 1)), 'queen move diagonal'
    assert queen.valid_move?((queen.x_coord + 3), queen.y_coord), 'queen move horizontal'
    assert queen.valid_move?(queen.x_coord, (queen.y_coord + 2)), 'queen move vertical'
  end

  test 'queen move is not valid' do
    queen = @game.queens.first
    refute queen.valid_move?((queen.x_coord + 1), (queen.y_coord + 2)), "queen can't move like knight"
  end

  test 'pawn move is valid' do
    pawn = @game.pawns.first
    assert pawn.valid_move?(pawn.x_coord, (pawn.y_coord + 2))
    pawn.moved = true
    assert pawn.valid_move?(pawn.x_coord, (pawn.y_coord + 1))
  end

  test 'pawn move is invalid' do
    pawn = @game.pawns.first
    refute pawn.valid_move?((pawn.x_coord + 1), pawn.y_coord)
    pawn.moved = true
    refute pawn.valid_move?(pawn.x_coord, (pawn.y_coord + 2))
  end

  test 'pawn move diag' do 
    black_pawn = @game.pawns.where(:color => 'black', :x_coord => 2, :y_coord => 2).first 
    white_pawn = @game.pawns.where(:color => 'white', :x_coord => 3, :y_coord => 3).first 
    ##Need to write test (JL)

    
  end



  test 'pawn back move is invalid' do
    pawn = @game.pawns.first
    pawn.moved = true
    refute pawn.valid_move?(pawn.x_coord, (pawn.y_coord - 1))
    pawn.moved = true
    refute pawn.valid_move?(pawn.x_coord, (pawn.y_coord - 2))
  end

  test 'pawn capture diagonal' do
    black_pawn = @game.pawns.where(:color => 'black', :x_coord => 0).first
    white_pawn = @game.pawns.where(:color => 'white', :x_coord => 1).first
    
    assert black_pawn.move_to(black_pawn.y_coord + 2, black_pawn.x_coord)
    assert white_pawn.move_to(white_pawn.y_coord - 2, white_pawn.x_coord)
    assert black_pawn.move_to((black_pawn.y_coord + 1), (black_pawn.x_coord + 1))
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

  test 'king moves forward' do
    king = create(:king, x_coord: 4, y_coord: 0)
    king.move_to(4, 1)
    assert_equal 4, king.x_coord, 'King stays on the same column while moving up a row'
    assert_equal 1, king.y_coord, 'King should be able to move forward up and down'
  end

  test 'queen obstructed piece' do
    queen = @game.queens.find_by_color('black')
    queen.update_attributes(x_coord: 3, y_coord: 3)

    #diagonal
    refute queen.obstructed_piece?(5, 5)
    assert queen.obstructed_piece?(1, 1)

    #vertical
    refute queen.obstructed_piece?(3, 4)
    assert queen.obstructed_piece?(3, 1)

    #horizontal
    refute queen.obstructed_piece?(6, 3)
    queen.update_attributes(x_coord: 3, y_coord: 0)
    assert queen.obstructed_piece?(6, 0)
  end

  test 'knight obstructed piece' do
    knight = @game.knights.first
    knight.update_attributes(x_coord: 0, y_coord: 1, color: 'black')

    pawn = @game.pawns.first
    pawn.update_attributes(x_coord: 2, y_coord: 0, color: 'black')

    assert knight.obstructed_piece?(2, 0)
  end
end
