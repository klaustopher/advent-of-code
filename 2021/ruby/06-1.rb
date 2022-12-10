#!/usr/bin/env ruby
# frozen_string_literal: true

population = File.read(ARGV[0]).split(',').map(&:to_i)
# puts "0: #{population.inspect}"

80.times do |day|
  new_items = []

  population.each_with_index do |cycle, index|
    if cycle.zero?
      population[index] = 6
      new_items << 8
    else
      population[index] = cycle - 1
    end
  end

  population += new_items
  # puts "#{day + 1}: #{population.inspect}"
end

puts population.count
