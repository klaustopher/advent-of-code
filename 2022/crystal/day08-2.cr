# Advent of Code 2022 - Day 8
# See https://adventofcode.com/2022/day/8

data = File.read_lines("day08.txt").map { |line| line.chars.map { |val| val.to_i } }

enum Direction
  Up
  Down
  Left
  Right
end

def score(data, row, col, dir : Direction)
  value = data[row][col]
  score = 0

  return 0 if row == 0 && dir == Direction::Up
  return 0 if col == 0 && dir == Direction::Left
  return 0 if row == data.size - 1 && dir == Direction::Down
  return 0 if col == data.first.size - 1 && dir == Direction::Right

  case dir
  when Direction::Up
    (row - 1).downto(0) do |rc|
      score += 1 if data[rc][col] < value
      return score + 1 if data[rc][col] >= value
    end
  when Direction::Down
    (row + 1).upto(data.size - 1) do |rc|
      score += 1 if data[rc][col] < value
      return score + 1 if data[rc][col] >= value
    end
  when Direction::Left
    (col - 1).downto(0) do |cc|
      score += 1 if data[row][cc] < value
      return score + 1 if data[row][cc] >= value
    end
  when Direction::Right
    (col + 1).upto(data.first.size - 1) do |cc|
      score += 1 if data[row][cc] < value
      return score + 1 if data[row][cc] >= value
    end
  end

  score
end

scores = [] of Int32

0.upto(data.size - 1) do |row|
  0.upto(data.first.size - 1) do |col|
    scores << score(data, row, col, Direction::Up) *
              score(data, row, col, Direction::Left) *
              score(data, row, col, Direction::Down) *
              score(data, row, col, Direction::Right)
  end
end

puts scores.max
