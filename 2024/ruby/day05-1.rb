#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2024 - Day 5
# See https://adventofcode.com/2024/day/5

$data = File.read('day05.txt').lines.map(&:chomp)
breakpoint = $data.index('')

$page_order_rules = Hash.new { |h, k| h[k] = [] }

$data[0...breakpoint].each do |line|
  before, after = line.split('|').map(&:to_i)
  $page_order_rules[before] << after
end

print_orders = $data[(breakpoint + 1)..].map { |line| line.split(',').map(&:to_i) }

def check_correct_order(pages)
  pages.each_with_index do |page, index|
    pages_after = pages[(index + 1)..]

    pages_after.each do |page_after|
      return false if $page_order_rules.key?(page_after) && $page_order_rules[page_after].include?(page)
      return false if $page_order_rules.key?(page) && !$page_order_rules[page].include?(page_after)
    end
  end

  true
end

puts(print_orders.select { |pages| check_correct_order(pages) }.sum { |pages| pages[(pages.count / 2)] })
