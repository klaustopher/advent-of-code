input = File.read('day3.txt').lines.map(&:strip).map { |line| line.split(/\s+/).map(&:to_i) }

=begin
input = [
 [101, 301, 501],
 [102, 302, 502],
 [103, 303, 503],
 [201, 401, 601],
 [202, 402, 602],
 [203, 403, 603],
]
=end

triangles = []

input.each_slice(3) do |three_rows|
  0.upto(2) do |x|
    triangles << [three_rows[0][x], three_rows[1][x], three_rows[2][x]]
  end
end

puts triangles.count { |a, b, c| a + b > c && a + c > b && b + c > a }

