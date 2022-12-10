# Advent of Code 2022 - Day 4
# See https://adventofcode.com/2022/day/4

data = File.read_lines("day04.txt")

score = 0

def fully_covers?(range1, range2)
  range1.covers?(range2.begin) && range1.covers?(range2.end) ||
    range2.covers?(range1.begin) && range2.covers?(range1.end)
end

data.each do |line|
  e1, e2 = line.split(',').map { |pair| a, b = pair.split('-').map { |nr| nr.to_i }; (a..b) }
  score += 1 if fully_covers?(e1, e2)
end

puts score
