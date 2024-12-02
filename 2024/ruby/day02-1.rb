#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 2
# See https://adventofcode.com/2024/day/2

$data = File.read('day02.txt').lines.map(&:chomp).map { |line| line.split.map(&:to_i) }

def analyze_list(line)
  return false if line != line.sort && line != line.sort.reverse

  line.each_cons(2) do |a, b|
    distance = (a - b).abs
    return false if distance < 1 || distance > 3
  end

  true
end

puts($data.count { |line| analyze_list(line) })
