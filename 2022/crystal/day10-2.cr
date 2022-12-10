# Advent of Code 2022 - Day 10
# See https://adventofcode.com/2022/day/10

data = File.read_lines("day10.txt").map { |line| line.split(" ") }

x = 1
debug = [0] of Int32

data.each do |args|
  if args[0] == "noop"
    debug << x
  elsif args[0] == "addx"
    value = args[1].to_i
    debug += [x, x + value]
    x += value
  end
end

0.upto(5) do |row|
  0.upto(39) do |col|
    id = row * 40 + col
    print [col - 1, col, col + 1].includes?(debug[id]) ? '#' : '.'
  end
  puts
end
