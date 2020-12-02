# frozen_string_literal: true

Point = Struct.new(:x, :y, keyword_init: true) do
  def to_s
    "(#{x.to_i},#{y.to_i})"
  end

  def distance(other_point)
    Math.sqrt((x - other_point.x).abs**2 + (y - other_point.y).abs**2)
  end
end

$asteroids = []

input = File.read('day-10.txt')
$starting_point = Point.new(x: 11.to_r, y: 19.to_r)

# input = <<INPUT
# .#..##.###...#######
# #.############..##.
# .#.######.########.#
# .###.#######.####.#.
# ####.##.#.##.###.##
# ..#####..#.#########
####################
# .####....###.#.#.##
# #.#################
# ####.##.###..####..
# ..######..##.#######
# ###.##.####...##..#
# .#####..#.######.###
# #...#.##########...
# .##########.#######
# .####.#.###.###.#.##
# ....##.##.###..#####
# .#.#.###########.###
# .#.#.#####.####.###
# ##.##.####.##.#..##
# INPUT
#
# $starting_point = Point.new(x: 11r, y: 13r)

input.lines.each_with_index do |line, row|
  line.chars.each_with_index do |point, col|
    $asteroids << Point.new(x: col.to_r, y: row.to_r) if point == '#'
  end
end

$asteroids.delete($starting_point)

def direct_line_of_sight(from, to)
  return false if from == to

  other_asteroids = $asteroids - [from, to]
  range_y = to.y < from.y ? (to.y..from.y) : (from.y..to.y)
  range_x = to.x < from.x ? (to.x..from.x) : (from.x..to.x)

  if to.x == from.x
    other_asteroids.none? { |ast| (ast.x == from.x && range_y.include?(ast.y)) }
  elsif to.y == from.y
    other_asteroids.none? { |ast| (ast.y == from.y && range_x.include?(ast.x)) }
  else
    m = (to.y - from.y) / (to.x - from.x)
    b = ((from.y * to.x) - (to.y * from.x)) / (to.x - from.x)
    other_asteroids.none? { |ast| (range_y.include?(ast.y) && range_x.include?(ast.x) && (m * ast.x + b) == ast.y) }
  end
end

def angle_between_points(from, to)
  if to.x == from.x
    # asteroids are on a vertical axis, slope is infinity
    # let's check if we are in up (0°) or down (180°) mode
    if to.y < from.y
      0
    elsif to.y > from.y
      180
    end
  elsif to.y == from.y
    # asteroids are on a horizontal axis, slope is zero
    # let's check if we are in left (270°) or right (90°) mode
    if to.x > from.x
      270
    elsif to.x < from.x
      90
    end
  else
    result = Math.atan2(to.y - from.y, to.x - from.x) * 180.0 / Math::PI + 90.0
    (result + 360) % 360
  end
end

def visible_asteroids
  $asteroids.select do |asteroid|
    direct_line_of_sight($starting_point, asteroid)
  end
end

destroyed_asteroid = 1

while $asteroids.size.positive?
  asteroids = visible_asteroids.sort_by { |ast| angle_between_points($starting_point, ast) }

  asteroids.each do |ast|
    puts "#{destroyed_asteroid}: #{ast}"
    $asteroids.delete(ast)
    destroyed_asteroid += 1
  end
end
