$input = (File.read('day-16.txt').chars.map(&:to_i) * 10_000).flatten

def pattern(index, required_size)
  n = index + 1

  base = [[0] * n, [1] * n, [0] * n, [-1] * n].flatten
  result = base * ((required_size.to_f / base.size.to_f).ceil + 1)
  result.drop(1)
end

def calculate_phase(input)
  [].tap do |result|
    0.upto(input.size - 1) do |index|
      p = pattern(index, input.size)
      result << input.zip(p).map { |(a,b)| a * b }.sum.abs % 10
    end
  end
end

result = $input
100.times do |r|
  puts "[#{Time.now}] Round #{r}"
  result = calculate_phase(result)
end

File.open('day-16-result.txt', 'w') do |f|
  f.write(result)
end

offset = result.join[0..6].to_i
puts result[offset..(offset+7)]
