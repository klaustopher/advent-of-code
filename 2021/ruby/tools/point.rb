# frozen_string_literal: true

class Point
  attr_accessor :x, :y
  attr_reader :meta

  def initialize(x, y)
    @x = x
    @y = y
    @meta = {}
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
    "(#{x}, #{y} #{meta})"
  end

  alias to_s inspect
end
