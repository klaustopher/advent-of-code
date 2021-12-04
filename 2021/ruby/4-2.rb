#!/usr/bin/env ruby

$boards = []

File.open(ARGV[0], 'r') do |file|
  $drawn_numbers = file.readline.split(',').map(&:to_i)

  while not file.eof? do
    file.readline # skip empty line
    board = []
    5.times do
      board << file.readline.split(' ').map(&:to_i)
    end

    $boards << board
  end
end

def check_winning_row(board, check_row)
  board[check_row].all? { |cell| cell.nil? }
end

def check_winning_column(board, check_col)
  board.all? { |row| row[check_col].nil? }
end

def mark_number(board, number)
  board.each_with_index do |row, row_id|
    row.each_with_index do |cell, col_id|
      if cell == number
        board[row_id][col_id] = nil
      end
    end
  end
end

def has_won?(board)
  5.times do |i|
    if check_winning_row(board, i) || check_winning_column(board, i)
      return true
    end
  end

  return false
end

last_sum_of_unmarked = 0
last_winning_number = 0
eliminiated_boards = []

$drawn_numbers.each do |number|
  puts "🎲  #{number}"
  $boards.each_with_index do |board, i|
    next if eliminiated_boards.include?(i)

    mark_number(board, number)

    if has_won?(board)
      puts "Eliminating board #{i}"
      eliminiated_boards << i
      last_sum_of_unmarked = board.flatten.compact.sum
      last_winning_number = number
    end
  end
end

puts last_sum_of_unmarked * last_winning_number
