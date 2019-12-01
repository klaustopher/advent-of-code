#!/usr/bin/env ruby
require 'set'

numbers = []

File.open('day1.txt', 'r') do |f|
  while !f.eof?
    numbers << f.readline.to_i
  end
end

seen = Set.new
seen << 0

sum = 0

numbers.cycle.each do |number|
  sum += number

  if seen.include?(sum)
    puts sum
    break
  else
    seen << sum
  end
end