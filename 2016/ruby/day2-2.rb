def move_accross_numpad(current, instructions)
  instructions.each do |chr|
    # A = 10, B = 11, C = 12, D = 13
    # for those instructions we cannot move further
    next if chr == 'L' && [1, 2, 5, 10, 13].include?(current) ||
      chr == 'U' && [5, 2, 1, 4, 9].include?(current) ||
      chr == 'R' && [1, 4, 9, 12, 13].include?(current) ||
      chr == 'D' && [5, 10, 13, 12, 9].include?(current)

    case chr
    when 'U' then current -= [6, 7, 8, 10, 11, 12].include?(current) ? 4 : 2
    when 'D' then current += [6, 7, 8, 2, 3, 4].include?(current) ? 4 : 2
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

puts result.map { |x| x.to_s(16) }.join.upcase

