# Advent of Code 2022 - Day 3
# See https://adventofcode.com/2022/day/3

data = File.read_lines("day03.txt")

def score(character : Char) : Int32
  if ('A'..'Z').includes?(character)
    27 + character.ord - 'A'.ord
  else
    1 + character.ord - 'a'.ord
  end
end

total_score = 0

data.each_slice(3) do |lines|
  lines[0].each_char do |char|
    if lines[1].includes?(char) && lines[2].includes?(char)
      total_score += score(char)
      break
    end
  end
end

puts total_score
