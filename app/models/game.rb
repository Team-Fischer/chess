class Game < ActiveRecord::Base
  after_create :populate_board

  has_many :users
  has_many :pieces, :dependent => :destroy
  delegate :kings, :queens, :bishops, :knights, :rooks, :pawns, to: :pieces

  def populate_board
    %w(black white).each do |color|
      if color == 'black'
        x_pawns = 1
        x_others = 0
      else
        x_pawns = 6
        x_others = 7
      end
      rooks.create(color: color, x_coord: x_others, y_coord: 0)
      knights.create(color: color, x_coord: x_others, y_coord: 1)
      bishops.create(color: color, x_coord: x_others, y_coord: 2)
      queens.create(color: color, x_coord: x_others, y_coord: 3)
      kings.create(color: color, x_coord: x_others, y_coord: 4)
      bishops.create(color: color, x_coord: x_others, y_coord: 5)
      knights.create(color: color, x_coord: x_others, y_coord: 6)
      rooks.create(color: color, x_coord: x_others, y_coord: 7)
      8.times do |counter|
        pawns.create(color: color, x_coord: x_pawns, y_coord: counter)
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
    check = false
    king = color == 'white' ? kings.where(:color => 'black').first : kings.where(:color => 'white').first
    king_x = king.x_coord
    king_y = king.y_coord

    pieces.where(:color => color).each do |piece|
      check = true if piece.valid_move?(king_x, king_y)
    end
    check
  end
end
