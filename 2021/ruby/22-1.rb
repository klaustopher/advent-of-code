#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2021 - Day 22

require_relative './tools/point3d'

$data = File.read(ARGV[0]).lines.map(&:chomp)

$cubes = Hash.new('off')

$data.each do |line|
  time = Time.now
  print "#{line} -> "
  data = line.match(/(?<state>on|off) x=(?<xmin>[-\d]+)..(?<xmax>[-\d]+),y=(?<ymin>[-\d]+)..(?<ymax>[-\d]+),z=(?<zmin>[-\d]+)..(?<zmax>[-\d]+)/)

  x_range = [-50, data[:xmin].to_i].max..[50, data[:xmax].to_i].min
  y_range = [-50, data[:ymin].to_i].max..[50, data[:ymax].to_i].min
  z_range = [-50, data[:zmin].to_i].max..[50, data[:zmax].to_i].min

  x_range.each do |x|
    y_range.each do |y|
      z_range.each do |z|
        $cubes[Point3d.new(x, y, z)] = data[:state]
      end
    end
  end
  puts Time.now - time
end

puts $cubes.values.count { |v| v == 'on' }
