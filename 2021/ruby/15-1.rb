#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './tools/point'

$matrix = File.read(ARGV[0]).lines.map { |line| line.chomp.chars.map(&:to_i) }

start = Point.new(0, 0)
goal = Point.new($matrix.size - 1, $matrix.size - 1)

$metadata = Hash.new { |h, k| h[k] = {} }

$open_set = [start]
$closed_set = []

def cost(point)
  $matrix[point.y][point.x]
end

def lowest_open_point
  $open_set.min_by do |point|
    $metadata[point][:cost] + $metadata[point][:heuristic]
  end
end

def points_around(point)
  [
    Point.new(point.x - 1, point.y),
    Point.new(point.x + 1, point.y),
    Point.new(point.x, point.y - 1),
    Point.new(point.x, point.y + 1)
  ].reject { |point| point.x.negative? || point.x >= $matrix.size || point.y.negative? || point.y >= $matrix.size }
end

$metadata[start][:cost] = 0
$metadata[start][:heuristic] = start.manhattan_distance(goal)

loop do
  break if $open_set.empty?

  # find the point with the lowest cost/heuristic factor
  lop = lowest_open_point

  # move it to the closed set
  $open_set.delete(lop)
  $closed_set << lop

  break if $closed_set.include?(goal)

  # find adjacent points
  adjacent_points = points_around(lop).reject { |point| $closed_set.include?(point) }

  adjacent_points.each do |point|
    if $open_set.include?(point)

      if $metadata[point][:cost] > $metadata[lop][:cost] + cost(point)
        $metadata[point][:parent] = lop
        $metadata[point][:cost] = $metadata[lop][:cost] + cost(point)
        $metadata[point][:heuristic] = point.manhattan_distance(goal)
      end
    else
      $metadata[point][:parent] = lop
      $metadata[point][:cost] = $metadata[lop][:cost] + cost(point)
      $metadata[point][:heuristic] = point.manhattan_distance(goal)

      $open_set << point
    end
  end
end

pp $metadata[goal][:cost]
