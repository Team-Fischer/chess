require 'test_helper'

class PieceTest < ActiveSupport::TestCase

  test "create king" do
    game = create(:game)
    king = create(:king, :game_id => game.id)
    assert king.is_a?(King)

    king2 = King.find_by_game_id(game.id)
    assert king2.valid?

  end

  test "create queen" do
    game = create(:game)
    queen = create(:queen, :game_id => game.id)
    assert queen.is_a?(Queen)

    queen2 = Queen.find_by_game_id(game.id)
    assert queen2.valid?

  end

  test "create bishop" do
    game = create(:game)
    bishop = create(:bishop, :game_id => game.id)
    assert bishop.is_a?(Bishop)

    bishop2 = Bishop.find_by_game_id(game.id)
    assert bishop2.valid?

  end

  test "create knight" do
    game = create(:game)
    knight = create(:knight, :game_id => game.id)
    assert knight.is_a?(Knight)

    knight2 = Knight.find_by_game_id(game.id)
    assert knight2.valid?

  end

  test "create rook" do
    game = create(:game)
    rook = create(:rook, :game_id => game.id)
    assert rook.is_a?(Rook)

    rook2 = Rook.find_by_game_id(game.id)
    assert rook2.valid?

  end

  test "create pawn" do
    game = create(:game)
    pawn = create(:pawn, :game_id => game.id)
    assert pawn.is_a?(Pawn)

    pawn2 = Pawn.find_by_game_id(game.id)
    assert pawn2.valid?

  end

  test "create piece with bad type should fail" do
    game = create(:game)
    oops = build(:piece, :type => "Random")

    assert oops.invalid?

  end
  
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
  
  test "is obstructed" do
    game = create(:game)
    king = game.pieces.kings.where(:color => 'black').first
  
    assert_equal true, king.is_obstructed?(4,1)
  end
  
    test "is not obstructed" do
    game = create(:game)
    king = game.pieces.kings.where(:color => 'black').first
  
    assert_equal false, king.is_obstructed?(4,4)
  end
end
