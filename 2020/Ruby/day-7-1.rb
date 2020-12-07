# frozen_string_literal: true

require 'awesome_print'
require 'set'

$bags = Set.new

$input = File.read('day-7.txt').lines.map do |line|
  matches = line.match(/\A(.+) bags contain (.+)\.\Z/)
  parent_bag = matches[1]

  $bags << parent_bag

  kid_bags = matches[2]
             .split(',')
             .map(&:strip)
             .map do |kids|
    kr = kids.match(/(\d+|no) (.+) bags?/)
    if kr[1] == 'no' && kr[2] == 'other'
      nil
    else
      $bags << kr[2]
      [kr[2], kr[1].to_i]
    end
  end.compact.to_h

  [parent_bag, kid_bags]
end.to_h

search = 'shiny gold'

def recursive_search_path(bag, goal)
  if $input[bag].count.zero?
    []
  elsif $input[bag].key?(goal)
    [bag]
  else
    $input[bag].map do |(new_bag_for_path, _)|
      result = recursive_search_path(new_bag_for_path, goal)
      [bag] + result if result.count.positive?
    end.compact
  end
end

puts $bags.map { |bag| recursive_search_path(bag, search) }.flatten.uniq.count
