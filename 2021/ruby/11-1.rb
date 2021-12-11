#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './tools/point'

NUMBER_OF_STEPS = 100
SIDES = 10

$matrix = File.read(ARGV[0]).lines.map { |line| line.chomp.chars.map(&:to_i) }

def increase_all_energy_levels
  SIDES.times do |row|
    SIDES.times do |col|
      $matrix[row][col] += 1
    end
  end
end

def flash(row, col)
  return false if $matrix[row][col] <= 9

  [-1, 0, 1].each do |row_offset|
    [-1, 0, 1].each do |col_offset|
      new_row = row + row_offset
      new_col = col + col_offset
      point = Point.new(new_row, new_col)

      next if row_offset.zero? && col_offset.zero? # middle cell
      next if new_row >= SIDES || new_row.negative? # first and last row
      next if new_col >= SIDES || new_col.negative? # first and last column
      next if $flashed_points.include?(point) # already flashed

      $matrix[new_row][new_col] += 1
    end
  end

  $matrix[row][col] = 0
  $flashed_points << Point.new(row, col)
  true
end

def find_flashable_points
  loop do
    flashed_something = false

    SIDES.times do |row|
      SIDES.times do |col|
        flashed_something ||= flash(row, col)
      end
    end

    return unless flashed_something
  end
end

$total_flashes = 0

NUMBER_OF_STEPS.times do |step|
  $flashed_points = []
  puts "Step #{step + 1}"
  increase_all_energy_levels
  find_flashable_points
  # pp $matrix
  $total_flashes += $flashed_points.count
end

pp $total_flashes
