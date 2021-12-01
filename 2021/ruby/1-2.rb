#!/usr/bin/env ruby

data = File.read('1-test.txt').lines.map(&:to_i)
pp data.each_cons(3).map(&:sum).each_cons(2).count { |a, b| a < b }
