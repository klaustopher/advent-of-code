#!/usr/bin/env ruby

Square = Struct.new(:id, :left, :top, :width, :height, keyword_init: true) do
  def right
    left + width - 1
  end

  def bottom
    top + height - 1
  end

  def fields
    width * height
  end
end

squares = []

matrix = Hash.new { |hash, key| hash[key] = [] }

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
      matrix[x * 1000 + y] << square.id
    end
  end
end

fields_with_only_one_claim = matrix.values.select { |ids| ids.length == 1 }.flatten
field_count = fields_with_only_one_claim.each_with_object(Hash.new(0)) { |item, hash| hash[item] += 1}

squares.each do |square|
  if field_count[square.id] == square.fields
    puts square.id
    break
  end
end