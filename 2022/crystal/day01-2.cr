# Advent of Code 2022 - Day 1
# See https://adventofcode.com/2022/day/1

data = File.read("day01.txt").lines.map { |line| line.chomp }

food_portions = [0]

data.each do |line|
  if line.empty?
    food_portions << 0
  else
    food_portions[-1] += line.to_i
  end
end

food_portions.sort!

puts food_portions[-1] + food_portions[-2] + food_portions[-3]
