#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './tools/point'

$points = []
$folds = []

input = File.read(ARGV[0]).lines.map(&:chomp)

split_line = input.rindex('')

$points = input[0...split_line].map do |line|
  x, y = line.split(',').map(&:to_i)
  Point.new(x, y)
end

$folds = input[(split_line + 1)..].map do |line|
  seam, row = line.scan(/(x|y)=(\d+)/).first
  { axis: seam.to_sym, number: row.to_i }
end

def make_fold(axis:, number:)
  $points.each do |point|
    if axis == :y && point.y > number
      point.y = (2 * number) - point.y
    elsif axis == :x && point.x > number
      point.x = (2 * number) - point.x
    end
  end

  $points.uniq!
end

make_fold(**$folds.first)
puts $points.count
