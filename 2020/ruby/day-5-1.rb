# frozen_string_literal: true

boarding_passes = File.read('day-5.txt').lines

seat_ids = boarding_passes.map do |bp|
  row = bp[0..6].tr('FB', '01').to_i(2)
  col = bp[7..10].tr('LR', '01').to_i(2)

  row * 8 + col
end

puts seat_ids.max
