
Point = Struct.new(:x,:y, keyword_init: true) do
  def to_s
    "(#{x.to_i},#{y.to_i})"
  end

  def distance(other_point)
    Math.sqrt((x-other_point.x).abs**2 + (y-other_point.y).abs**2)
  end
end

$asteroids = []

input = File.read('day-10.txt')
$starting_point = Point.new(x: 11.to_r, y: 19.to_r)

=begin
input = <<INPUT
.#..##.###...#######
##.############..##.
.#.######.########.#
.###.#######.####.#.
#####.##.#.##.###.##
..#####..#.#########
####################
#.####....###.#.#.##
##.#################
#####.##.###..####..
..######..##.#######
####.##.####...##..#
.#####..#.######.###
##...#.##########...
#.##########.#######
.####.#.###.###.#.##
....##.##.###..#####
.#.#.###########.###
#.#.#.#####.####.###
###.##.####.##.#..##
INPUT

$starting_point = Point.new(x: 11r, y: 13r)
=end

input.lines.each_with_index do |line, row|
  line.chars.each_with_index do |point, col|
    $asteroids << Point.new(x: col.to_r, y: row.to_r) if point == "#"
  end
end

$asteroids.delete($starting_point)


def angle_between_points(a, b)
  if b.x == a.x
    # asteroids are on a vertical axis, slope is infinity
    # let's check if we are in up (0°) or down (180°) mode
    if b.y < a.y
      0
    elsif b.y > a.y
      180
    end
  elsif b.y == a.y
    # asteroids are on a horizontal axis, slope is zero
    # let's check if we are in left (270°) or right (90°) mode
    if b.x > a.x
      270
    elsif b.x < a.x
      90
    end
  else
    (Math.atan2(b.y-a.y, b.x-a.x) * 180.0 / Math::PI + 360) % 360
  end
end

def asteroid_candidates(angle)
  $asteroids.select do |asteroid|
    angle == angle_between_points($starting_point, asteroid).round
  end.sort_by { |p| p.distance($starting_point) }
end

destroyed_asteroid = 1

(0..359).to_a.cycle.each do |angle|
  to_be_destroyed = asteroid_candidates(angle).first

  if to_be_destroyed
    puts "#{destroyed_asteroid} (#{angle}°) -> #{to_be_destroyed}"
    $asteroids.delete(to_be_destroyed)
    destroyed_asteroid += 1

    # puts $asteroids.join(',')
  end

  break if $asteroids.size == 0
end

