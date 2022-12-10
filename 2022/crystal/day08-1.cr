# Advent of Code 2022 - Day 8
# See https://adventofcode.com/2022/day/8

data = File.read_lines("day08.txt").map { |line| line.chars.map { |val| val.to_i } }

def visible?(data, row, col)
  value = data[row][col]

  return true if row == 0 || col == 0 || row == data.size - 1 || col == data.first.size - 1

  # from top
  values = [] of Int32
  0.upto(row - 1) do |rc|
    values << data[rc][col]
  end
  return true if values.all? { |v| v < value }

  # from bottom
  values = [] of Int32
  (row + 1).upto(data.size - 1) do |rc|
    values << data[rc][col]
  end
  return true if values.all? { |v| v < value }

  # from left
  values = [] of Int32
  0.upto(col - 1) do |cc|
    values << data[row][cc]
  end
  return true if values.all? { |v| v < value }

  # from right
  values = [] of Int32
  (col + 1).upto(data.first.size - 1) do |cc|
    values << data[row][cc]
  end
  return true if values.all? { |v| v < value }

  false
end

visible = 0

data.each_with_index do |row_data, row|
  row_data.each_with_index do |field, col|
    visible += 1 if visible?(data, row, col)
  end
end

puts visible
