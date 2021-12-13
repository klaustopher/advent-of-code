#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read(ARGV[0]).lines.map(&:chomp)

occurences_of_unique_numbers = 0

input.each do |line|
  _, output_values_raw = line.split(' | ')

  output_values = output_values_raw.split

  occurences_of_unique_numbers += output_values.count { |value| [2, 3, 4, 7].include?(value.length) }
end

puts occurences_of_unique_numbers

