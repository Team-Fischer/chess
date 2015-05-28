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

  def opposite
    color == 'white' ? 'black' : 'white'
  end

  def move_to(x, y)
    update_attributes(:x_coord => x, :y_coord => y, :moved => true)
    capture(x, y)
    game.in_check?(opposite)
    game.is_checkmate?(opposite)
  end
  
  def capture(x, y)
    occupied = game.piece_at(x, y)
    
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

  def obstructed_piece?(x_destination, y_destination)
    if type == 'Knight'
      return false
    elsif type == 'King'
      path = [[x_destination, y_destination]]
    else
      x_path = x_coord < x_destination ? (x_coord..x_destination).to_a : (x_destination..x_coord).to_a.reverse
      y_path = y_coord < y_destination ? (y_coord..y_destination).to_a : (y_destination..y_coord).to_a.reverse
      if x_path.length == y_path.length
        # diagonal
        path = x_path.zip(y_path)
      elsif x_path.length == 1
        # vertical
        path = y_path.map { |y| [x_coord, y] }
      else
        # horizontal
        path = x_path.map { |x| [x, y_coord] }
      end
    end

    path.each do |obs|
      unless obs[0] == x_coord && obs[1] == y_coord
        return true if game.piece_at(obs[0], obs[1]) && game.piece_at(obs[0], obs[1]).color == color
      end
    end
    false
  end
end
