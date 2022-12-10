# frozen_string_literal: true

def correct_password?(input)
  puts input
  digits = input.digits.reverse

  last_double = nil
  increase_only = true
  has_double = false
  streak = 0

  digits.each_cons(2) do |a, b|
    increase_only &= (a <= b)

    if a == b
      if !last_double
        # No double encountered yet, store the number that made the double
        # and start a streak
        last_double = a
        streak = 2
      elsif last_double == b
        # We encountered the same number again, let's increase the streak
        streak += 1
      end
    elsif a != b && last_double
      # our a=b is different from last_double, so we can reset it

      # if our streak was only 2, let's store it on has_double
      has_double |= (streak == 2)
      last_double = nil
    end
  end

  # End check. If we had a double at the end, check if the streak was two
  has_double |= true if streak == 2

  has_double && increase_only
end

# puts 699999, correct_password?(699999)
# puts 255777, correct_password?(255777)
# puts 688899, correct_password?(688899)
# puts 668889, correct_password?(668889)

range = (246_515..739_105)
working_passwords = range.select { |r| correct_password?(r) }
puts working_passwords.count
# puts ""
# puts working_passwords
