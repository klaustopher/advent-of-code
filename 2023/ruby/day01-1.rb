#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2023 - Day 1
# See https://adventofcode.com/2023/day/1

$data = File.read('day01.txt').lines.map(&:chomp)

finalsum = 0

$data.each do |line|
  results = line.scan(/(\d{1})/).flatten.map(&:to_i)
  finalsum += (results.first * 10) + results.last
end

puts finalsum
