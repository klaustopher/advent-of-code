#!/usr/bin/env ruby
# frozen_string_literal: true

require 'awesome_print'
require 'progressbar'

player_count = 464
last_marble = 70_918 * 100

ring = []

current_player = 1
current_index = nil

scores = Array.new(player_count + 1, 0)

pb = ProgressBar.create(total: last_marble, format: '%e %w')

0.upto(last_marble) do |marble|
  if current_index.nil?
    ring << marble
    current_index = 0
  elsif (marble % 23).zero?
    scores[current_player] += marble
    removing_index = (current_index - 7) % ring.size

    scores[current_player] += ring.delete_at(removing_index)
    current_index = removing_index
  else
    left = (current_index + 1) % ring.size

    ring.insert(left + 1, marble)
    current_index = left + 1
  end

  current_player = (current_player % player_count) + 1
  pb.increment
end

ap scores.max
