#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

numbers = []

File.open('day1.txt', 'r') do |f|
  numbers << f.readline.to_i until f.eof?
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
