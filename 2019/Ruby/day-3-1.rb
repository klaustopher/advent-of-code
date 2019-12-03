Point = Struct.new(:x, :y, keyword_init: true) do
  def distance
    x.abs + y.abs
  end
end
Direction = Struct.new(:direction, :steps, keyword_init: true)

def parse_line(line_string)
  line_string.split(',').map do |dir|
    Direction.new(direction: dir[0].downcase.to_sym, steps: dir[1..-1].to_i)
  end
end

def build_points(line)
  result = [Point.new(x: 0, y: 0)]

  line.each do |dir|
    case dir.direction
    when :r then dir.steps.times { prev_point = result.last; result << Point.new(x: prev_point.x + 1, y: prev_point.y) }
    when :l then dir.steps.times { prev_point = result.last; result << Point.new(x: prev_point.x - 1, y: prev_point.y) }
    when :u then dir.steps.times { prev_point = result.last; result << Point.new(x: prev_point.x, y: prev_point.y + 1) }
    when :d then dir.steps.times { prev_point = result.last; result << Point.new(x: prev_point.x, y: prev_point.y - 1) }
    end
  end

  result
end

lines = File.read('day3.txt').lines

p1 = build_points(parse_line(lines[0]))
p2 = build_points(parse_line(lines[1]))

intersections = p1 & p2 - [Point.new(x: 0, y: 0)]

puts intersections.map(&:distance).min