#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 4
# See https://adventofcode.com/2024/day/4

$data = File.read('day04.txt').lines.map(&:chomp).reject(&:empty?).map(&:chars)

cols = $data.first.size
rows = $data.size

#  build a border so we do not run out of bounds
$data.unshift(['.'] * cols)
$data.push(['.'] * cols)
$data.each do |row|
  row.unshift('.')
  row.push('.')
end

counter = 0

1.upto(rows) do |x|
  1.upto(cols) do |y|
    next unless $data[x][y] == 'A'

    surrounding = [
      $data[x - 1][y - 1],
      $data[x - 1][y + 1],
      $data[x + 1][y + 1],
      $data[x + 1][y - 1]
    ].join

    counter += 1 if %w[MSSM MMSS SMMS SSMM].include?(surrounding)
  end
end

puts counter
