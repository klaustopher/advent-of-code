# frozen_string_literal: true

data = File.read('day-2.txt').lines

valid_passwords = 0

data.each do |input|
  match = input.match(/\A(?<min>\d+)-(?<max>\d+) (?<char>.): (?<password>.+)\Z/)

  char_count = match[:password].chars.tally.fetch(match[:char], 0)

  if char_count >= match[:min].to_i && char_count <= match[:max].to_i
    valid_passwords += 1
  end
end

puts valid_passwords
