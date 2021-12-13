#!/usr/bin/env ruby
# frozen_string_literal: true

$boards = []

File.open(ARGV[0], 'r') do |file|
  $drawn_numbers = file.readline.split(',').map(&:to_i)

  until file.eof?
    file.readline # skip empty line
    board = []
    5.times do
      board << file.readline.split.map(&:to_i)
    end

    $boards << board
  end
end

def check_winning_row(board, check_row)
  board[check_row].all?(&:nil?)
end

def check_winning_column(board, check_col)
  board.all? { |row| row[check_col].nil? }
end

def mark_number(board, number)
  board.each_with_index do |row, row_id|
    row.each_with_index do |cell, col_id|
      board[row_id][col_id] = nil if cell == number
    end
  end
end

def has_won?(board)
  5.times do |i|
    return true if check_winning_row(board, i) || check_winning_column(board, i)
  end

  false
end

$drawn_numbers.each do |number|
  puts "🎲 #{number}"
  $boards.each do |board|
    mark_number(board, number)
    next unless has_won?(board)

    sum_of_unmarked = board.flatten.compact.sum
    puts sum_of_unmarked * number
    exit(1)
  end
end
