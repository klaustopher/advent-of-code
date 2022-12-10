# frozen_string_literal: true

$input = File.read('day-3.txt').lines

$number_of_rows = $input.size
$number_of_cols = $input.first.length - 1

def find_trees(step_right, step_down)
  current_row = 0
  current_col = 0

  encountered_trees = 0

  while current_row < $number_of_rows
    check = $input[current_row][current_col % $number_of_cols]

    encountered_trees += 1 if check == '#'

    current_row += step_down
    current_col += step_right
  end

  encountered_trees
end

puts [
  find_trees(1, 1),
  find_trees(3, 1),
  find_trees(5, 1),
  find_trees(7, 1),
  find_trees(1, 2)
].inject(:*)
