triangles = File.read('day3.txt').lines.map(&:strip).map { |line| line.split(/\s+/).map(&:to_i) }


puts triangles.count { |a, b, c| a + b > c && a + c > b && b + c > a }

