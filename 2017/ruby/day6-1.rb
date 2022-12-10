#banks = [0, 2, 7, 0]
banks = File.read('day6.txt').split(/\s+/).map(&:to_i)

known_lookups = Hash.new(0)

def redistribute(banks)
  max_index = banks.index(banks.max) # already implements tie-breaker

  value = banks[max_index]
  banks[max_index] = 0

  iterator = (max_index + 1) % banks.size

  value.times do
    banks[iterator] += 1
    iterator = (iterator + 1) % banks.size
  end
end

counter = 0

loop do
  counter += 1
  redistribute(banks)

  break if known_lookups.key?(banks)

  known_lookups[banks] += 1
end

puts counter
