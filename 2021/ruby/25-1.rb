#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2021 - Day 25

require_relative './tools/point'

$matrix = File.read(ARGV[0]).lines.map { |line| line.chomp.chars }

$cols = $matrix.first.size
$rows = $matrix.size

def move_east(matrix)
  new_matrix = Array.new($rows) { Array.new($cols, nil) }

  $rows.times do |row|
    $cols.times do |col|
      next_col = (col + 1) % $cols

      if matrix[row][col] == '>' && matrix[row][next_col] == '.'
        new_matrix[row][col] = '.'
        new_matrix[row][next_col] = '>'
      else
        new_matrix[row][col] ||= matrix[row][col]
      end
    end
  end

  new_matrix
end

def move_south(matrix)
  new_matrix = Array.new($rows) { Array.new($cols, nil) }

  $rows.times do |row|
    next_row = (row + 1) % $rows
    $cols.times do |col|
      if matrix[row][col] == 'v' && matrix[next_row][col] == '.'
        new_matrix[row][col] = '.'
        new_matrix[next_row][col] = 'v'
      else
        new_matrix[row][col] ||= matrix[row][col]
      end
    end
  end

  new_matrix
end

round = 0

loop do
  round += 1
  new_matrix = move_south(move_east($matrix))

  break if new_matrix == $matrix
  $matrix = new_matrix
end

puts "Ended after round #{round}"
