#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 3
# See https://adventofcode.com/2024/day/3

$data = File.read('day03.txt').chomp

result = 0
$data.scan(/mul\((\d{1,3}),(\d{1,3})\)/).each do |match|
  result += match[0].to_i * match[1].to_i
end

puts result
