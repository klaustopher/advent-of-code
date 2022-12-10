#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read(ARGV[0]).lines.map(&:chomp)
$edges = Hash.new { |h, k| h[k] = [] }
$lower_case_caves = []

input.each do |line|
  from, to = line.split('-')
  $edges[from] << to
  $edges[to] << from

  $lower_case_caves << from if from.downcase == from && from != 'start' && from != 'end'
  $lower_case_caves << to if to.downcase == to && to != 'start' && to != 'end'
end

def find_paths(existing_path, allowed_lower_case_double)
  new_paths = []

  destinations = $edges[existing_path.last]
  destinations.each do |dest|
    next if dest != allowed_lower_case_double && dest.downcase == dest && existing_path.include?(dest)
    next if dest == allowed_lower_case_double && # only allow special lowercase cave twice
            existing_path.count do |x|
              x == allowed_lower_case_double
            end >= 2

    if dest == 'end'
      new_paths << (existing_path + [dest])
    else
      new_paths += find_paths(existing_path + [dest], allowed_lower_case_double)
    end
  end

  new_paths
end

results = []
$lower_case_caves.each do |allowed_lower_case_cave|
  results += find_paths(['start'], allowed_lower_case_cave)
end

pp results.uniq.count
