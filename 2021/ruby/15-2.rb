#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './tools/point'

$matrix = File.read(ARGV[0]).lines.map { |line| line.chomp.chars.map(&:to_i) }

def increased_matrix(step)
  result = []

  $matrix.each do |row|
    new_row = []
    row.each do |value|
      new_row << if value + step > 9
                   (value + step - 9)
                 else
                   (value + step)
                 end
    end

    result << new_row
  end

  result
end

$final_matrix = {}

(0..4).each do |x_grid|
  (0..4).each do |y_grid|
    matrix = increased_matrix(x_grid + y_grid)

    matrix.each_with_index do |row, x|
      row.each_with_index do |value, y|
        $final_matrix[Point.new((x_grid * $matrix.size) + x, (y_grid * $matrix.size) + y)] = value
      end
    end
  end
end

$matrix_size = $matrix.size * 5

start = Point.new(0, 0)
goal = Point.new($matrix_size - 1, $matrix_size - 1)

$metadata = Hash.new { |h, k| h[k] = {} }

$open_set = [start]
$closed_set = []

def cost(point)
  $final_matrix[point]
end

def lowest_open_point
  $open_set.min_by do |point|
    $metadata[point][:heuristic] + $metadata[point][:cost]
  end
end

def points_around(point)
  [
    Point.new(point.x - 1, point.y),
    Point.new(point.x + 1, point.y),
    Point.new(point.x, point.y - 1),
    Point.new(point.x, point.y + 1)
  ].reject { |point| point.x.negative? || point.x >= $matrix_size || point.y.negative? || point.y >= $matrix_size }
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
  print "#{$matrix_size**2} open: #{$open_set.size} closed: #{$closed_set.size} #{lop} cost: #{'%4d' % $metadata[lop][:cost]} distance to goal: #{'%4d' % $metadata[lop][:heuristic]}\r"
end
puts
puts
pp $metadata[goal][:cost]
