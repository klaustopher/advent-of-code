#!/usr/bin/env ruby

data = File.read('1-test.txt').lines.map(&:to_i)
puts data.each_cons(2).count { |a, b| a < b }
