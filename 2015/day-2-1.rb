# frozen_string_literal: true

def area(l, w, h)
  2 * l * w + 2 * w * h + 2 * h * l
end

input = File.read('day-2.txt').lines.map { |s| s.split('x').map(&:to_i) }

sum = 0
input.each do |(l, w, h)|
  sum += area(l, w, h)
  sum += [l, w, h].sort.take(2).inject(:*)
end

puts sum
