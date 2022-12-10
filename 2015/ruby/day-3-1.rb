#!/usr/bin/env ruby

require 'set'

moves = File.read('day-3.txt').chomp.chars
x = y = 0

visited = Set.new

visited << "#{x},#{y}"

moves.each do |move|
  case move
  when '^' then x += 1
  when 'v' then x -= 1
  when '<' then y -= 1
  when '>' then y += 1
  end

  visited << "#{x},#{y}"
end

puts visited.count
