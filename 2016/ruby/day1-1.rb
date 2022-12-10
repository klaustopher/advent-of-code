def follow_route(*instructions)
  # N = 0, E = 1, S = 2, W = 3
  x = y = direction = 0

  instructions.each do |inst|
    turn, steps = inst.scan(/(R|L)(\d+)/).first

    direction = (direction + (turn == 'R' ? +1 : -1)) % 4

    case direction
    when 0 then x += steps.to_i
    when 1 then y += steps.to_i
    when 2 then x -= steps.to_i
    when 3 then y -= steps.to_i
    end
  end

  (x + y).abs
end

# follow_route(*%w[R2 L3]) == 5
# follow_route(*%w[R2 R2 R2]) == 2
# follow_route(*%w[R5 L5 R5 R3]) == 12

data = File.read("day1.txt").split(", ")
puts follow_route(*data)

