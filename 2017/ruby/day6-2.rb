# banks = [0, 2, 7, 0]
banks = File.read('day6.txt').split(/\s+/).map(&:to_i)

known_lookups = Hash.new { |h,k| h[k] = Array.new }

def redistribute(banks)
  max_index = banks.index(banks.max) # already implements tie-breaker
  value = banks[max_index]

  new_bank = banks.dup
  new_bank[max_index] = 0

  iterator = (max_index + 1) % banks.size

  value.times do
    new_bank[iterator] += 1
    iterator = (iterator + 1) % banks.size
  end

  new_bank
end

counter = 0

result = loop do
  counter += 1
  banks = redistribute(banks)

  break counter - known_lookups[banks].last if known_lookups[banks]&.count == 2

  known_lookups[banks.dup] << counter
end

puts result
