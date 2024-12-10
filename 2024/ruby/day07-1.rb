#!/usr/bin/env ruby

# Advent of Code 2024 - Day 7
# See https://adventofcode.com/2024/day/7

$data = File.read("day07.txt").lines.reject(&:empty?).map(&:chomp).map do |line|
  split = line.split(": ")
  [split.first.to_i, split.last.split(" ").map(&:to_i)]
end

sum = 0
$data.each_with_index do |(result, operands), i|
  puts "#{i} / #{$data.size}"

  operators = [:+, :*] * (operands.size - 1)

  sum += result if operators.combination(operands.size - 1).any? do |operator_combo|
    operation = operands.zip(operator_combo).flatten.compact

    candidate = operation.shift
    until operation.empty?
      operator, operand = operation.shift(2)
      candidate = candidate.send(operator, operand)
    end

    candidate == result
  end
end

puts sum
