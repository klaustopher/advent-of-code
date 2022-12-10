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

data.each do |line|
  half = ine.size // 2
  compartment_a = line[...half]
  compartment_b = line[half..]

  compartment_a.each_char do |char|
    if compartment_b.includes?(char)
      total_score += score(char)
      break
    end
  end
end

puts total_score
