# Advent of Code 2022 - Day 2
# See https://adventofcode.com/2022/day/2

data = File.read_lines("day02.txt")
points = {rock: 1, paper: 2, scissor: 3, win: 6, draw: 3, lose: 0}

score = 0

def map_input(input) : Symbol
  case input
  when "A" then :rock
  when "B" then :paper
  when "C" then :scissor
  when "X" then :lose
  when "Y" then :draw
  when "Z" then :win
  else          raise "Unknown type"
  end
end

data.each do |line|
  opponent, outcome = line.split(" ").map { |chr| map_input(chr) }

  score += points[outcome]

  my_choice = if outcome == :win
                case opponent
                when :rock    then :paper
                when :paper   then :scissor
                when :scissor then :rock
                end
              elsif outcome == :lose
                case opponent
                when :rock    then :scissor
                when :paper   then :rock
                when :scissor then :paper
                end
              else # draw
                opponent
              end

  raise "Problem" if my_choice.nil?

  score += points[my_choice]
end

puts score
