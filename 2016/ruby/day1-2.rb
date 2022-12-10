require 'set'

def first_visited_twice(*instructions)
  # N = 0, E = 1, S = 2, W = 3
  x = y = direction = 0
  visited_locations = Set.new

  instructions.cycle.each do |inst|
    turn, steps = inst.scan(/(R|L)(\d+)/).first

    direction = (direction + (turn == 'R' ? +1 : -1)) % 4

    steps.to_i.times do
      case direction
      when 0 then y += 1
      when 1 then x += 1
      when 2 then y -= 1
      when 3 then x -= 1
      end
      return x.abs + y.abs if visited_locations.include?([x,y])
      visited_locations << [x,y]
    end
  end
end

puts first_visited_twice(*%w[R8 R4 R4 R8]) == 4

data = File.read("day1.txt").split(", ")
puts first_visited_twice(*data)


