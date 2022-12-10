#!/usr/bin/env ruby

require 'set'

moves = File.read('day-3.txt').chomp.chars

positions = [
  { x: 0, y: 0 },
  { x: 0, y: 0 }
]

visited = Set.new
visited << "0,0"

moves.each_with_index do |move, index|
  case move
  when '^' then positions[index % 2][:x] += 1
  when 'v' then positions[index % 2][:x] -= 1
  when '<' then positions[index % 2][:y] -= 1
  when '>' then positions[index % 2][:y] += 1
  end

  visited += [
    "#{positions[0][:x]},#{positions[0][:y]}",
    "#{positions[1][:x]},#{positions[1][:y]}",
  ]
end

puts visited.count
