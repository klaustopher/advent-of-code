def distance_to_origin(square)
  square -= 1
  j = Math.sqrt(square).round
  k = (j ** 2 - square).abs - j
  p = [k, -k].map {|l| (l + j ** 2 - square - (j % 2)) * 0.5 * (-1) ** j}.map(&:to_i)

  p.first.abs + p.last.abs
end

puts distance_to_origin(1) == 0
puts distance_to_origin(12) == 3
puts distance_to_origin(23) == 2
puts distance_to_origin(1024) == 31
puts distance_to_origin(277678)

# rechts, oben
#  0, 0 = 1
#  1, 0 = 2
#  1, 1 = 3
#  0, 1 = 4
# -1, 1 = 5
# -1, 0 = 6
# -1,-1 = 7
#  0,-1 = 8
#  1,-1 = 9
#  2,-1 = 10
#  2, 0 = 11
#  2, 1 = 12
#  2, 2 = 13
#  1, 2 = 14
#  0, 2 = 15
# -1, 2 = 16
# -2, 2 = 17
# -2, 1 = 18
# -2, 0 = 19
# -2,-1 = 20
# -2,-2 = 21
# -1,-2 = 22
#  0,-2 = 23
#  1,-2 = 24
#  2,-2 = 25
#  3,-2 = 26
#  3,-1 = 27
#  3, 0 = 28
#  3, 1 = 29
#  3, 2 = 30
#  3, 3 = 31
