def calculate_fuel(mass)
  fuel_mass = (mass / 3) - 2
  return 0 if fuel_mass <= 0

  fuel_mass + calculate_fuel(fuel_mass)
end

lines = File.read('day-1-1.txt').lines
puts lines.sum { |l| calculate_fuel(l.to_i) }
