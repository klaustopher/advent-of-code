input = <<INPUT
.#..#
.....
#####
....#
...##
INPUT

Point = Struct.new(:x,:y, :seen, keyword_init: true) do
  def to_s
    "(#{x},#{y})"
  end
end

asteroids = []

input.lines.each_with_index do |line, row|
  line.chars.each_with_index do |point, col|
    asteroids << Point.new(x: row, y: col) if point == "#"
  end
end

asteroids.each do |start|
  candidates = asteroids - [start]
  puts "","", start

  number_of_seen_asteroids = candidates.count do |asteroid|
    other_asteroids = (candidates - [asteroid])
      range_y = asteroid.y < start.y ? (asteroid.y..start.y) : (start.y..asteroid.y)
      range_x = asteroid.x < start.x ? (asteroid.x..start.x) : (start.x..asteroid.x)

    if asteroid.x == start.x
      puts " -> #{asteroid} direct x line"
      other_asteroids.none? { |ast| (ast.x == start.x && range_y.include?(ast.y)).tap { |t| puts "    #{ast} - #{t}"} }.tap{|r|puts r}
    elsif asteroid.y == start.y
      puts " -> #{asteroid} direct y line"
      other_asteroids.none? { |ast| (ast.y == start.y && range_x.include?(ast.x)).tap { |t| puts "    #{ast} - #{t}"} } .tap{|r|puts r}
    else
      m = (start.y - asteroid.y).to_f / (start.x - asteroid.x).to_f
      b = start.x * m + start.y
      puts " -> #{asteroid} formula: y = #{m}x + #{b}"
      other_asteroids.none? { |ast| (range_y.include?(ast.y) && range_x.include?(ast.x) && (m * ast.x + b) == ast.y).tap { |t| puts "    #{ast} - #{t}"} }.tap{|r|puts r}
    end
  end

  start.seen = number_of_seen_asteroids
  puts number_of_seen_asteroids
end

puts asteroids.map(&:inspect)