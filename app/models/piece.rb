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
    x_dist = (x_coord - x_destination).abs
    y_dist = (y_coord - y_destination).abs    

    if x_dist == y_dist
      obstructed_diagonal(x_destination, y_destination)
    elsif y_dist == 0
      obstructed_horiz(x_destination, y_destination)
    else 
      obstructed_vert(x_destination, y_destination)
    end
  end

  def obstructed_diagonal(x_destination, y_destination)
    if x_coord > x_destination
      a = (x_destination..x_coord).to_a
    else
      a = (x_coord..x_destination).to_a
    end

    if y_coord > y_destination
      b = (y_destination..y_coord).to_a
    else
      b = (y_coord..y_destination).to_a
    end

    spaces = a.zip(b).to_a
    spaces.each do |obs|
      unless obs[0] == x_coord && obs[1] == y_coord
          return true if game.piece_at(obs[0], obs[1])
      end
    end
    false
  end

  def obstructed_horiz(x_destination, y_destination)
    if x_coord > x_destination
      a = (x_destination..x_coord).to_a
    else
      a = (x_coord..x_destination).to_a
    end
    a.each do |obs|
      unless obs == x_coord && y_coord == y_destination
        return true if game.piece_at(obs, y_destination)
      end
    end
    false
  end

  def obstructed_vert(x_destination, y_destination)
    if y_coord > y_destination
      b = (y_destination..y_coord).to_a
    else
      b = (y_coord..y_destination).to_a
    end
    b.each do |obs|
      unless x_coord == x_destination && obs == y_coord
        return true if game.piece_at(x_destination, obs)
      end
    end
    false
  end
end
