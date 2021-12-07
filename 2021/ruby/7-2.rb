#!/usr/bin/env ruby
# frozen_string_literal: true

positions = File.read(ARGV[0]).split(',').map(&:to_i)

fuel_consumptions = []

min = positions.min
max = positions.max

min.upto(max).each do |pos|
  fuel_consumptions << positions.sum do |x|
    steps = (x - pos).abs

    steps * (steps + 1) / 2
  end
end

pp fuel_consumptions.min
