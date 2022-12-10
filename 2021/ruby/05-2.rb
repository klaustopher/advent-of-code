#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './tools/point'
require_relative './tools/line'

$lines = []
File.read(ARGV[0]).lines.map(&:chomp).each do |input|
  data = input.scan(/(\d+),(\d+) -> (\d+),(\d+)/).flatten.map(&:to_i)

  from = Point.new(data[0], data[1])
  to = Point.new(data[2], data[3])

  $lines << Line.new(from, to)
end

all_points = $lines.map(&:points).flatten
all_points_tally = all_points.tally

puts all_points_tally.values.count { |v| v > 1 }
