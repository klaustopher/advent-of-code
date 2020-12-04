# frozen_string_literal: true

require_relative './int_computer'

# north (1), south (2), west (3), and east (4)
# wall (0), moved (1), found oxygen (2)

code = File.read('day-15.txt').split(',').map(&:to_i)

$icm = IntComputer.new(code)

$size = 20
$grid = Array.new($size) { Array.new($size) { ' ' } }

$x = $size / 2
$y = $size / 2

def paint_grid
  $grid.each_with_index do |row, _y|
    row.each_with_index do |col, _x|
      print col
    end
    puts
  end
end

def check_moves(x:, y:)
  (1..4).cycle.each do |direction|
    $icm.inputs << direction
    $icm.run

    case direction
    when 1 then y -= 1
    when 2 then y += 1
    when 3 then x -= 1
    when 4 then x += 1
    end

    out = $icm.output.shift

    case out
    when 0
      $grid[y][x] = '#'
    when 1
      $grid[y][x] = '.'
      # check_moves(x: x, y: y)
    when 2
      $grid[y][x] = 'O'
    end

    paint_grid
  end
end

check_moves(x: $size / 2, y: $size / 2)
