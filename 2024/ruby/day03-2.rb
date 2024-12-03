#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 3
# See https://adventofcode.com/2024/day/3

$data = File.read('day03.txt').chomp

split_data = $data.split(/(do\(\)|don't\(\))/)

result = 0
multiplication_allowed = true
split_data.each do |data|
  if data == 'do()'
    multiplication_allowed = true
  elsif data == "don't()"
    multiplication_allowed = false
  else
    data.scan(/mul\((\d{1,3}),(\d{1,3})\)/).each do |match|
      result += match[0].to_i * match[1].to_i if multiplication_allowed
    end
  end
end

puts result
