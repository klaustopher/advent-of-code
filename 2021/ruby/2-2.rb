#!/usr/bin/env ruby

data = File.read('2-test.txt').lines

depth = 0
position = 0
aim = 0

data.each do |line|
  command, number = line.scan(/(\w+) (\d+)/).flatten

  case command
  when 'forward' then
    position += number.to_i
    depth += aim * number.to_i
  when 'down' then aim += number.to_i
  when 'up' then aim -= number.to_i
  end
end

puts depth * position
