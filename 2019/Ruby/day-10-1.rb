
Point = Struct.new(:x,:y, :seen, keyword_init: true) do
  def to_s
    "(#{x},#{y})"
  end
end

asteroids = []

input = File.read('day-10.txt')

input.lines.each_with_index do |line, row|
  line.chars.each_with_index do |point, col|
    asteroids << Point.new(x: col.to_r, y: row.to_r) if point == "#"
  end
end

asteroids.each do |start|
  candidates = asteroids - [start]

  number_of_seen_asteroids = candidates.count do |asteroid|
    other_asteroids = (candidates - [asteroid])
      range_y = asteroid.y < start.y ? (asteroid.y..start.y) : (start.y..asteroid.y)
      range_x = asteroid.x < start.x ? (asteroid.x..start.x) : (start.x..asteroid.x)

    if asteroid.x == start.x
      other_asteroids.none? { |ast| (ast.x == start.x && range_y.include?(ast.y)) }
    elsif asteroid.y == start.y
      other_asteroids.none? { |ast| (ast.y == start.y && range_x.include?(ast.x)) }
    else
      m = (asteroid.y - start.y) / (asteroid.x - start.x)
      b = ((start.y * asteroid.x) - (asteroid.y * start.x)) / (asteroid.x - start.x)
      other_asteroids.none? { |ast| (range_y.include?(ast.y) && range_x.include?(ast.x) && (m * ast.x + b) == ast.y) }
    end
  end

  start.seen = number_of_seen_asteroids
end

puts asteroids.max_by(&:seen).inspect
