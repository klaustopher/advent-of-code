spreadsheet = File.read('day2.txt').lines.map { |line| line.split(/\s/).map(&:to_i) }

def checksum(sheet)
  sheet.sum(0) do |line|
    items = line.sort
    items.last - items.first
  end
end

puts checksum(spreadsheet)
