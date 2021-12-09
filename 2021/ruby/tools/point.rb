class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def hash
    x.hash + y.hash
  end

  alias eql? ==

  def inspect
    "(#{x}, #{y})"
  end

  alias to_s inspect
end
