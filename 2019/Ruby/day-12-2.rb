require 'awesome_print'

Moon = Struct.new(:x,:y,:z,:vx,:vy,:vz) do
  def kinetic
    vx.abs + vy.abs + vz.abs
  end

  def potential
    x.abs + y.abs + z.abs
  end

  def energy
    kinetic * potential
  end
end

input = File.read('day-12.txt')

def parse_position(line)
  match = line.match(/\<x=(?<x>[-\d]+),\s*y=(?<y>[-\d]+),\s*z=(?<z>[-\d]+)\>/)
  Moon.new(match[:x].to_i, match[:y].to_i, match[:z].to_i, 0, 0, 0)
end

def apply_gravity
  $moons.repeated_combination(2).each do |(moon1, moon2)|
    if moon1.x > moon2.x
      moon1.vx -= 1
      moon2.vx += 1
    elsif moon1.x < moon2.x
      moon1.vx += 1
      moon2.vx -= 1
    end

    if moon1.y > moon2.y
      moon1.vy -= 1
      moon2.vy += 1
    elsif moon1.y < moon2.y
      moon1.vy += 1
      moon2.vy -= 1
    end

    if moon1.z > moon2.z
      moon1.vz -= 1
      moon2.vz += 1
    elsif moon1.z < moon2.z
      moon1.vz += 1
      moon2.vz -= 1
    end
  end
end

def apply_movement
  $moons.each do |moon|
    moon.x += moon.vx
    moon.y += moon.vy
    moon.z += moon.vz
  end
end

known_positions = {}
rounds = 0

$moons = input.lines.map { |l| parse_position(l) }
loop do
  puts "[#{Time.now}] #{rounds}" if rounds % 100_000 == 0
  apply_gravity
  apply_movement

  if known_positions[$moons.map(&:to_s).join('')] == true
    break
  else
    known_positions[$moons.map(&:to_s).join('')] = true
    rounds += 1
  end
end

puts rounds
