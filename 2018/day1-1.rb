#!/usr/bin/env ruby

File.open('day1.txt', 'r') do |f|
  sum = 0
  while !f.eof?
    sum += f.readline.to_i
  end
  puts sum
end