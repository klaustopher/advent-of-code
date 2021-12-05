#!/usr/bin/env ruby
# frozen_string_literal: true

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

class Line
  attr_reader :from, :to, :points

  def initialize(from, to)
    @from = from
    @to = to
    @points = build_points
  end

  private

    def build_points
      x_iterator.map do |x|
        y_iterator.map do |y|
          Point.new(x, y)
        end
      end.flatten
    end

    def x_iterator
      if from.x > to.x
        from.x.downto(to.x)
      else
        from.x.upto(to.x)
      end
    end

    def x_iterator
      @x_iterator ||= if from.x > to.x
                        from.x.downto(to.x)
                      else
                        from.x.upto(to.x)
                      end
    end

    def y_iterator
      @y_iterator ||= if from.y > to.y
                        from.y.downto(to.y)
                      else
                        from.y.upto(to.y)
                      end
    end
end

$lines = []
File.read(ARGV[0]).lines.map(&:chomp).each do |input|
  data = input.scan(/(\d+),(\d+) -> (\d+),(\d+)/).flatten.map(&:to_i)

  from = Point.new(data[0], data[1])
  to = Point.new(data[2], data[3])

  $lines << Line.new(from, to) if from.x == to.x || from.y == to.y
end

all_points = $lines.map(&:points).flatten
all_points_tally = all_points.tally

puts all_points_tally.values.count { |v| v > 1 }
