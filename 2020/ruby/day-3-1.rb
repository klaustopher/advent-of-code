# frozen_string_literal: true

input = File.read('day-3.txt').lines

number_of_rows = input.size
number_of_cols = input.first.length - 1

current_row = 0
current_col = 0

encountered_trees = 0

while current_row < number_of_rows
  check = input[current_row][current_col % number_of_cols]

  encountered_trees += 1 if check == '#'

  current_row += 1
  current_col += 3
end

puts encountered_trees
