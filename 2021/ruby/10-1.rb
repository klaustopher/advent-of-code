#!/usr/bin/env ruby
# frozen_string_literal: true

lines = File.read(ARGV[0]).lines.map(&:chomp).map(&:chars)

$values = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}

def analyze(line)
  open_pieces = []

  line.each do |char|
    if ['(', '[', '{', '<'].include?(char)
      open_pieces << char
    elsif (char == '}' && open_pieces.last == '{') || \
          (char == ')' && open_pieces.last == '(') || \
          (char == '>' && open_pieces.last == '<') || \
          (char == ']' && open_pieces.last == '[')
      open_pieces.pop
    else
      return $values[char]
    end
  end

  0
end

puts lines.sum { |line| analyze(line) }
