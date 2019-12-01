#!/usr/bin/env ruby

Square = Struct.new(:id, :left, :top, :width, :height, keyword_init: true) do
  def right
    left + width - 1
  end

  def bottom
    top + height - 1
  end
end

squares = []

matrix = Hash.new(0)

File.open('day3.txt', 'r') do |f|
  while !f.eof?
     entry = f.readline.strip

     matches = entry.match(/\A#(?<id>\d+) @ (?<left>\d+),(?<top>\d+):\s*(?<width>\d+)x(?<height>\d+)\Z/)
     hash = Hash[matches.names.zip(matches.captures.map(&:to_i))]
     squares << Square.new(hash)
  end
end

squares.each do |square|
  (square.left).upto(square.right) do |x|
    (square.top).upto(square.bottom) do |y|
      matrix[x * 1000 + y] += 1
    end
  end
end

puts matrix.values.select { |num| num >= 2 }.count