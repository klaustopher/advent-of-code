#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 6
# See https://adventofcode.com/2024/day/6

$data = File.read('day06.txt').lines.map(&:chomp).map(&:chars)

Guard = Struct.new(:x, :y, :dx, :dy, keyword_init: true)

# search for the starting pos
guard = nil
$data.each_with_index do |row, y|
  row.each_with_index do |col, x|
    if col == '^'
      guard = Guard.new(x: x, y: y, dx: 0, dy: -1) # facing up
    end
  end
end

loop do
  # mark the position as visited
  $data[guard.y][guard.x] = 'X'

  # break if we would move out of bounds
  break if guard.y + guard.dy < 0
  break if guard.y + guard.dy >= $data.size

  break if guard.x + guard.dx < 0
  break if guard.x + guard.dx >= $data[0].size

  # check what is in front of the guard
  front = $data[guard.y + guard.dy][guard.x + guard.dx]
  if front == '#'
    # turn right
    guard.dx, guard.dy = -guard.dy, guard.dx
  end

  # move forward
  guard.x += guard.dx
  guard.y += guard.dy
end

puts $data.flatten.count('X')
