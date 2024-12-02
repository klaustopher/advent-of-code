#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 1
# See https://adventofcode.com/2024/day/2

$data = File.read('day01.txt').lines.map(&:chomp).map { |line| line.split.map(&:to_i) }

list1 = $data.map(&:first).sort
list2 = $data.map(&:last).sort

sum = 0

list1.each_with_index do |item1, i|
  item2 = list2[i]

  sum += (item1 - item2).abs
end

puts sum
