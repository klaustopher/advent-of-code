# frozen_string_literal: true

input = File.read('day-9.txt').lines.map(&:to_i)

def valid_xmas?(input, index, preamble_length: 25)
  numbers = input.slice(index - preamble_length, preamble_length)
  combinations = numbers.combination(2).map(&:sum)

  combinations.include?(input[index])
end

preamble = 25

preamble.upto(input.length) do |index|
  puts input[index] unless valid_xmas?(input, index, preamble_length: preamble)
end
