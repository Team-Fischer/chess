class Game < ActiveRecord::Base
  has_many :users
  has_many :pieces

  delegate :kings, :queens, :bishops, :knights, :rooks, :pawns, to: :pieces

end
