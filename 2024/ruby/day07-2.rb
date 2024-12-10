#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 7
# See https://adventofcode.com/2024/day/7

require "bundler/inline"

gemfile do
  source "https://rubygems.org"
  gem "concurrent-ruby"
end

$data = File.read("day07.txt").lines.reject(&:empty?).map(&:chomp).map do |line|
  split = line.split(": ")
  [split.first.to_i, split.last.split(" ").map(&:to_i)]
end

class Integer
  def concat(other)
    "#{self}#{other}".to_i
  end
end

def process_formula(result, operands)
  operators = [:+, :*, :concat]

  return result if operators.repeated_permutation(operands.size - 1).any? do |operator_combo|
    operation = operands.zip(operator_combo).flatten.compact

    candidate = operation.first
    1.step(by: 2, to: operation.size - 1) do |i|
      candidate = candidate.send(operation[i], operation[i + 1])
    end

    candidate == result
  end

  0
end

executions = $data.map do |result, operands|
  Concurrent::Future.execute do
    process_formula(result, operands)
  end
end
puts "current sum: #{executions.sum(&:value)}"
