# Advent of Code 2022 - Day 9
# See https://adventofcode.com/2022/day/9

enum Direction : Int32
  Up    = 85
  Down  = 68
  Left  = 76
  Right = 82
end

data = File.read_lines("day09.txt").map do |line|
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

head = Point.new(x: 0, y: 0)
tail = Point.new(x: 0, y: 0)

data.each do |move|
  move[:moves].times do |i|
    case move[:dir]
    when Direction::Up
      head = Point.new(x: head.x, y: head.y + 1)
    when Direction::Down
      head = Point.new(x: head.x, y: head.y - 1)
    when Direction::Left
      head = Point.new(x: head.x - 1, y: head.y)
    when Direction::Right
      head = Point.new(x: head.x + 1, y: head.y)
    end

    unless head.touches?(tail)
      tail = if head.x == tail.x
               Point.new(x: tail.x, y: (head.y > tail.y ? tail.y + 1 : tail.y - 1))
             elsif head.y == tail.y
               Point.new(y: tail.y, x: (head.x > tail.x ? tail.x + 1 : tail.x - 1))
             else
               Point.new(x: (head.x > tail.x ? tail.x + 1 : tail.x - 1), y: (head.y > tail.y ? tail.y + 1 : tail.y - 1))
             end
    end

    visited_points << tail
  end
end

pp visited_points.size
