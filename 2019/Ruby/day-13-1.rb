# frozen_string_literal: true

require_relative './int_computer'

input = File.read('day-13.txt').split(',').map(&:to_i)

icm = IntComputer.new(input)
icm.run

count = 0

icm.output.each_slice(3) do |_x, _y, tile_id|
  count += 1 if tile_id == 2
end

puts count
