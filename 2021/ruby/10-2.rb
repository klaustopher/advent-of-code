#!/usr/bin/env ruby
# frozen_string_literal: true

lines = File.read(ARGV[0]).lines.map(&:chomp).map(&:chars)

$matching = {
  '{' => '}',
  '[' => ']',
  '(' => ')',
  '<' => '>'
}

$values = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

def is_broken?(line)
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
      return true
    end
  end

  false
end

def missing_at_end(line)
  open_pieces = []

  line.each do |char|
    if ['(', '[', '{', '<'].include?(char)
      open_pieces << char
    elsif (char == '}' && open_pieces.last == '{') || \
          (char == ')' && open_pieces.last == '(') || \
          (char == '>' && open_pieces.last == '<') || \
          (char == ']' && open_pieces.last == '[')
      open_pieces.pop
    end
  end

  open_pieces.reverse.map { |open_char| $matching[open_char] }
end

def score(missing_characters)
  score = 0

  missing_characters.each do |char|
    score *= 5
    score += $values[char]
  end

  score
end

incomplete_lines = lines.reject { |line| is_broken?(line) }
scores = incomplete_lines.map { |line| missing_at_end(line) }.map { |missing| score(missing) }.sort
puts scores[scores.count / 2]
