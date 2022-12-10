# Advent of Code 2022 - Day 6
# See https://adventofcode.com/2022/day/6

data = File.read_lines("day06.txt")

data.each do |line|
  chars = line.chars

  14.upto(chars.size) do |i|
    if chars[(i - 14)..(i - 1)].tally.values.all? { |v| v == 1 }
      puts i
      break
    end
  end
end
