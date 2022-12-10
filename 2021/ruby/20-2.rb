#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2021 - Day 20

require_relative './tools/point'
require_relative './tools/scanner_image'

$data = File.read(ARGV[0]).lines.map(&:chomp)

$algorithm = $data.first.chars.map { |char| char == '#' }

image = ScannerImage.new($algorithm)
$data[2..].each_with_index do |row, x|
  row.chars.each_with_index do |char, y|
    image.mark_pixel(Point.new(x, y), (char == '#'))
  end
end

50.times do
  image = image.apply_algorithm
end

puts image.lit_pixel_count
