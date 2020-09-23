# make module that checks if symbol should be white or black?

class EmptyChecker
  def initialize(name)
    @name = name
    @sym = 'X'
  end
end

class Knight
  attr_reader :moves
  def initialize(name, color, sym)
    @sym = sym
    @name = name
    @color = color
    @moves = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
  end
end