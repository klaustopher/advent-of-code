# Advent of Code 2022 - Day 5
# See https://adventofcode.com/2022/day/5

data = File.read("day05.txt").lines.map { |line| line.chomp }

stacks = Array(Array(Char)).new(20) { |index| Array(Char).new }

input_mode = :stacks

data.each do |line|
  next if line.blank?

  if input_mode == :stacks
    line.chars.in_groups_of(4).each_with_index do |boxes, index|
      if ('1'..'9').includes?(boxes[1].as(Char))
        input_mode = :moves
      elsif boxes[1] != ' '
        stacks[index].unshift boxes[1].as(Char)
      end
    end
  elsif input_mode == :moves
    parsed = line.match(/move (?<items>\d+) from (?<from>\d+) to (?<to>\d+)/)
    if parsed
      from = parsed["from"].to_i - 1
      to = parsed["to"].to_i - 1
      items = parsed["items"].to_i
      items.times do
        stacks[to] << stacks[from].pop
      end
    end
  end
end

puts stacks.map { |stack| stack.last? }.compact.join
