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
      knights.create(color: color, x_coord: x_others, y_coord: 5)
      bishops.create(color: color, x_coord: x_others, y_coord: 6)
      rooks.create(color: color, x_coord: x_others, y_coord: 7)
      8.times do |counter|
        pawns.create(color: color, x_coord: x_pawns, y_coord: counter)
      end
    end
  end
end
