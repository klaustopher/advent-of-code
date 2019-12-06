lines = File.read('day-6.txt').lines

planet_map = Hash.new { |h,k| h[k] = Array.new }

lines.each do |line|
  base,orbiter = line.strip.split(')')
  planet_map[orbiter] << base
end

loop do
  planet_map.each do |orbiter, base|
    next if base.last == 'COM'
    planet_map[orbiter] += planet_map[base.last]
  end

  break if planet_map.values.all? { |arr| arr.empty? || arr.last == 'COM' }
end

puts planet_map
puts planet_map.values.flatten.count