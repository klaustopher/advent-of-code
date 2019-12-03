
ram = File.read('day-2.txt').split(',').map(&:to_i)
pointer = 0

ram[1] = 12
ram[2] = 2

loop do
  puts ram[(pointer)..(pointer+3)].join(',')
  if ram[pointer] == 1
    ram[ram[pointer + 3]] = ram[ram[pointer + 1]] + ram[ram[pointer + 2]]
    pointer += 4
  elsif ram[pointer] == 2
    ram[ram[pointer + 3]] = ram[ram[pointer + 1]] * ram[ram[pointer + 2]]
    pointer += 4
  elsif ram[pointer] == 99
    break
  end
end

puts ram.join(',')
