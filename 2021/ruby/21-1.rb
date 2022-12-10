#!/usr/bin/env ruby
# frozen_string_literal: true

# Advent of Code 2021 - Day 21

$data = File.read(ARGV[0]).lines.map(&:chomp)

$positions = {}
$scores = {}
$players = []

$data.each do |line|
  player, starting_field = line.scan(/Player (\d+) starting position: (\d+)/).first.map(&:to_i)
  $positions[player - 1] = starting_field - 1
  $scores[player - 1] = 0
end

class DeterministicDie
  attr_reader :rolls

  def initialize
    @rolls = 0
    @next_number = 1
  end

  def roll(number)
    @rolls += number

    [].tap do |result|
      number.times do
        result << @next_number
        @next_number += 1
        @next_number %= 100 if @next_number > 100
      end
    end
  end
end

die = DeterministicDie.new
winner = nil
while winner.nil?
  $positions.each_key do |player|
    rolls = die.roll(3)

    $positions[player] = ($positions[player] + rolls.sum) % 10
    $scores[player] += $positions[player] + 1

    if $scores[player] >= 1000
      winner = player
      break
    end
  end
end

puts die.rolls * $scores[(winner + 1) % 2]
