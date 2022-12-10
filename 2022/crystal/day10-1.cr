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

result = [20, 60, 100, 140, 180, 220].sum do |index|
  index * debug[index - 1]
end

puts result
