#!/usr/bin/env ruby
# frozen_string_literal: true

require 'awesome_print'

BASE_STEP_COST = 60
WORKER_COUNT = 5

@completed_order = []

class Step
  attr_reader :letter, :prereqs, :work_counter

  def initialize(letter)
    @letter = letter
    @prereqs = []
    @work_counter = 0
  end

  def work!
    @work_counter += 1
  end

  def completed?
    @work_counter == cost
  end

  def cost
    @cost ||= BASE_STEP_COST + (letter.ord - 'A'.ord) + 1
  end

  def to_s
    "Step <#{letter} cost=#{cost} work_done=#{work_counter} completed=#{completed?}>"
  end
end

@steps = Hash.new { |hash, key| hash[key] = Step.new(key) }

File.open('day7.txt', 'r') do |f|
  until f.eof?
    line = f.readline
    m = line.match(/Step ([A-Z]) must be finished before step ([A-Z]) can begin/)

    step = m[2]
    prereq = m[1]

    @steps[step].prereqs << prereq

    # Touch also the prereq entry to make sure we have all steps in the hash
    @steps[prereq]
  end
end

@workers = Array.new(WORKER_COUNT)

def free_worker_indexes
  free_workers = []

  @workers.each_with_index do |step, index|
    free_workers << index if step.nil? || step.completed?
  end

  free_workers
end

def next_available_step
  considered_steps = @steps.values.reject(&:completed?).reject { |step| @workers.include?(step) }

  considered_steps.select do |step|
    (step.prereqs - completed_steps).size.zero?
  end.min_by(&:letter)
end

def completed_steps
  @steps.values.select(&:completed?).map(&:letter)
end

second = 0

loop do
  free_worker_indexes.each do |index|
    @workers[index] = next_available_step
  end

  @workers.compact.each(&:work!)

  # puts "Second #{second} - #{@completed_order.join} - Workers: #{@workers.join(', ')}"

  @completed_order += @workers.compact.select(&:completed?).map(&:letter)
  break if @completed_order.count == @steps.count

  second += 1
end

puts second + 1
