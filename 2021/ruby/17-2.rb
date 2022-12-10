#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2021 - Day 17

require_relative './tools/point'

$data = File.read(ARGV[0])
x1, x2, y1, y2 = $data.scan(/x=([-\d]+)..([-\d]+), y=([-\d]+)..([-\d]+)/).first.map(&:to_i)

$x_range = x1..x2
$y_range = y1..y2

$launch_point = Point.new(0, 0)

def launch_probe(initial_x_velocity, initial_y_velocity)
  positions = [$launch_point]
  hit_target = false

  x_velocity = initial_x_velocity
  y_velocity = initial_y_velocity

  loop do
    new_x = positions.last.x + x_velocity
    new_y = positions.last.y + y_velocity

    # check if we already overshot
    break if new_x > $x_range.min && new_y < $y_range.min
    break if x_velocity.zero? && new_x < $x_range.min

    positions << Point.new(new_x, new_y)

    if $x_range.include?(new_x) && $y_range.include?(new_y)
      hit_target = true
      break
    end

    if x_velocity.positive?
      x_velocity -= 1
    elsif x_velocity.negative?
      x_velocity += 1
    end

    y_velocity -= 1
  end

  hit_target ? positions : nil
end

vectors = []
1.upto(400).each do |x_vel|
  -200.upto(400).each do |y_vel|
    positions = launch_probe(x_vel, y_vel)
    vectors << [x_vel, y_vel] if positions
  end
end

puts vectors.count
