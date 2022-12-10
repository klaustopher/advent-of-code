#!/usr/bin/env ruby
# frozen_string_literal: true

positions = File.read(ARGV[0]).split(',').map(&:to_i)

fuel_consumptions = []

min = positions.min
max = positions.max

min.upto(max).each do |pos|
  fuel_consumptions << positions.sum { |x| (x - pos).abs }
end

pp fuel_consumptions.min
