# frozen_string_literal: true

require_relative './int_computer'
require 'set'

Marker = Struct.new(:x, :y, :direction) do
  def turn(left_or_right)
    case direction
    when :up
      if left_or_right == 1
        self.x += 1
        self.direction = :right
      else
        self.x -= 1
        self.direction = :left
      end
    when :down
      if left_or_right == 1
        self.x -= 1
        self.direction = :left
      else
        self.x += 1
        self.direction = :right
      end
    when :right
      if left_or_right == 1
        self.y += 1
        self.direction = :down
      else
        self.y -= 1
        self.direction = :up
      end
    when :left
      if left_or_right == 1
        self.y -= 1
        self.direction = :up
      else
        self.y += 1
        self.direction = :down
      end
    end
  end
end

code = File.read('day-11.txt').split(',').map(&:to_i)

$size = 150
$grid = Array.new($size) { Array.new($size) { 0 } }

$marker = Marker.new($size / 2, $size / 2, :up)
$grid[$marker.y][$marker.x] = 1

icm = IntComputer.new(code, inputs: [$grid[$marker.y][$marker.x]])

def paint_grid
  $grid.each_with_index do |row, y|
    row.each_with_index do |col, x|
      if $marker.x == x && $marker.y == y
        print case $marker.direction
              when :up then '^'
              when :down then 'v'
              when :right then '<'
              when :left then '>'
              end
      else
        print col == 1 ? '#' : '.'
      end
    end
    puts
  end
end

until icm.ended
  icm.run

  color = icm.output.shift
  turning_direction = icm.output.shift

  $grid[$marker.y][$marker.x] = color

  $marker.turn(turning_direction)
  icm.inputs << $grid[$marker.y][$marker.x]
end

paint_grid
