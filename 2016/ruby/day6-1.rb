input = File.read('day6.txt').lines.map(&:chomp)

result = Array.new

input.each do |row|
  row.chars.each_with_index do |char, pos|
    result[pos] ||= []
    result[pos] << char
  end
end

word = result.map do |pos|
  pos.tally.max_by { |_k, v| v }.first
end.join

puts word
