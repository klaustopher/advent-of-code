# frozen_string_literal: true

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def manhattan_distance(other)
    (x - other.x).abs + (y - other.y).abs
  end

  def euclidian_distance(other)
    Math.sqrt((x - other.x).abs**2 + (y - other.y).abs**2)
  end

  def ==(other)
    x == other.x && y == other.y
  end

  def hash
    x.hash + y.hash
  end

  alias eql? ==

  def inspect
    "(#{"%03d" % x}, #{"%03d" % y})"
  end

  alias to_s inspect
end
