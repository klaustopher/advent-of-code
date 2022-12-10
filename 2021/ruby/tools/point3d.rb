# frozen_string_literal: true

class Point3d
  attr_accessor :x, :y, :z

  def initialize(x, y, z)
    @x = x
    @y = y
    @z = z
  end

  def manhattan_distance(other)
    (x - other.x).abs + (y - other.y).abs + (z - other.z).abs
  end

  def euclidian_distance(other)
    Math.sqrt((x - other.x).abs**2 + (y - other.y).abs**2 + (z - other.z).abs**2)
  end

  def ==(other)
    x == other.x && y == other.y && z == other.z
  end

  def hash
    x.hash + y.hash + z.hash
  end

  alias eql? ==

  def inspect
    "(#{"%03d" % x}, #{"%03d" % y}, #{"%03d" % z})"
  end

  alias to_s inspect
end
