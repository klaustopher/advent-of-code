# frozen_string_literal: true

require 'awesome_print'

Point = Struct.new(:east, :north)

input = File.read('day-12.txt').lines.map { |line| x = line.split('', 2); [x.first.to_sym, x.last.to_i] }

$ship = Point.new(0, 0)
$waypoint = Point.new(10, 1)

input.each do |(action, number)|
  case action
  when :F
    $ship.north += $waypoint.north * number
    $ship.east += $waypoint.east * number
  when :N then $waypoint.north += number
  when :S then $waypoint.north -= number
  when :E then $waypoint.east += number
  when :W then $waypoint.east -= number
  when :R, :L
    if number == 180
      $waypoint.north *= -1
      $waypoint.east *= -1
    elsif (action == :R && number == 90) || (action == :L && number == 270)
      $waypoint.north, $waypoint.east = $waypoint.east * -1, $waypoint.north
    elsif (action == :R && number == 270) || (action == :L && number == 90)
      $waypoint.north, $waypoint.east = $waypoint.east, $waypoint.north * -1
    end
  end

  puts "ship (#{$ship.east},#{$ship.north}) waypoint (#{$waypoint.east}, #{$waypoint.north})"
end

puts $ship.north.abs + $ship.east.abs
