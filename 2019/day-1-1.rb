def calculate_fuel(mass)
  (mass / 3) - 2
end

lines = File.read('day-1.txt').lines

puts lines.sum { |l| calculate_fuel(l.to_i) }
