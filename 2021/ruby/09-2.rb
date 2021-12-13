#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './point'

matrix = File.read(ARGV[0]).lines.map { |line| line.chomp.chars.map(&:to_i) }

rows = matrix.count
cols = matrix.first.count

$padded_matrix = []
$padded_matrix << ([10] * (cols + 2))
rows.times { |row| $padded_matrix << ([10] + matrix[row] + [10]) }
$padded_matrix << ([10] * (cols + 2))

lowest_points = []

1.upto(rows).each do |row|
  1.upto(cols).each do |col|
    candidate = $padded_matrix[row][col]

    adjacents = [
      $padded_matrix[row - 1][col],
      $padded_matrix[row + 1][col],
      $padded_matrix[row][col - 1],
      $padded_matrix[row][col + 1]
    ]

    lowest_points << Point.new(row, col) if adjacents.all? { |value| value > candidate }
  end
end

$used_points = []

def find_adjacent_points_from(point)
  return [] if $used_points.include?(point)

  $used_points << point

  candidates = [
    Point.new(point.x - 1, point.y),
    Point.new(point.x + 1, point.y),
    Point.new(point.x, point.y - 1),
    Point.new(point.x, point.y + 1)
  ]

  candidates.reject! do |candidate|
    $used_points.include?(candidate) || $padded_matrix[candidate.x][candidate.y] >= 9
  end

  [point] + candidates.map { |c| find_adjacent_points_from(c) }.flatten
end

pp lowest_points.map { |x| find_adjacent_points_from(x).count }.sort.last(3).reduce(:*)
