#!/usr/bin/env ruby
# frozen_string_literal: true

matrix = File.read(ARGV[0]).lines.map { |line| line.chomp.chars.map(&:to_i) }

rows = matrix.count
cols = matrix.first.count

padded_matrix = []
padded_matrix << ([10] * (cols + 2))
rows.times { |row| padded_matrix << ([10] + matrix[row] + [10]) }
padded_matrix << ([10] * (cols + 2))

lowest_points = []

1.upto(rows).each do |row|
  1.upto(cols).each do |col|
    candidate = padded_matrix[row][col]

    adjacents = [
      padded_matrix[row - 1][col],
      padded_matrix[row + 1][col],
      padded_matrix[row][col - 1],
      padded_matrix[row][col + 1]
    ]

    lowest_points << candidate if adjacents.all? { |value| value > candidate }
  end
end

pp lowest_points.sum { |x| x + 1 }
