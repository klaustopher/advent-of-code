#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read(ARGV[0]).lines.map(&:chomp)
$edges = Hash.new { |h, k| h[k] = [] }

input.each do |line|
  from, to = line.split('-')
  $edges[from] << to
  $edges[to] << from
end

def find_paths(existing_path)
  new_paths = []

  destinations = $edges[existing_path.last]
  destinations.each do |dest|
    next if dest.downcase == dest && existing_path.include?(dest) # only visit lower case rooms once

    if dest == 'end'
      new_paths << (existing_path + [dest])
    else
      new_paths += find_paths(existing_path + [dest])
    end
  end

  new_paths
end

puts find_paths(['start']).count
