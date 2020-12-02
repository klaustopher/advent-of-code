# frozen_string_literal: true

data = File.read('day-2.txt').lines

valid_passwords = 0

data.each do |input|
  match = input.match(/\A(?<pos1>\d+)-(?<pos2>\d+) (?<char>.): (?<password>.+)\Z/)

  char1 = match[:password][match[:pos1].to_i - 1]
  char2 = match[:password][match[:pos2].to_i - 1]

  valid_passwords += 1 if (char1 == match[:char]) ^ (char2 == match[:char])
end

puts valid_passwords
