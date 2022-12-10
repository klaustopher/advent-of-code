# Advent of Code 2022 - Day 9
# See https://adventofcode.com/2022/day/9

enum Direction : Int32
  Up    = 85
  Down  = 68
  Left  = 76
  Right = 82
end

data = File.read_lines(ARGV[0]).map do |line|
  res = line.split(" ")
  {dir: Direction.new(res.first[0].ord), moves: res.last.to_i}
end

struct Point
  property x, y

  def initialize(@x : Int32, @y : Int32)
  end

  def touches?(other : Point)
    (other.x - self.x).abs <= 1 && (other.y - self.y).abs <= 1
  end
end

visited_points = Set(Point).new

points = Array(Point).new(10, Point.new(x: 0, y: 0))

data.each do |move|
  move[:moves].times do |i|
    case move[:dir]
    when Direction::Up
      points[0] = Point.new(x: points[0].x, y: points[0].y + 1)
    when Direction::Down
      points[0] = Point.new(x: points[0].x, y: points[0].y - 1)
    when Direction::Left
      points[0] = Point.new(x: points[0].x - 1, y: points[0].y)
    when Direction::Right
      points[0] = Point.new(x: points[0].x + 1, y: points[0].y)
    end

    1.upto(points.size - 1) do |index|
      head = points[index - 1]
      tail = points[index]

      unless head.touches?(tail)
        if head.x == tail.x
          points[index] = Point.new(x: tail.x, y: (head.y > tail.y ? tail.y + 1 : tail.y - 1))
        elsif head.y == tail.y
          points[index] = Point.new(y: tail.y, x: (head.x > tail.x ? tail.x + 1 : tail.x - 1))
        else
          points[index] = Point.new(x: (head.x > tail.x ? tail.x + 1 : tail.x - 1), y: (head.y > tail.y ? tail.y + 1 : tail.y - 1))
        end
      end
    end

    visited_points << points.last
  end
end

pp visited_points.size
