#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read(ARGV[0]).lines.map(&:chomp)

polymer = input.first.chars

special_treatment_characters = [polymer.first, polymer.last]

# Read and store pair insertions
$pair_insertions = {}
input[2..].each do |line|
  a, b, c = line.scan(/(.)(.) -> (.)/).first
  $pair_insertions[[a, b]] = c
end

# build the hash of the current pairs, string "ABCD" becomes pairs AB, BC, CD
polymer_hash = Hash.new(0)
polymer.each_cons(2) do |poly|
  polymer_hash[poly] += 1
end

def insert_pairs(poly_hash)
  new_poly_hash = Hash.new(0)

  # AB as pair with an insertion of C becomes
  # AC, CB since we are always considering them as pairs
  poly_hash.each do |pair, value|
    inserted_value = $pair_insertions[pair]
    new_poly_hash[[pair.first, inserted_value]] += value
    new_poly_hash[[inserted_value, pair.last]] += value
  end

  new_poly_hash
end

40.times do
  polymer_hash = insert_pairs(polymer_hash)
end

char_count = Hash.new(0)
polymer_hash.each do |pairs, value|
  char_count[pairs.first] += value
  char_count[pairs.last] += value
end

# since all characters are inserted twice, except for the first and the last one
# we have do divide the count by 2 to get the correct number for all middle characters,
# for the first and the last we have to add one before dividing
max_char, max_value = char_count.max_by { |_, v| v }
min_char, min_value = char_count.min_by { |_, v| v }

max_count = special_treatment_characters.include?(max_char) ? (max_value + 1) / 2 : (max_value / 2)
min_count = special_treatment_characters.include?(min_char) ? (min_value + 1) / 2 : (min_value / 2)

puts max_count - min_count
