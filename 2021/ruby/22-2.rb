#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2021 - Day 22

$data = File.read(ARGV[0]).lines.map(&:chomp)

Cube = Struct.new(:x_range, :y_range, :z_range, :state) do
  def intersect(other, new_state)
    return if x_range.min > other.x_range.max || x_range.max < other.x_range.min
    return if y_range.min > other.y_range.max || y_range.max < other.y_range.min
    return if z_range.min > other.z_range.max || z_range.max < other.z_range.min

    Cube.new(
      [x_range.min, other.x_range.min].max..[x_range.max, other.x_range.max].min,
      [y_range.min, other.y_range.min].max..[y_range.max, other.y_range.max].min,
      [z_range.min, other.z_range.min].max..[z_range.max, other.z_range.max].min,
      new_state
    )
  end

  def volume
    [
      x_range.max - x_range.min + 1,
      y_range.max - y_range.min + 1,
      z_range.max - z_range.min + 1
    ].reduce(:*) * (state ? 1 : -1)
  end
end

$cubes = []

$data.each do |line|
  new_cubes = []
  data = line.match(/(?<state>on|off) x=(?<xmin>[-\d]+)..(?<xmax>[-\d]+),y=(?<ymin>[-\d]+)..(?<ymax>[-\d]+),z=(?<zmin>[-\d]+)..(?<zmax>[-\d]+)/)

  x_range = data[:xmin].to_i..data[:xmax].to_i
  y_range = data[:ymin].to_i..data[:ymax].to_i
  z_range = data[:zmin].to_i..data[:zmax].to_i

  cube = Cube.new(x_range, y_range, z_range, data[:state] == 'on')

  new_cubes << cube if cube.state

  $cubes.each do |existing_cube|
    intersection = cube.intersect(existing_cube, !existing_cube.state)
    new_cubes << intersection if intersection
  end

  $cubes += new_cubes
end

puts $cubes.sum(&:volume)
