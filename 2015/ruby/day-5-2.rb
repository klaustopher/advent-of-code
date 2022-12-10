strings = File.read("day-5.txt").lines.map(&:chomp)

def has_double_letter?(string)
  string.chars.each_cons(2).any? { |(a, b)| a == b }
end

def has_3_vowels?(string)
  string.chars.count { |l| l =~ /[aeiou]/ } >= 3
end

def does_not_contain_bad_sequences?(string)
  string !~ /(ab|cd|pq|xy)/
end

def nice?(string)
  has_double_letter?(string) && has_3_vowels?(string) && does_not_contain_bad_sequences?(string)
end

puts strings.count { |string| nice?(string) }
