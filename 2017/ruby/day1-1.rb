def sum(n)
  result = 0
  digits = n.digits
  digits << digits.first

  digits.each_cons(2) do |a, b|
    result += a if a == b
  end

  result
end

content = File.read('day1.txt').to_i
puts sum(content)
