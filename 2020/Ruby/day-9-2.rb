# frozen_string_literal: true

require 'awesome_print'

input = File.read('day-9.txt').lines.map(&:to_i)

def valid_xmas?(input, index, preamble_length: 25)
  numbers = input.slice(index - preamble_length, preamble_length)
  combinations = numbers.combination(2).map(&:sum)

  combinations.include?(input[index])
end

def find_consecutive_numbers_adding_up_to(input, search)
  0.upto(input.length) do |index|
    1.upto(input.length - index) do |size|
      elements = input.slice(index, size)
      if elements.sum == search
        return elements.max + elements.min
      elsif elements.sum >= search
        break
      end
    end
  end
end

preamble = 25
first_broken_number = nil

preamble.upto(input.length) do |index|
  unless valid_xmas?(input, index, preamble_length: preamble)
    first_broken_number = input[index]
    break
  end
end

puts find_consecutive_numbers_adding_up_to(input, first_broken_number)
