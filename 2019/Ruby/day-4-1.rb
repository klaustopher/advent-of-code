range = (246515..739105)

def correct_password?(input)
  digits = input.digits.reverse

  has_double = false
  increase_only = true
  digits.each_cons(2) do |a,b|
    has_double |= (a==b)
    increase_only &= (a<=b)
  end

  return has_double && increase_only
end

working_passwords = range.select { |r| correct_password?(r) }
puts working_passwords.count
puts ""
puts working_passwords

