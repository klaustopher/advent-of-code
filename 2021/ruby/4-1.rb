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

$drawn_numbers.each do |number|
  puts "🎲 #{number}"
  $boards.each do |board|
    mark_number(board, number)
    if has_won?(board)
      sum_of_unmarked = board.flatten.compact.sum
      puts sum_of_unmarked * number
      exit(1)
    end
  end
end
