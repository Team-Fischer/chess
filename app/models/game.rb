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
      @board[piece.y_coord][piece.x_coord] = piece
    end
    @board
  end

  def piece_at(x, y)
    board_state[y][x]
  end
  
  def is_full?
    white_user_id && black_user_id
  end
end
