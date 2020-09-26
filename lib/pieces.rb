# make module that checks if symbol should be white or black?
module Misc
  def piece_color(c, b, w)
    if c == 'white'
      w
    elsif c == 'black'
      b
    end
  end
end

class EmptyChecker
  def initialize(name)
    @name = name
    @sym = '☐'
  end
end

class Pawn
  include Misc
  attr_reader :moves
  def initialize(name, color)
    @name = name
    @color = color
    @sym = piece_color(@color, '♙', '♟︎')
    @infinite = false
    @moves = pawn_moves
  end

  def pawn_moves
    moves = [[0, 1], [1, 1], [-1, 1]]
    moves = [[0, -1], [-1, -1], [1, -1]] if @color == 'black'
    return moves
  end

  def p_moves 
    p @moves
  end
end

class Bishop
  include Misc
  attr_reader :moves
  def initialize(name, color)
    @name = name
    @color = color
    @sym = piece_color(@color, '♗', '♝')
    @infinite = true
    @moves = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
  end
end

class Knight
  include Misc
  attr_reader :moves
  def initialize(name, color)
    @name = name
    @color = color
    @sym = piece_color(@color, '♘', '♞')
    @infinite = false
    @moves = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
  end
end

class Rook
  include Misc
  attr_reader :moves
  def initialize(name, color)
    @name = name
    @color = color
    @sym = piece_color(@color, '♖', '♜')
    @infinite = true
    @moves = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end
end

class Queen
  include Misc
  attr_reader :moves
  def initialize(name, color)
    @name = name
    @color = color
    @sym = piece_color(@color, '♕', '♛')
    @infinite = true
    @moves = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
  end
end

class King
  include Misc
  attr_reader :moves
  def initialize(name, color)
    @name = name
    @color = color
    @sym = piece_color(@color, '♔', '♚')
    @infinite = false
    @moves = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
  end
end
