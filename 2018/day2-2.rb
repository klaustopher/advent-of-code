#!/usr/bin/env ruby
require 'set'

entries = []

File.open('day2.txt', 'r') do |f|
  while !f.eof?
    entries << f.readline.strip
  end
end

def div_letter_count(a_word, b_word)
  a_array = a_word.each_char.to_a
  b_array = b_word.each_char.to_a

  count = 0

  a_array.zip(b_array).each do |(a, b)|
    count += 1 if a != b
  end

  count
end

def same_letters(a_word, b_word)
  a_array = a_word.each_char.to_a
  b_array = b_word.each_char.to_a

  word = []

  a_array.zip(b_array).each do |(a, b)|
    word << a if a == b
  end

  word.join('')
end


entries.each do |entry_a|
  entries.each do |entry_b|
    next if entry_a == entry_b

    number = div_letter_count(entry_a, entry_b)
    puts same_letters(entry_a, entry_b) if number == 1
  end
end