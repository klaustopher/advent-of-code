# frozen_string_literal: true

require 'awesome_print'

Point = Struct.new(:east, :north)

input = File.read('day-12.txt').lines.map { |line| x = line.split('', 2); [x.first.to_sym, x.last.to_i] }

$position = Point.new(0, 0)
$directions = %i[E S W N]
$direction = 0

input.each do |(action, number)|
  action = $directions[$direction] if action == :F

  case action
  when :N then $position.north += number
  when :S then $position.north -= number
  when :E then $position.east += number
  when :W then $position.east -= number
  when :R then $direction += number / 90
  when :L then $direction -= number / 90
  end

  $direction %= 4
end

puts $position.north.abs + $position.east.abs
