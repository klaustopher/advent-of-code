# frozen_string_literal: true

input = File.read('day-1.txt').chomp.chars

sum = 0
input.each_with_index do |c, idx|
  sum += (c == '(' ? 1 : -1)

  if sum == - 1
    puts idx + 1
    break
  end
end
