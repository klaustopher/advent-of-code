# frozen_string_literal: true

require 'awesome_print'

content = File.read('day-1.txt').lines.map(&:to_i)

content.combination(2).each do |combination|
  if combination.sum == 2020
    puts combination.inject(:*)
    break
  end
end
