def sum(n)
  result = 0
  digits = n.digits
  half = digits.size / 2

  digits.each_with_index do |d, i|
    result += digits[i] if d == digits[(i + half) % digits.size]
  end

  result
end

# puts sum(1212) == 6
# puts sum(1221) == 0
# puts sum(123425) == 4
# puts sum(123123) == 12
# puts sum(12131515) == 4

content = File.read('day1.txt').to_i
puts sum(content)
