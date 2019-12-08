input = File.read('day-8.txt')

width = 25
height = 6

layers = input.scan(/\d{#{width * height}}/)

with_fewest_zeros = layers.sort_by { |a| a.count("0") }.first

puts with_fewest_zeros.count("1") * with_fewest_zeros.count("2") 