#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2023 - Day 1
# See https://adventofcode.com/2023/day/1

$data = File.read('day01.txt').lines.map(&:chomp)

def map_number(str)
  case str
  when /\d{1}/
    str.to_i
  when 'one' then 1
  when 'two' then 2
  when 'three' then 3
  when 'four' then 4
  when 'five' then 5
  when 'six' then 6
  when 'seven' then 7
  when 'eight' then 8
  when 'nine' then 9
  end
end

finalsum = 0

$data.each do |line|
  puts line
  results = line.scan(/(?=(\d{1}|one|two|three|four|five|six|seven|eight|nine))/)
                .flatten
                .map { |str| map_number(str) }

  finalsum += (results.first * 10) + results.last
end

puts finalsum
