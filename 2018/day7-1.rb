#!/usr/bin/env ruby
# frozen_string_literal: true

require 'awesome_print'

@steps = Hash.new { |hash, key| hash[key] = [] }
@available_steps = []
@completed_steps = []

File.open('day7.txt', 'r') do |f|
  until f.eof?
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
    (@steps.fetch(step, []) - @completed_steps).size.zero?
  end.min
end

@completed_steps << step_that_can_be_done while @available_steps.size != @completed_steps.size

puts "Order: #{@completed_steps.join}"
