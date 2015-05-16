class Game < ActiveRecord::Base
  after_create :populate_board

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

  def in_check?(color)
    checking_pieces = []
    king = kings.where(:color => color).first

    pieces.where("not color = '#{color}'").each do |piece|
      checking_pieces << piece if piece.valid_move?(king.x_coord, king.y_coord)
    end
    checking_pieces.length > 0 ? checking_pieces : false
  end

  def can_move_from_check?(color)
    mods = [-1, 0, 1]
    king = kings.where("not color = '#{color}'").first
    potential_moves = mods.map { |x| mods.map { |y| [king.x_coord + x, king.y_coord + y] } }.flatten(1)

  end

  def is_checkmate?(color)
    # below doesn't account for stalemate
    # return false unless in check since no check means no checkmate
    unless in_check?(color)
      return false
    end

    # since king is in check, test methods for getting out of check
    if can_move_from_check?(color)
    # if any valid move for king can get out of check (can't castle)
      false
    elsif can_capture_from_check?(color)
    # elsif any king color piece has valid move to capture all checking piece(s)
      false
    elsif can_obstruct_from_check?(color)
    # elsif any king color piece has valid move to obstruct all checking piece(s)
      false
    else
      # return true, game over man!
      true
    end
  end
end
