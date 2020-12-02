#!/usr/bin/env ruby
# frozen_string_literal: true

File.open('day1.txt', 'r') do |f|
  sum = 0
  sum += f.readline.to_i until f.eof?
  puts sum
end
