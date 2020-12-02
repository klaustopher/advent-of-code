#!/usr/bin/env ruby
# frozen_string_literal: true

content = File.read('day5.txt').strip

def eliminate(string)
  result = []
  eliminated = false
  index = 0

  while index < string.length - 1
    letter_a = string[index]
    letter_b = string[index + 1]

    if is_same_in_different_case?(letter_a, letter_b)
      index += 2
      eliminated = true
    else
      result << letter_a
      index += 1
    end
  end

  result << string[-1]

  [eliminated, result.join]
end

def is_same_in_different_case?(letter_a, letter_b)
  (letter_a.ord - letter_b.ord).abs == 32
end

# Strategy 1
content1 = content
loop do
  eliminated, content1 = eliminate(content1)

  unless eliminated
    puts "Shortest possible: #{content1.length}"
    break
  end
end

unique_chars = content.downcase.each_char.to_a.uniq

unique_chars.each do |uchar|
  test_content = content.gsub(uchar, '').gsub(uchar.upcase, '')

  loop do
    eliminated, test_content = eliminate(test_content)

    unless eliminated
      puts "Shortest possible by removing #{uchar}: #{test_content.length}"
      break
    end
  end
end
