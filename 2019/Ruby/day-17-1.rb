# frozen_string_literal: true

require_relative './int_computer'
require_relative './helpers'

input = File.read('day-17.txt').split(',').map(&:to_i)

icm = IntComputer.new(input)
icm.run

$grid = [
  []
]

icm.output.map(&:chr).each do |c|
  if c == "\n"
    $grid << []
  else
    $grid.last << c
  end
end

width = $grid.first.size
height = $grid.size

sum = 0

traverse_grid do |y, x, item|
  next unless item == '#'

  left = (x - 1 >= 0 && $grid[y][x - 1] == '#')
  right = (x + 1 < width && $grid[y][x + 1] == '#')
  top = (y - 1 >= 0 && $grid[y - 1][x] == '#')
  bottom = (y + 1 < height && $grid[y + 1][x] == '#')

  sum += x * y if left && right && top && bottom
end

puts sum
