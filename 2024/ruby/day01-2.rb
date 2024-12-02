#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 1
# See https://adventofcode.com/2024/day/2

$data = File.read('day01.txt').lines.map(&:chomp).map { |line| line.split.map(&:to_i) }

list1 = $data.map(&:first).sort
list2 = $data.map(&:last).sort

list2_tally = list2.tally

sum = 0

list1.each do |item|
  sum += item * list2_tally.fetch(item, 0)
end

puts sum
