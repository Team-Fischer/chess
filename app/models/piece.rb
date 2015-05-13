class Piece < ActiveRecord::Base
  validate :valid_piece_names
  belongs_to :user
  belongs_to :game

  scope :kings, -> { where(:type => 'King') }
  scope :queens, -> { where(:type => 'Queen') }
  scope :bishops, -> { where(:type => 'Bishop') }
  scope :knights, -> { where(:type => 'Knight') }
  scope :rooks, -> { where(:type => 'Rook') }
  scope :pawns, -> { where(:type => 'Pawn') }

  def valid_piece_names
    return if %w(King Queen Bishop Knight Rook Pawn).include?(type)
    errors.add(:type, 'must be one of King, Queen, Bishop, Knight, Rook, Pawn')
  end

  def glyph
    self.type.downcase
  end

  def move_to(x, y)
      self.update_attributes(:x_coord => x, :y_coord => y, :moved => true)
  end
  
  def capture(x, y)
    x_dest = x
    y_dest = y
    game = Game.find(game_id)
    occupied = game.piece_at(x_dest, y_dest)
    
    if occupied
      if color != occupied.color
        occupied.update_attributes(:captured => true)
      end
    end
  end

  def on_board?(x, y)
    (0..7).include?(x) && (0..7).include?(y)
  end

  def as_json(options = {})
    super(options).merge(:glyph => glyph)
  end
end
