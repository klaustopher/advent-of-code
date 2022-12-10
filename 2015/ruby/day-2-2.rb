# frozen_string_literal: true

input = File.read('day-2.txt').lines.map { |s| s.split('x').map(&:to_i) }

sum = 0
input.each do |sides|
  sum += sides.inject(:*)
  sum += sides.sort.take(2).map { |x| 2 * x }.inject(:+)
end

puts sum
