class Game < ActiveRecord::Base
  after_create :populate_board
  after_create :first_move

  has_many :users
  has_many :pieces, :dependent => :destroy
  delegate :kings, :queens, :bishops, :knights, :rooks, :pawns, to: :pieces

  def populate_board
    %w(black white).each do |color|
      if color == 'black'
        y_pawns = 1
        y_others = 0
      else
        y_pawns = 6
        y_others = 7
      end
      rooks.create(color: color, x_coord: 0, y_coord: y_others)
      knights.create(color: color, x_coord: 1, y_coord: y_others)
      bishops.create(color: color, x_coord: 2, y_coord: y_others)
      queens.create(color: color, x_coord: 3, y_coord: y_others)
      kings.create(color: color, x_coord: 4, y_coord: y_others)
      bishops.create(color: color, x_coord: 5, y_coord: y_others)
      knights.create(color: color, x_coord: 6, y_coord: y_others)
      rooks.create(color: color, x_coord: 7, y_coord: y_others)
      8.times do |counter|
        pawns.create(color: color, x_coord: counter, y_coord: y_pawns)
      end
    end
  end

  def board_state
    return @board if @board.present?
    @board = Array.new(8) { Array.new(8) }
    pieces.each do |piece|
      unless piece.captured
        @board[piece.y_coord][piece.x_coord] = piece
      end
    end
    @board
  end

  def piece_at(x, y)
    board_state[y][x]
  end

  def is_full?
    white_user_id && black_user_id
  end

  def first_move
    self.update_attributes(:player_turn => 'white')
  end

  ##TODO Need to fix this.
  # def next_turn
  #   if self.moves.to_i == 0 || self.moves.to_i % 2 == 0 
  #     self.update_attributes(:player_turn => 'white')
  #   else
  #     self.update_attributes(:player_turn => 'black')
  #   end
  # end

  ##TODO Throwing infinite loop error
  def moves
    if Game.update_attributes == 'true'?
      move_count =+ 1
    end
    puts move_count
  end

  def increment_count 

  end

  def assign_pieces
    pieces.where(:color => 'white').each do |piece|
      piece.update_attributes(:user_id => white_user_id)
    end
    pieces.where(:color => 'black').each do |piece|
      piece.update_attributes(:user_id => black_user_id)
    end
  end

  def in_check?(color)
    checking_pieces = []
    king = kings.find_by_color(color)

    pieces.where("not color = ?", color).each do |piece|
      checking_pieces << piece if piece.valid_move?(king.x_coord, king.y_coord)
    end
    checking_pieces.length > 0 ? checking_pieces : false
  end

  def can_move_from_check?(color)
    mods = [-1, 0, 1]
    king = kings.find_by_color(color)
    attackers = pieces.where("not color = ?", color)
    # find all squares around king then remove those that aren't on the board
    potential_moves = mods.map { |x| mods.map { |y| [king.x_coord + x, king.y_coord + y] } }.flatten(1)
    potential_moves.delete_if { |move| !((0..7).include?(move[0]) && (0..7).include?(move[1])) }
    potential_moves.delete_if { |move| piece_at(move[0], move[1]) }
    still_check = []
    # go thru all escapes and see if any are not in check
    potential_moves.each do |move|
      attackers.each do |piece|
        if piece.valid_move?(move[0], move[1])
          # if a valid move to this square add to still in check array
          still_check << move unless still_check.include?(move)
        end
      end
    end
    still_check.length == potential_moves.length ? false : true
  end

  def can_capture_from_check?(color, checking_pieces)
    # only need to check for capture if 1 checking_piece, can't capture more than 1 piece per turn
    if checking_pieces.length == 1
      pieces.where(:color => color).each do |piece|
        return true if piece.valid_move?(checking_pieces[0].x_coord, checking_pieces[0].y_coord)
      end
    end
    false
  end

  def can_obstruct_from_check?(color, checking_pieces)
    defenders = pieces.where(:color => color)
    king = kings.find_by_color(color)
    checking_pieces.each do |piece|
      unless piece.type == 'Knight'
        x_path = piece.x_coord < king.x_coord ? (piece.x_coord..king.x_coord).to_a
                 : (king.x_coord..piece.x_coord).to_a.reverse
        y_path = piece.y_coord < king.y_coord ? (piece.y_coord..king.y_coord).to_a
                 : (king.y_coord..piece.y_coord).to_a.reverse
        if x_path.length == y_path.length
          # diagonal
          path = x_path.zip(y_path)
        elsif x_path.length == 0
          # vertical
          path = y_path.map { |y| [piece.x_coord, y] }
        else
          # horizontal
          path = x_path.map { |x| [x, piece.y_coord] }
        end
        # delete king and attacking piece squares from path
        path.delete_if { |square| square == [king.x_coord, king.y_coord] || square == [piece.x_coord, piece.y_coord]}
        # check for valid_move? to any square in path
        defenders.each do |defender|
          path.each do |square|
            if defender.valid_move?(square[0], square[1])
              return true unless defender.type == 'King'
            end
          end
        end
      end
    end
    false
  end

  def is_checkmate?(color)
    # logic in this method doesn't account for stalemate
    checking_pieces = in_check?(color)
    # return false unless in check since no check means no checkmate
    unless checking_pieces
      return false
    end
    # since king is in check, test methods for getting out of check
    if can_move_from_check?(color)
    # if any valid move for king can get out of check (can't castle)
      false
    elsif can_capture_from_check?(color, checking_pieces)
    # elsif any king color piece has valid move to capture all checking piece(s)
      false
    elsif can_obstruct_from_check?(color, checking_pieces)
    # elsif any king color piece has valid move to obstruct all checking piece(s)
      false
    else
      # return true, game over man!
      true
    end
  end
end
