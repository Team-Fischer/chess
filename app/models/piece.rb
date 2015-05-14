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

  def on_board?(x, y)
    (0..7).include?(x) && (0..7).include?(y)
  end

  def as_json(options = {})
    super(options).merge(:glyph => glyph)
  end
class Queen < Piece

  def is_obstructed?(x_destination, y_destination)
    @x_distance = (x_destination - x_coord)
    @y_distance = (y_destination - y_coord)
    a = (x_coord..x_destination).to_a
    b = (y_coord..y_destination).to_a
    @spaces = a.zip(b).to_a
    @y = @spaces.length.to_i - 1

    if @x_distance == 1 && @y_distance == 1
      if Piece.where(:x_coord => x_destination, :y_coord => x_destination).length > 0
        return true
      else
        return false
      end
    end
    if @x_distance > 0 && @y_distance > 0
      @spaces.each_with_index do |x, x_index|
        print Piece.where(:x_coord => @spaces[x_index][0].to_i, :y_coord => @spaces[x_index][1].to_i).
        return true if Piece.where(:x_coord => @spaces[x_index][0], :y_coord => @spaces[x_index][1].to_i).length > 0
      end 
        return false
      end
case
    when @x_distance > 0 && @y_distance == 0
    for x_element in (x_coord..x_destination)
     if game.pieces.where(:x_coord => x_element, :y_coord => y_destination).length > 1 
        return true
     else
        return false
      end
    end
    when @x_distance > 0 && @y_distance < 0
      for x_element in (x_coord..x_destination)
        a << x_element
      end
      (y_coord).downto(y_destination) do y_element
        b << y_element
      end
    spaces_covered = a.zip(b)
      for spaces in spaces_covered
        spaces.each do |obs_pieces|
          if game.pieces.where(:x_coord => spaces[0], :y_coord => spaces[1]).length > 1
            return true
          else
            return false
          end
        end
      end
    when @x_distance == 0 && @y_distance < 0
    (y_coord).downto(y_destination) do y_element      
     if game.pieces.where(:x_coord => x_destination, :y_coord => y_element).length > 1 
        return true
     else
        return false
      end
    end
    when @x_distance < 0 && @y_distance < 0
      x_coord.downto(x_destination) do x_element
        a << x_element
      end
      (y_coord).downto(y_destination) do y_element 
        b << y_element
      end
      spaces_covered = a.zip(b)
        for spaces in spaces_covered
          spaces.each do |obs_pieces|
            if game.pieces.where(:x_coord => spaces[0], :y_coord => spaces[1]).length > 1
              return true
            else
              return false
            end
          end
        end
    when @x_distance < 0 && @y_distance == 0
      for x_element in (x_destination...x_coord)
        if game.pieces.where(:x_coord => x_element, :y_coord => y_destination).length > 1 
          return true
        else
          return false
        end
      end
    when @x_distance < 0 && @y_distance > 0
      (x_coord).downto(x_destination) do x_element
        a << x_element
      end
      for y_element in (y_coord..y_destination)
        b << y_element
      end
      spaces_covered = a.zip(b)
        for spaces in spaces_covered
          spaces.each do |obs_pieces|
            if game.pieces.where(:x_coord => spaces[0], :y_coord => spaces[1]).length > 1
              return true
            else
              return false
            end
          end
        end
    when @x_distance == 0 && @y_distance > 0
      for y_element in (y_coord..y_destination)
        if game.pieces.where(:x_coord => x_destination, :y_coord => y_element).length > 1
          return true
        else
          return false
        end
      end
    end
  end
end



end
