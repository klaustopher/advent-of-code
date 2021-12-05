#!/usr/bin/env ruby
# frozen_string_literal: true

$data = File.read(ARGV[0]).lines.map(&:chomp)

depth = 0
position = 0
aim = 0

$data.each do |line|
  command, number = line.scan(/(\w+) (\d+)/).flatten

  case command
  when 'forward'
    position += number.to_i
    depth += aim * number.to_i
  when 'down' then aim += number.to_i
  when 'up' then aim -= number.to_i
  end
end

puts depth * position
