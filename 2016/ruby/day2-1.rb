def move_accross_numpad(current, instructions)
  instructions.each do |chr|
    # for those instructions we cannot move further
    next if chr == 'L' && [1, 4, 7].include?(current) ||
      chr == 'U' && [1, 2, 3].include?(current) ||
      chr == 'R' && [3, 6, 9].include?(current) ||
      chr == 'D' && [7, 8, 9].include?(current)

    case chr
    when 'U' then current -= 3
    when 'D' then current += 3
    when 'R' then current += 1
    when 'L' then current -= 1
    end
  end

  current
end

instructions = [
  "ULL",
  "RRDDD",
  "LURDL",
  "UUUUD",
]

instructions = File.read('day2.txt').lines.map(&:chomp)

result = []
instructions.each do |str|
  result << move_accross_numpad(result.last || 5, str.chars)
end

puts result.join
