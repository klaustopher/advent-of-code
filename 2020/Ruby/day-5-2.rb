# frozen_string_literal: true

boarding_passes = File.read('day-5.txt').lines

def seat_id(row, col)
  row * 8 + col
end

seat_ids = boarding_passes.map do |bp|
  row = bp[0..6].tr('FB', '01').to_i(2)
  col = bp[7..10].tr('LR', '01').to_i(2)

  seat_id(row, col)
end

0.upto(127).each do |row|
  0.upto(7).each do |col|
    sid = seat_id(row, col)

    if !seat_ids.include?(sid) && seat_ids.include?(sid - 1) && seat_ids.include?(sid + 1)
      puts sid
      break
    end
  end
end
