# frozen_string_literal: true

input = File.read('day-1.txt').chomp.chars

result = input.sum do |c|
  c == '(' ? 1 : -1
end

puts result
