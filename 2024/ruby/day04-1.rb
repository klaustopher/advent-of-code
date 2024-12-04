#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 4
# See https://adventofcode.com/2024/day/4

$data = File.read('day04.txt').lines.map(&:chomp).reject(&:empty?).map(&:chars)

cols = $data.first.size
rows = $data.size

search_word = 'XMAS'
counter = 0

# build a border so we do not run out of bounds
3.times { $data.unshift(['.'] * cols) }
3.times { $data.push(['.'] * cols) }
$data.each do |row|
  3.times do
    row.unshift('.')
    row.push('.')
  end
end

3.upto(rows + 2) do |x|
  3.upto(cols + 2) do |y|
    next unless $data[x][y] == search_word[0]

    # word is horizontal forwards
    counter += 1 if $data[x][y..(y + 3)].join == search_word

    # word is horizontal backwards
    counter += 1 if $data[x][(y - 3)..y].join.reverse == search_word

    # word is vertical downwards
    counter += 1 if $data[x..(x + 3)].map { |row| row[y] }.join == search_word

    # word is vertical upwards
    counter += 1 if $data[(x - 3)..x].map { |row| row[y] }.join.reverse == search_word

    # word is diagonal to the bottom-right
    counter += 1 if (0..3).map { |i| $data[x + i][y + i] }.join == search_word

    # word is diagonal to the top-right
    counter += 1 if (0..3).map { |i| $data[x - i][y + i] }.join == search_word

    # word is diagonal to the top-left
    counter += 1 if (0..3).map { |i| $data[x - i][y - i] }.join == search_word

    # word is diagonal to the bottom-left
    counter += 1 if (0..3).map { |i| $data[x + i][y - i] }.join == search_word
  end
end

puts counter
