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
    prev_point = result.last
    result += case dir.direction
              when :r then 1.upto(dir.steps).map { |i| Point.new(x: prev_point.x + i, y: prev_point.y) }
              when :l then 1.upto(dir.steps).map { |i| Point.new(x: prev_point.x - i, y: prev_point.y) }
              when :u then 1.upto(dir.steps).map { |i| Point.new(x: prev_point.x, y: prev_point.y + i) }
              when :d then 1.upto(dir.steps).map { |i| Point.new(x: prev_point.x, y: prev_point.y - i) }
              end
  end
  result
end
  
  lines = File.read('day3.txt').lines
  
  p1 = build_points(parse_line(lines[0]))
  p2 = build_points(parse_line(lines[1]))
  
  intersections = p1 & p2 - [Point.new(x: 0, y: 0)]
  
  shortest = intersections.map do |inter|
    p1.index(inter) + p2.index(inter)
  end

  puts shortest.min
