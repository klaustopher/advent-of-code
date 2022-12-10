#!/usr/bin/env ruby
# frozen_string_literal: true

population = File.read(ARGV[0]).split(',').map(&:to_i).tally
# puts "0: #{population.inspect}"

256.times do |day|
  new_population = Hash.new(0)

  population.each do |cycle, number_of_fish|
    if cycle.zero?
      new_population[6] += number_of_fish
      new_population[8] += number_of_fish
    else
      new_population[cycle - 1] += number_of_fish
    end
  end

  population = new_population

  # puts "#{day + 1} #{population.values.sum}"
end

puts population.values.sum
