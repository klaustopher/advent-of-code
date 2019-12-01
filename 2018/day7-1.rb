#!/usr/bin/env ruby

require 'awesome_print'

@steps = Hash.new { |hash, key| hash[key] = [] }
@available_steps = []
@completed_steps = []

File.open('day7.txt', 'r') do |f|
  while !f.eof?
    line = f.readline
    m = line.match(/Step ([A-Z]) must be finished before step ([A-Z]) can begin/)

    step = m[2]
    prereq = m[1]

    @steps[step] << prereq

    # Manage all available steps
    @available_steps << step
    @available_steps << prereq
  end
end

@available_steps = @available_steps.uniq.sort

def step_that_can_be_done
  considered_steps = @available_steps - @completed_steps

  considered_steps.select do |step|
    (@steps.fetch(step, []) - @completed_steps).size == 0
  end.sort.first
end

while @available_steps.size != @completed_steps.size
  @completed_steps << step_that_can_be_done
end

puts "Order: #{@completed_steps.join}"