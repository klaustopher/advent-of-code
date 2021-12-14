#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read(ARGV[0]).lines.map(&:chomp)

polymer = input.first.chars
$pair_insertions = {}

input[2..].each do |line|
  a, b, c = line.scan(/(.)(.) -> (.)/).first
  $pair_insertions[[a, b]] = c
end

def insert_pairs(polymer)
  insertions = []
  polymer.each_cons(2) do |group|
    insertions << $pair_insertions[group]
  end

  polymer.zip(insertions).flatten.compact
end

10.times do
  polymer = insert_pairs(polymer)
end

occurences = polymer.tally.values
puts occurences.max - occurences.min
