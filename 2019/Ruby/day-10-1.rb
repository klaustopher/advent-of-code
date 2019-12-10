
Point = Struct.new(:x,:y, :seen, keyword_init: true) do
  def to_s
    "(#{x},#{y})"
  end
end

$asteroids = []

input = File.read('day-10.txt')

input.lines.each_with_index do |line, row|
  line.chars.each_with_index do |point, col|
    $asteroids << Point.new(x: col.to_r, y: row.to_r) if point == "#"
  end
end

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

$asteroids.each do |start|
  candidates = $asteroids - [start]
  number_of_seen_asteroids = candidates.count do |asteroid|
    direct_line_of_sight(start, asteroid)
  end

  start.seen = number_of_seen_asteroids
end

puts $asteroids.max_by(&:seen).inspect
