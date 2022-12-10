#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

entries = []

File.open('day2.txt', 'r') do |f|
  entries << f.readline.strip until f.eof?
end

two_letters = 0
three_letters = 0

def letter_count(word)
  Hash.new(0).tap do |letters|
    word.each_char { |char| letters[char] += 1 }
  end
end

entries.each do |entry|
  count = letter_count(entry)
  two_letters += 1 if count.values.include?(2)
  three_letters += 1 if count.values.include?(3)
end

puts two_letters * three_letters
