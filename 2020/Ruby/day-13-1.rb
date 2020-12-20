input = File.read('day-13.txt').lines
# input = DATA.read.lines

arrival_time = input.first.to_i
busses = input.last.split(',').reject { |x| x == 'x' }.map(&:to_i)

deviations = busses.to_h do |bus|
  [bus, bus - arrival_time % bus]
end

lowest_bus = deviations.select { |_, v| v == deviations.values.min }.first
puts lowest_bus.inject(:*)

__END__
939
7,13,x,x,59,x,31,19
