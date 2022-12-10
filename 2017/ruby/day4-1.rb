passphrases = File.read('day4.txt').lines

def valid_passphrase?(passphrase)
  passphrase.split(/\s/).tally.values.all? { |count| count == 1 }
end

puts passphrases.count { |phrase| valid_passphrase?(phrase) }

