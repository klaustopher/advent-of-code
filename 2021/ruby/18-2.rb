#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2021 - Day 18

require 'json'
require_relative './tools/snailfish_math'

$data = File.read(ARGV[0]).lines.map(&:chomp).map { |line| JSON.parse(line) }

magnitudes = []

$data.permutation(2) do |a, b|
  result = SnailfishMath.parse(a) + SnailfishMath.parse(b)
  result.reduce
  magnitudes << result.magnitude
end

pp magnitudes.max
