require 'digest'

secret_key = File.read('day-4.txt').chomp

number = 1

loop do
  key = Digest::MD5.hexdigest("#{secret_key}#{number}")
  break if key.start_with?('0' * 6)
  number += 1
end

puts number
