spreadsheet = File.read('day2.txt').lines.map { |line| line.split(/\s/).map(&:to_i) }

def checksum(sheet)
  sheet.sum do |line|
    line.permutation(2).each do |(a, b)|
      break a/b if a % b == 0
    end
  end
end

puts checksum([
  [5,9,2,8],
  [9,4,7,3],
  [3,8,6,5],
])

puts checksum(spreadsheet)

