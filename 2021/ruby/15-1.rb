#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './tools/point'

$matrix = File.read(ARGV[0]).lines.map { |line| line.chomp.chars.map(&:to_i) }

start = Point.new(0, 0)
goal = Point.new($matrix.first.size, $matrix.size)

$open_set = [start]
$closed_set = []

def cost(point)
  $matrix[point.y][point.x]
end

start.meta[:distance_to_start] = 0
start.meta[:distance_to_end] = start.manhattan_distance(goal)

pp start
