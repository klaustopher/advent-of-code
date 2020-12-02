#!/usr/bin/env ruby
# frozen_string_literal: true

require 'awesome_print'

Point = Struct.new(:x, :y) do
  def distance(point)
    (point.x - x).abs + (point.y - y).abs
  end
end

rows = 0
cols = 0

points = []

File.open('day6.txt', 'r') do |f|
  until f.eof?
    x, y = f.readline.split(',').map(&:strip).map(&:to_i)

    cols = [cols, x].max
    rows = [rows, y].max

    points << Point.new(x, y)
  end
end

# Find points that are on the edge and are considered indefinite
min_x = points.min_by(&:x).x
min_y = points.min_by(&:y).y
max_x = points.max_by(&:x).x
max_y = points.max_by(&:y).y

considerable_points = points.reject do |point|
  point.x == min_x || point.x == max_x || point.y == min_y || point.y == max_y
end

puts "Grid is #{rows} x #{cols}"

closest_to_count = Hash.new(0)

0.upto(rows) do |y|
  0.upto(cols) do |x|
    points_by_distance = points.map do |point|
      { point: point, distance: point.distance(Point.new(x, y)) }
    end.sort_by { |entry| entry[:distance] }

    if points_by_distance[0][:distance] == points_by_distance[1][:distance]
      # we have the same distance between two of our points, point is irrelevant
    elsif considerable_points.include?(points_by_distance[0][:point])
      point = points_by_distance[0][:point]

      # there is one closest point ... if we are on the outermost area of the grid,
      # we can eliminate another point because this must also be one with an infinite area
      if y.zero? || y == rows || x.zero? || x == cols
        considerable_points.delete(point)
        closest_to_count[point] = 0
      else
        closest_to_count[point] += 1
      end
    end
  end
end

puts "Biggest region: #{closest_to_count.values.max}"

area_count = 0
MAXIMUM_DISTANCE = 10_000

0.upto(rows) do |y|
  0.upto(cols) do |x|
    total_distance = points.sum { |point| point.distance(Point.new(x, y)) }
    area_count += 1 if total_distance < MAXIMUM_DISTANCE
  end
end

puts "Biggest area for < #{MAXIMUM_DISTANCE}: #{area_count}"
