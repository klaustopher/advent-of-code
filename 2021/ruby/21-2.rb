#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2021 - Day 21

$data = File.read(ARGV[0]).lines.map(&:chomp)

Universe = Struct.new(:p1_position, :p2_position, :p1_score, :p2_score, :current_player, :multiplier,
                      keyword_init: true)

$initial_positions = {}
$probabilities = [1, 2, 3].repeated_permutation(3).map(&:sum).tally
$possible_numbers = [1, 2, 3].repeated_permutation(3).map(&:sum).uniq

$data.each do |line|
  player, starting_field = line.scan(/Player (\d+) starting position: (\d+)/).first.map(&:to_i)
  $initial_positions[player] = starting_field - 1
end

$wins = Hash.new(0)

initial_universe = Universe.new(
  p1_position: $initial_positions[1],
  p2_position: $initial_positions[2],
  p1_score: 0,
  p2_score: 0,
  current_player: 1,
  multiplier: 1
)

def play_game(universe)
  $possible_numbers.each do |roll|
    next_universe = universe.dup

    if universe.current_player == 1
      next_universe.p1_position = (next_universe.p1_position + roll) % 10
      next_universe.p1_score += next_universe.p1_position + 1
      next_universe.multiplier *= $probabilities[roll]

      if next_universe.p1_score >= 21
        $wins[1] += next_universe.multiplier
      else
        next_universe.current_player = 2
        play_game(next_universe)
      end
    else
      next_universe.p2_position = (next_universe.p2_position + roll) % 10
      next_universe.p2_score += next_universe.p2_position + 1
      next_universe.multiplier *= $probabilities[roll]

      if next_universe.p2_score >= 21
        $wins[2] += next_universe.multiplier
      else
        next_universe.current_player = 1
        play_game(next_universe)
      end
    end
  end
end

play_game(initial_universe)

pp $wins.values.max
