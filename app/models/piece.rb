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
    x_dest = x
    y_dest = y

    if self.valid_move?(x_dest, y_dest)
      # IF destination OBSTRUCTED by piece
        # IF yes, can it be CAPTURED?
          # CAPTURE
        # ElSE cannot make move
          # ERROR: Cannot make a move, make another
        # end
      # ELSE not obstructed
        self.update_attributes(x_coord: x_dest, y_coord: y_dest)        
      # end
    end
  end


  def on_board?(x, y)
    (0..7).include?(x) && (0..7).include?(y)
  end

  def as_json(options = {})
    super(options).merge(:glyph => glyph)
  end
end
