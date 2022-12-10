# Advent of Code 2022 - Day 2
# See https://adventofcode.com/2022/day/2

data = File.read_lines("day02.txt")
points = {rock: 1, paper: 2, scissor: 3}

score = 0

def map_input(input) : Symbol
  case input
  when "A", "X" then :rock
  when "B", "Y" then :paper
  when "C", "Z" then :scissor
  else               raise "Unknown type"
  end
end

data.each do |line|
  opponent, you = line.split(" ").map { |chr| map_input(chr) }
  score += points[you]

  if opponent == you
    score += 3
  elsif opponent == :rock && you == :paper || opponent == :paper && you == :scissor || opponent == :scissor && you == :rock
    score += 6
  end
end

puts score
