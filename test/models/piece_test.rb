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
<<<<<<< HEAD

  test 'bishop move is valid' do
    bishop = @game.bishops.first
    assert_equal true, bishop.valid_move?((bishop.x_coord + 2), bishop.y_coord + 2), 'move is diag'
  end

  test 'bishop move is not valid' do
    bishop = @game.bishops.first
    assert_equal false, bishop.valid_move?(bishop.x_coord, (bishop.y_coord + 3)), 'move on x axis'
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
=======
  
  test "king move is valid" do
    game = create(:game)
    king = create(:king, :game_id => game.id)
    
    assert_equal king.valid_move?(2, 1), true, "King should be able to move 1 space on X axis" 
    assert_equal king.valid_move?(1, 2), true, "King should be able to move 1 space on Y axis" 
    assert_equal king.valid_move?(2, 2), true, "King should be able to move 1 space on X and Y axis"
  end
  
  test "king move is not valid" do
    game = create(:game)
    king = create(:king, :game_id => game.id)
    
    assert_equal king.valid_move?(3, 1), false, "King should not be able to move 2 spaces on X axis" 
    assert_equal king.valid_move?(1, 3), false, "King should not be able to move 2 spaces on Y axis" 
    assert_equal king.valid_move?(3, 3), false, "King should not be able to move 2 spaces on X and Y axis"
  end
  
  test "move is on board" do
    game = create(:game)
    king = create(:king, :game_id => game.id)
    
    assert_equal king.on_board?(7, 7), true, "king should be on board"
  end
  
  test "move is not on board" do
    game = create(:game)
    king = create(:king, :game_id => game.id)
  
    assert_equal king.on_board?(8, 8), false, "king should not be on board"
  end
  
  test "check king obstruction" do
    game = create(:game)
    king = game.pieces.kings.where(:color => 'black').first
  
    assert_equal true, king.is_obstructed?(4,1)
    assert_equal false, king.is_obstructed?(4,4)
  end
  
  test "check pawn obstruction" do
    game = create(:game)
    pawn = game.pieces.pawns.where(:x_coord => 0, :y_coord => 1).first

    assert_equal true, pawn.is_obstructed?(0,6)
    assert_equal false, pawn.is_obstructed?(0,2)
  end
  
  test "check knight obstruction" do
    game = create(:game)
    knight = game.pieces.knights.where(:x_coord => 5, :y_coord => 7).first

    assert_equal false, knight.is_obstructed?(0,2)
  end
  
  test "check rook obstruction" do
    game = create(:game)
    rook = game.pieces.rooks.where(:x_coord => 0, :y_coord => 0).first
    assert_equal true, rook.is_obstructed?(0, 1)
    assert_equal true, rook.is_obstructed?(0, 4)
  end
  
    test "check bishop obstruction" do
    game = create(:game)
    bishop = game.pieces.bishops.where(:x_coord => 2, :y_coord => 7).first
    assert_equal true, bishop.is_obstructed?(3, 1)
    assert_equal true, bishop.is_obstructed?(6,3)
  end
  
  test "check queen obstruction" do
    game = create(:game)
    queen = game.pieces.queens.where(:color => 'black').first
    queen.update_attributes(:x_coord => 1, :y_coord => 2)
#x, y >0
    assert_equal false, queen.is_obstructed?(3,4)
    assert_equal true, queen.is_obstructed?(6,7)
#x > 0, y = 0
    queen.update_attributes(:x_coord => 3, :y_coord => 1)
    assert_equal false, queen.is_obstructed?(3, 1)
    queen.update_attributes(:x_coord => 1, :y_coord => 1)
    assert_equal true, queen.is_obstructed?(2, 1)
#x > 0, y < 0
    assert_equal false, queen.is_obstructed?(2, 2)
#x, y < 0
    assert_equal false, queen.is_obstructed?(1, 2)
# x < 0, y = 0    
    assert_equal false, queen.is_obstructed?(0, 3)
>>>>>>> 6f5fff71e3c14d5e2a652c24bc74908b919e7f6f
  end

end
